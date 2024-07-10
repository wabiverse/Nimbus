/* ----------------------------------------------------------------
 * :: :  M  E  T  A  V  E  R  S  E  :                            ::
 * ----------------------------------------------------------------
 * This software is Licensed under the terms of the Apache License,
 * version 2.0 (the "Apache License") with the following additional
 * modification; you may not use this file except within compliance
 * of the Apache License and the following modification made to it.
 * Section 6. Trademarks. is deleted and replaced with:
 *
 * Trademarks. This License does not grant permission to use any of
 * its trade names, trademarks, service marks, or the product names
 * of this Licensor or its affiliates, except as required to comply
 * with Section 4(c.) of this License, and to reproduce the content
 * of the NOTICE file.
 *
 * This software is distributed in the hope that it will be useful,
 * but WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND without even an
 * implied warranty of MERCHANTABILITY, or FITNESS FOR A PARTICULAR
 * PURPOSE. See the Apache License for more details.
 *
 * You should have received a copy for this software license of the
 * Apache License along with this program; or, if not, please write
 * to the Free Software Foundation Inc., with the following address
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
 *
 *         Copyright (C) 2024 Wabi Foundation. All Rights Reserved.
 * ----------------------------------------------------------------
 *  . x x x . o o o . x x x . : : : .    o  x  o    . : : : .
 * ---------------------------------------------------------------- */

import Darwin
import Foundation
import Logging
import MQTTNIO
import NIO

public struct MQTTNimbusClient
{
  public let connection: MQTTNimbusConnection
  public let mqttClient: MQTTClient
  public let topicName: String
  public let logger: Logger = {
    var logger = Logger(label: "Nimbus")
    logger.logLevel = .trace
    return logger
  }()

  public let closePromise: EventLoopPromise<Void>

  public init(connection: MQTTNimbusConnection)
  {
    self.connection = connection
    topicName = "MQTTNimbus-\(self.connection.topic)"
    mqttClient = MQTTClient(
      host: connection.servername,
      port: connection.port,
      identifier: "MQTTNimbus-\(connection.username)",
      eventLoopGroupProvider: .createNew,
      logger: nil
    )
    closePromise = mqttClient.eventLoopGroup.next().makePromise()
  }

  public func syncShutdown() throws
  {
    try mqttClient.syncShutdownGracefully()
  }

  public func run() throws
  {
    logger.info("Connecting to \(connection.topic)")
    let setupFuture = setup()
    setupFuture.cascadeFailure(to: closePromise)
    setupFuture.whenSuccess
    { _ in
      logger.info("Connected to \(connection.topic)")

      DispatchQueue.global().async
      {
        while true
        {
          prompt()
          if let line = readLine()
          {
            _ = sendMessage(line)
          }
        }
      }
    }

    do
    {
      // wait on closePromise
      try closePromise.futureResult.wait()

      // disconnect and shutdown
      try mqttClient.disconnect().wait()
      try mqttClient.syncShutdownGracefully()
    }
    catch
    {
      deleteCurrentLine()
      logger.info("Error: \(error)")
    }
  }

  public func setup() -> EventLoopFuture<Void>
  {
    // connect, subscribe and publish joined message
    mqttClient.connect(cleanSession: true).flatMap
    { _ -> EventLoopFuture<Void> in
      let subscription = MQTTSubscribeInfo(topicFilter: topicName, qos: .exactlyOnce)
      return mqttClient.subscribe(to: [subscription]).map { _ in }
    }
    .flatMap
    { _ in
      addListeners()
      return sendMessage("Joined!")
    }
  }

  public func addListeners()
  {
    mqttClient.addPublishListener(named: "ListenForNimbus")
    { result in
      switch result
      {
        case let .failure(error):
          closePromise.fail(error)
        case let .success(publishInfo):
          if publishInfo.topicName == topicName
          {
            receiveMessage(publishInfo.payload)
          }
      }
    }

    mqttClient.addCloseListener(named: "CheckForClose")
    { _ in
      closePromise.fail(MQTTNimbusClient.Error(kind: .lostConnection))
    }
  }

  public func sendMessage(_ message: String) -> EventLoopFuture<Void>
  {
    let packet = MQTTNimbusPacket(from: connection.username, message: message)
    var buffer = ByteBufferAllocator().buffer(capacity: 0)
    try? JSONEncoder().encode(packet, into: &buffer)
    return mqttClient.publish(to: topicName, payload: buffer, qos: .exactlyOnce)
  }

  public func receiveMessage(_ buffer: ByteBuffer)
  {
    if let packet = try? JSONDecoder().decode(MQTTNimbusPacket.self, from: buffer)
    {
      guard packet.from != connection.username else { return }
      outputAndReplacePrompt("\(packet.from): \(packet.message)")
    }
  }

  public func deleteCurrentLine()
  {
    logger.info("\u{1b}[0G\u{1b}[K")
  }

  public func prompt()
  {
    logger.info("\(connection.username): ")
    fflush(stdout)
  }

  public func outputAndReplacePrompt(_ string: String)
  {
    deleteCurrentLine()
    logger.info("\(string)")
    prompt()
  }
}
