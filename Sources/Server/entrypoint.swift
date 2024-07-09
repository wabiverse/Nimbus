/* ----------------------------------------------------------------
 * :: :  N  I  M  B  U  S  :                                     ::
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

import Logging
import NIOCore
import NIOPosix
import Vapor

@main
enum Creator
{
  static func main() async throws
  {
    var env = try Environment.detect()
    try LoggingSystem.bootstrap(from: &env)

    let app = try await Application.make(env)

    // This attempts to install NIO as the Swift Concurrency global executor.
    // You should not call any async functions before this point.
    let executorTakeoverSuccess = NIOSingletons.unsafeTryInstallSingletonPosixEventLoopGroupAsConcurrencyGlobalExecutor()
    app.logger.debug("Running with \(executorTakeoverSuccess ? "SwiftNIO" : "standard") Swift Concurrency default executor")

    do
    {
      try await configure(app)
    }
    catch
    {
      app.logger.report(error: error)
      try? await app.asyncShutdown()
      throw error
    }
    try await app.execute()
    try await app.asyncShutdown()
  }
}
