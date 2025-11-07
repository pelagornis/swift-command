// swift-tools-version: 6.1
import PackageDescription

let package = Package(
    name: "swift-command",
    platforms: [.macOS(.v11)],
    products: [
        .library(
            name: "Command",
            targets: ["Command"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.4.3"),
        .package(url: "https://github.com/apple/swift-log", from: "1.6.3"),
        .package(url: "https://github.com/pelagornis/swift-file", .upToNextMajor(from: "1.4.1"))
    ],
    targets: [
        .target(
            name: "Command",
            dependencies: [
                .product(name: "File", package: "swift-file"),
                .product(name: "Logging", package: "swift-log"),
            ]
        ),
        .testTarget(
            name: "CommandTests",
            dependencies: ["Command"]
        ),
    ]
)
