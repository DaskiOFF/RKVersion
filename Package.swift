// swift-tools-version:5.10
import PackageDescription

let package = Package(
    name: "RKVersion",
    platforms: [
        .iOS(.v14),
        .macOS(.v13),
    ],
    products: [
        .library(
            name: "RKVersion",
            type: .static,
            targets: ["RKVersion"]),
    ],
    targets: [
        .target(
            name: "RKVersion",
            dependencies: []),
        .testTarget(
            name: "RKVersionTests",
            dependencies: ["RKVersion"]),
    ]
)
