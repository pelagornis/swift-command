import File

/// Support Swift Package Command
public struct SwiftPackage {
    @Command(\.bash) private var bash

    /// Enum defining available package types when using the Swift Package Manager
    public enum SwiftPackageType: String {
        case library
        case executable
        case empty
    }

    /// Enum defining available build configurations when using the Swift Package Manager
    public enum SwiftBuildConfiguration: String {
        case debug
        case release
    }

    /// Create a Swift package
    ///
    /// - Parameter type: Swift Package Type for options
    @discardableResult
    public func create(at path: Path?, type: SwiftPackageType = .library) -> Result {
        return run(at: path, ["package", "init", "--type", "\(type.rawValue)"])
    }

    /// Update package dependencies
    @discardableResult
    public func update(at path: Path?) -> Result {
        return run(at: path, ["package", "update"])
    }

    /// Generate Xcode Project for a Swift Package
    @discardableResult
    public func generateXcodeproj(at path: Path?) -> Result {
        return run(at: path, ["package", "generate-xcodeproj"])
    }

    /// Build a Swift Package
    ///
    /// - Parameter configuration: swift build configuration options
    @discardableResult
    public func build(at path: Path?, configuration: SwiftBuildConfiguration = .debug) -> Result {
        return run(at: path, ["build", "-c", "\(configuration.rawValue)"])
    }

    /// Test a Swift Package
    ///
    /// - Parameter configuration: swift test configuration options
    @discardableResult
    public func test(at path: Path?, configuration: SwiftBuildConfiguration = .debug) -> Result {
        return run(at: path, ["test", "-c", "\(configuration.rawValue)"])
    }

    /// Running Swift Command
    @discardableResult
    public func run(at path: Path?, _ arguments: [String]) -> Result {
        let command = ["swift"] + arguments
        let arguments = Arguments(command)
        return bash.run(arguments, directory: path)
    }
}

extension CommandValues {
    /// Support Swift Package Command
    public var package: SwiftPackage {
        SwiftPackage()
    }
}
