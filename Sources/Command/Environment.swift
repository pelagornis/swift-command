import Foundation

/// Represents an environment for a command to run in.
public struct Environment {
    /// The environment variables.
    public private(set) var data: [String : String] = [:]
    /// The global environment for all commands.
    public static var global = Environment()
    /// Creates a new environment.
    /// - Parameter data: The environment variables for the command. Defaults to the current process's environment.
    public init(_ data: [String : String] = ProcessInfo.processInfo.environment) {
        self.data = data
    }
    /// Accesses an environment variable by name.
    /// - Parameter key: The name of the environment variable.
    /// - Returns: The value of the environment variable, or `nil` if it is not set.
    public subscript(_ key: String) -> String? {
        get {
            return data[key]
        }
        set(newValue) {
            data[key] = newValue
        }
    }
    /// Adds a directory to the PATH environment variable.
    /// - Parameter path: The directory to add.
    mutating func add(_ path: String) {
        data["PATH"] = data["PATH"] == nil ? path : "\(path):\(data["PATH"]!)"
    }
}

extension Environment: ExpressibleByDictionaryLiteral {
    public init(dictionaryLiteral elements: (String, String)...) {
        self.init(elements.reduce(into: [String : String](), { $0[$1.0] = $1.1 }))
    }
}

extension Environment: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.data == rhs.data
    }
}
