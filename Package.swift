// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "swift-command",
    platforms: [.macOS(.v10_15)],
    products: [
        .library(
            name: "Command",
            targets: ["Command"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.4.3"),
        .package(url: "https://github.com/apple/swift-log", from: "1.6.3")
    ],
    targets: [
        .target(
            name: "Command",
            dependencies: [
                .product(name: "Logging", package: "swift-log"),
            ]
        ),
        .testTarget(
            name: "CommandTests",
            dependencies: ["Command"]
        ),
    ]
)
