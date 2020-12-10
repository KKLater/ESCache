// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ESCache",
    platforms: [.iOS(.v9), .macOS(.v10_10), .tvOS(.v10), .watchOS(.v3)],
    products: [
        .library(name: "ESCache", targets: ["ESCache"]),
    ],
    targets: [
        .target(name: "ESCache", dependencies: []),
        .testTarget(name: "ESCacheTests", dependencies: ["ESCache"]),
    ]
)
