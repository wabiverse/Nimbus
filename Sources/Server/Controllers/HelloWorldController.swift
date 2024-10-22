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

import PixarUSD
import Vapor

/**
 * Dumb http 'router', dynamically authoring scene description
 * upon visiting its various router urls in context, spitting
 * out the underlying Usd.Stage as a string in the body of each
 * of its 'get' request responses. */
public class HelloWorldController: RouteCollection, @unchecked Sendable
{
  private let stage: UsdStageRefPtr

  public init()
  {
    /* Setup all usd resources (python, plugins, resources). */
    #if os(iOS) || os(visionOS) || os(tvOS) || os(watchOS)
      Pixar.Bundler.shared.setup(.resources, installPlugins: true)
    #else
      Pixar.Bundler.shared.setup(.resources, installPlugins: false)
    #endif

    stage = Usd.Stage.createNew("HelloWorld", ext: .usd)

    UsdGeom.Xform.define(stage, path: "/hello")
    UsdGeom.Sphere.define(stage, path: "/hello/world")

    stage.save()
  }

  public func boot(routes: RoutesBuilder) throws
  {
    let hello = routes.grouped("hello")
    hello.get(use: index)

    hello.group("world")
    { world in
      world.get(use: show)
    }
  }

  @Sendable
  public func index(req _: Request) async throws -> UsdStageRefPtr
  {
    togglePrim(active: false)

    return stage
  }

  @Sendable
  public func show(req _: Request) async throws -> UsdStageRefPtr
  {
    togglePrim(active: true)

    return stage
  }

  private func togglePrim(active: Bool, atPath primPath: String = "/hello/world")
  {
    DispatchQueue.stageMutatingLock.sync
    {
      let prim = self.stage.getPrim(at: primPath)
      prim.set(active: active)
      self.stage.save()
    }
  }
}

/**
 * Extension on references to Usd.Stage, to return
 * Usd.Stage references directly as perfectly compliant
 * HTTP responses. */
extension UsdStageRefPtr: AsyncResponseEncodable
{
  public func encodeResponse(for request: Request) async throws -> Response
  {
    let body: Response.Body

    var result = ""
    exportToString(&result, addSourceFileComment: false)

    if !result.isEmpty
    {
      body = .init(string: result)
    }
    else
    {
      body = .empty
    }

    return Response(
      status: .ok,
      headers: request.headers,
      body: body
    )
  }
}

public extension DispatchQueue
{
  static let stageMutatingLock = DispatchQueue(label: "stage.lock.queue")
}
