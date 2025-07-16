/// The result of a command execution.
public enum Result {
    /// The command was successful.
    case success(_ req: Request, _ res: Response)
    /// The command failed.
    case failure(_ req: Request, _ res: Response)
}

public extension Result {
    /// The request that was executed.
    var request: Request {
        switch self {
        case .success(let request, _):
            return request
        case .failure(let request, _):
            return request
        }
    }
    /// The response from the executed command.
    var response: Response {
        switch self {
        case .success(_, let response):
            return response
        case .failure(_, let response):
            return response
        }
    }
    /// The status code of the response.
    var statusCode: Int32 {
        return response.statusCode
    }
    /// The output of the command.
    var output: String {
        return response.output
    }
    /// The error output of the command.
    var errorOutput: String {
        return response.error
    }
}

extension Request: Equatable {
    /// Returns a Boolean value indicating whether two requests are equal.
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.environment == rhs.environment
        && lhs.executableURL == rhs.executableURL
        && lhs.dashc == rhs.dashc
        && lhs.arguments == rhs.arguments
        && lhs.audited == rhs.audited
    }
}
