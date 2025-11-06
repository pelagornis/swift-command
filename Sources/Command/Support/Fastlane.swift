import File
/// Support Fastlane Command
public struct Fastlane {
    @Command(\.bash) var bash

    /// Setting up fastlane
    @discardableResult
    public func `init`(at path: Path?) -> Result {
        run(at: path, ["init"])
    }

    /// Running iOS tests using fastlane
    @discardableResult
    public func tests(at path: Path?) -> Result {
        run(at: path, ["tests"])
    }

    /// Running Snapshot
    @discardableResult
    public func snapshot(at path: Path?) -> Result {
        run(at: path, ["snapshot"])
    }

    /// Upload Screenshots to the App Store
    @discardableResult
    public func deliver(at path: Path?) -> Result {
        run(at: path, ["deliver"])
    }

    /// Screenshots Into Device Frames
    @discardableResult
    public func frameit(at path: Path?) -> Result {
        run(at: path, ["frameit"])
    }

    /// Run Fastlane Command
    @discardableResult
    public func run(at path: Path?, _ arguments: [String]) -> Result {
        let command = ["fastlane"] + arguments
        let arguments = Arguments(command)
        return bash.run(arguments, directory: path)
    }
}

extension CommandValues {
    /// Support Fastlane Command
    public var fastlane: Fastlane {
        Fastlane()
    }
}
