/// An alias for a command-line tool that can be run with `Command`.
public struct Alias {
    /// The URL of the executable to run.
    public let executableURL: String
    /// The arguments to pass to the `-c` option of the command, if any.
    public let dashc: Arguments?
    /// Creates a new `Alias`.
    /// - Parameters:
    ///   - executableURL: The path to the executable.
    ///   - dashc: The arguments for the `-c` option, if needed.
    public init(
        executableURL: String,
        dashc: Arguments? = nil
    ) {
        self.executableURL = executableURL
        self.dashc = dashc
    }
}

public extension Alias {
    /// Prepares a `Request` for this alias.
    /// - Parameters:
    ///   - arguments: Arguments to pass.
    ///   - environment: Environment variables.
    ///   - directory: Working directory.
    /// - Returns: A `Request` instance.
    func prepare(
        _ arguments: Arguments?,
        environment: Environment?,
        directory: String?
    ) -> Request {
        Request(
            environment: environment,
            executableURL: executableURL,
            dashc: dashc,
            arguments: arguments,
            directory: directory
        )
    }

    /// Runs the alias with the given arguments and options.
    /// - Returns: The result of running the command.
    @discardableResult
    func run(
        _ arguments: Arguments? = nil,
        environment: Environment = .global,
        directory: String? = nil,
        log: Bool = false
    ) -> Result {
        let req = prepare(
            arguments,
            environment: environment,
            directory: directory
        )
        return Task().run(req, log: log)
    }
}
