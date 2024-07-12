// swift-tools-version:5.10
import PackageDescription

let package = Package(
  name: "Nimbus",
  platforms: [
    .macOS(.v14),
    .visionOS(.v1),
    .iOS(.v17),
    .tvOS(.v17),
    .watchOS(.v10)
  ],
  products: [
    .library(name: "NimbusModels", targets: ["NimbusModels"]),
    .library(name: "NimbusClient", targets: ["NimbusClient"]),
    .executable(name: "Server", targets: ["Server"])
  ],
  dependencies: [
    // 💧 A server-side Swift web framework.
    .package(url: "https://github.com/vapor/vapor.git", from: "4.102.0"),
    // 🛰️ Non-blocking, event-driven networking for Swift, used for custom executors.
    .package(url: "https://github.com/apple/swift-nio.git", from: "2.67.0"),
    // 💬 Message queuing telemetry transport, for Pub<->Sub messaging between clients.
    .package(url: "https://github.com/swift-server-community/mqtt-nio", revision: "b56887a"),
    // 🌌 Pixar's universal scene description for Swift, for building the metaverse.
    .package(url: "https://github.com/wabiverse/SwiftUSD.git", from: "23.11.41"),
  ],
  targets: [
    .target(name: "NimbusModels"),
    .target(
      name: "NimbusClient",
      dependencies: [
        .product(name: "Vapor", package: "vapor"),
        .product(name: "NIOCore", package: "swift-nio"),
        .product(name: "NIOPosix", package: "swift-nio"),
        .product(name: "MQTTNIO", package: "mqtt-nio"),
        .product(name: "PixarUSD", package: "SwiftUSD"),
        .target(name: "NimbusModels"),
      ],
      swiftSettings: swiftSettings
    ),
    .executableTarget(
      name: "Server",
      dependencies: [
        .product(name: "Vapor", package: "vapor"),
        .product(name: "NIOCore", package: "swift-nio"),
        .product(name: "NIOPosix", package: "swift-nio"),
        .product(name: "MQTTNIO", package: "mqtt-nio"),
        .product(name: "PixarUSD", package: "SwiftUSD"),
        .target(name: "NimbusClient"),
      ],
      swiftSettings: swiftSettings
    ),
    .testTarget(
      name: "ServerTests",
      dependencies: [
        .target(name: "Server"),
        .product(name: "XCTVapor", package: "vapor"),
      ],
      swiftSettings: swiftSettings
    )
  ],
  cxxLanguageStandard: .cxx17
)

var swiftSettings: [SwiftSetting] { [
  .enableUpcomingFeature("DisableOutwardActorInference"),
  .enableExperimentalFeature("StrictConcurrency"),
  .interoperabilityMode(.Cxx)
] }
