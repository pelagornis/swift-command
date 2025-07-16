import Foundation
import Logging
import Darwin

/// Provides methods to execute commands synchronously and asynchronously.
public struct Task {
    let logger: Logger?
    /// Creates a new Task instance.
    public init(logger: Logger? = nil) {
        self.logger = logger
    }
    /// Runs a command synchronously.
    /// - Parameters:
    ///   - request: The command request to execute.
    ///   - log: Whether to log output.
    /// - Returns: The result of the command execution.
    @discardableResult
    public func run(_ request: Request, log: Bool) -> Result {
        let process = prepare(request)

        let outputPipe = Pipe()
        let errorPipe = Pipe()

        process.standardOutput = outputPipe
        process.standardError = errorPipe

        do {
            try run(process: process)

            let outputActual = try fileHandleData(fileHandle: outputPipe.fileHandleForReading) ?? ""
            let errorActual = try fileHandleData(fileHandle: errorPipe.fileHandleForReading) ?? ""

            if process.terminationStatus == EXIT_SUCCESS {
                let res = Response(statusCode: process.terminationStatus, output: outputActual, error: errorActual)
                if let logger, log {
                    logger.debug(
                        "\(res.output)",
                        source: "command: \(request.arguments?.rawValue.joined(separator: " ") ?? "")"
                    )
                }
                return Result.success(request, res)
            } else {
                let res = Response(statusCode: process.terminationStatus, output: errorActual, error: errorActual)
                if let logger, log {
                    logger.error(
                        "\(res.error)",
                        source: "command: \(request.arguments?.rawValue.joined(separator: " ") ?? "")"
                    )
                }
                return Result.failure(request, res)
            }
        } catch let error {
            let res = Response(statusCode: EXIT_FAILURE, output: "", error: error.localizedDescription)
            return Result.failure(request, res)
        }
    }
}

public extension Task {
    /// Prepares a Process for the given request.
    /// - Parameter request: The command request.
    /// - Returns: A configured Process instance.
    func prepare(_ request: Request) -> Process {
        let process = Process()
        if #available(macOS 10.13, *) {
            process.executableURL = URL(path: request.executableURL)
        } else {
            process.launchPath = request.executableURL
        }
        if let environment = request.environment?.data {
            process.environment = environment
        }
        if let path = request.directory {
            process.currentDirectoryURL = URL(fileURLWithPath: path)
        }
        if let dashc = request.dashc {
            var arguments = dashc.rawValue
            arguments.append(contentsOf: request.arguments?.rawValue ?? [])
            process.arguments = arguments
        }
        return process
    }
    
    /// Reads all data from a file handle and returns it as a string.
    /// - Parameter fileHandle: The file handle to read from.
    /// - Returns: The string contents of the file handle.
    func fileHandleData(fileHandle: FileHandle) throws -> String? {
        var data: Data?
        if #available(macOS 10.15.4, *) {
            data = try fileHandle.readToEnd()
        } else {
            data = fileHandle.readDataToEndOfFile()
        }
        return data?.output
    }
    
    /// Runs a process synchronously.
    /// - Parameter process: The process to run.
    func run(process: Process) throws {
        if #available(macOS 10.13, *) {
            try process.run()
        } else {
            process.launch()
        }
        process.waitUntilExit()
    }
}
