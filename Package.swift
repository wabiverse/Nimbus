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
  dependencies: [
    // 💧 A server-side Swift web framework.
    .package(url: "https://github.com/vapor/vapor.git", from: "4.102.0"),
    // 🏃 Non-blocking, event-driven networking for Swift, used for custom executors.
    .package(url: "https://github.com/apple/swift-nio.git", from: "2.67.0"),
    // 🌌 Pixar's universal scene description for Swift, for building the metaverse.
    .package(url: "https://github.com/wabiverse/SwiftUSD.git", from: "23.11.39"),
  ],
  targets: [
    .executableTarget(
      name: "Server",
      dependencies: [
        .product(name: "Vapor", package: "vapor"),
        .product(name: "NIOCore", package: "swift-nio"),
        .product(name: "NIOPosix", package: "swift-nio"),
        .product(name: "PixarUSD", package: "SwiftUSD"),
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
