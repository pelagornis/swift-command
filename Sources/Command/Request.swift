import Foundation

/// Represents a command execution request.
public struct Request {
    /// The environment to use for the command.
    public var environment: Environment?
    /// The URL of the executable to run.
    public var executableURL: String
    /// Arguments to pass to the command with the `-c` flag.
    public var dashc: Arguments?
    /// Arguments to pass to the command.
    public var arguments: Arguments?
    /// Directory to run the command in.
    public let directory: String?
    /// Whether the command should be audited.
    public let audited: Bool
    /// Creates a new request.
    /// - Parameters:
    ///   - environment: The environment to use.
    ///   - executableURL: The path to the executable.
    ///   - dashc: Arguments for the `-c` flag.
    ///   - arguments: Arguments to pass to the command.
    ///   - directory: Working directory.
    ///   - audited: Whether to audit the command.
    public init(
        environment: Environment? = .global,
        executableURL: String,
        dashc: Arguments? = nil,
        arguments: Arguments? = nil,
        directory: String? = nil,
        audited: Bool = true
    ) {
        self.environment = environment
        self.executableURL = executableURL
        self.dashc = dashc
        self.arguments = arguments
        self.directory = directory
        self.audited = audited
    }
    /// Returns a copy of the request with updated environment variables.
    /// - Parameter env: The environment variables to set.
    /// - Returns: A new `Request` with the updated environment.
    public func withEnvironment(_ env: [String: String]) -> Request {
        var newEnv = self.environment ?? .global
        for (k, v) in env { newEnv[k] = v }
        return Request(environment: newEnv, executableURL: self.executableURL, dashc: self.dashc, arguments: self.arguments, directory: self.directory, audited: self.audited)
    }
    /// Returns a copy of the request with a new working directory.
    /// - Parameter dir: The new working directory.
    /// - Returns: A new `Request` with the updated directory.
    public func withDirectory(_ dir: String) -> Request {
        return Request(environment: self.environment, executableURL: self.executableURL, dashc: self.dashc, arguments: self.arguments, directory: dir, audited: self.audited)
    }
}

private extension Request {
    func getAbsoluteExecutableURL() -> String {
        if FileManager.default.fileExists(atPath: executableURL) {
            return executableURL
        }
        guard let environment = environment else {
            return executableURL
        }
        let paths = environment["PATH"]?.split(separator: ":").map{ String($0) } ?? []
        guard paths.count > 0 else {
            return executableURL 
        }
        for path in paths {
            let absoluteExecutableURL = "\(path)/\(executableURL)"
            if FileManager.default.fileExists(atPath: absoluteExecutableURL) {
                return absoluteExecutableURL
            }
        }
        return executableURL
    }
}
