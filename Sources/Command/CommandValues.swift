/// A collection of globally available command-line tool aliases.
///
/// Extend this struct to add custom command aliases.
public struct CommandValues: Sendable {
    /// The current task-local command values.
    @TaskLocal public static var current = Self()
    /// Creates a new instance of `CommandValues`.
    public init() {}
}
