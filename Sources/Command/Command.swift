/// A property wrapper for accessing command-line tools via `CommandValues`.
///
/// Usage:
/// ```swift
/// @Command(\.bash) var bash
/// let result = bash.run("echo Hello")
/// ```
@propertyWrapper
public struct Command<Value>: @unchecked Sendable {
    /// The key path to the command value in CommandValues.
    private let keyPath: KeyPath<CommandValues, Value>

    /// Creates a command property to read the specified key path.
    /// - Parameter keyPath: A key path to a specific resulting value.
    public init(_ keyPath: KeyPath<CommandValues, Value>) {
        self.keyPath = keyPath
    }

    /// The current value of the command property.
    public var wrappedValue: Value {
        let current = CommandValues.current
        return CommandValues.$current.withValue(current) {
            CommandValues.current[keyPath: self.keyPath]
        }
    }
}
