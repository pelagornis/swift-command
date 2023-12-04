/// Support Tuist Command
public struct Tuist {
    @Command(\.bash) private var bash

    /// Build the project in the current directory
    @discardableResult
    public func build(at path: String = ".") -> Result {
        return run(at: path, ["build"])
    }

    /// Build the project add Arguments
    @discardableResult
    public func build(at path: String = ".", _ arguments: [String]) -> Result {
        return run(at: path, ["build"] + arguments)
    }

    /// To clean all the data generated by Tuist
    @discardableResult
    public func clean(at path: String = ".", _ subset: String = "") -> Result {
        return run(at: path, ["clean", subset])
    }

    /// Dependencies can be fetched by running the following command
    @discardableResult
    public func fetch(at path: String = ".", _ options: String = "") -> Result {
        return run(at: path, ["fetch", options])
    }

    /// Editing your projects command
    @discardableResult
    public func edit(at path: String = ".", _ options: String = "") -> Result {
        return run(at: path, ["edit", options])
    }

    /// Running `tuist graph` Command
    @discardableResult
    public func graph(at path: String = ".") -> Result {
        return run(at: path, ["graph"])
    }
    
    /// Running `tuist graph` Command with arguments
    @discardableResult
    public func graph(at path: String = ".", _ arguments: [String]) -> Result {
        return run(at: path, ["graph"] + arguments)
    }

    /// To generate the project in the current directory command
    @discardableResult
    public func generate(at path: String = ".") -> Result {
        return run(at: path, ["generate"])
    }
    
    /// To generate the project in the current directory command with arguments
    @discardableResult
    public func generate(at path: String = ".", _ arguments: [String]) -> Result {
        return run(at: path, ["generate"] + arguments)
    }

    /// Running `tuist migration` command
    @discardableResult
    public func migration(at path: String = ".", _ arguments: [String]) -> Result {
        return run(at: path, ["migration"] + arguments)
    }
    
    /// Running `tuist scaffold` command
    @discardableResult
    public func scaffold(at path: String = "." ,_ templateName: String, _ arguments: [String] = []) -> Result {
        return run(at: path, ["scaffold", templateName] + arguments)
    }

    /// Test the project in the current directory
    @discardableResult
    public func test(at path: String = ".") -> Result {
        return run(at: path, ["test"])
    }

    /// Test a specific scheme
    @discardableResult
    public func testScheme(at path: String = ".", _ schemeName: String) -> Result {
        return run(at: path, ["test", schemeName])
    }

    /// Test the project with arguments
    @discardableResult
    public func test(at path: String = ".",_ arguments: [String]) -> Result {
        return run(at: path, ["test"] + arguments)
    }

    /// Running Tuist Command
    @discardableResult
    public func run(at path: String = ".", _ arguments: [String]) -> Result {
        let command = ["cd \(path.escapingSpaces)", "&&" , "tuist"] + arguments
        let arguments = Arguments(command)
        return bash.run(arguments)
    }
}

extension CommandValues {
    /// Support Tuist Command
    public var tuist: Tuist {
        Tuist()
    }
}
