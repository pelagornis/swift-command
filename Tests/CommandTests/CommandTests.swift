import XCTest
import File
@testable import Command

final class CommandTests: XCTestCase {
    func testBash() throws {
        @Command(\.bash) var bash
        let echo = bash.run("echo Hello world")
        XCTAssertEqual(echo.output, "Hello world")
        
        let ls = bash.run("ls")
        XCTAssertFalse(ls.output.isEmpty)
    }
    
    func testGit() throws {
        @Command(\.git) var git
        @Command(\.bash) var bash
        let tempFolderPath = Path(rawValue: NSTemporaryDirectory())!
        let originPath = tempFolderPath + Path(rawValue: "GitTestOrigin")!
        let clonePath = tempFolderPath + Path(rawValue: "GitTestClone")!
        
        bash.run("cd \(tempFolderPath.rawValue.escapingSpaces) && rm -rf GitTestOrigin", directory: tempFolderPath)
        bash.run("cd \(tempFolderPath.rawValue.escapingSpaces) && rm -rf GitTestClone", directory: tempFolderPath)

        let mkdirCommand = "mkdir".appending(argument: "GitTestOrigin")
        bash.run("cd \(tempFolderPath.rawValue.escapingSpaces) && \(mkdirCommand)", directory: tempFolderPath)
        git.`init`(at: originPath)
        var echoCommand = "echo"
        echoCommand.append(argument: "Hello world")
        echoCommand.append(" > ")
        echoCommand.append(argument: "Test")
        bash.run("cd \(originPath.rawValue) && \(echoCommand)", directory: originPath)
        git.add(at: originPath)
        git.commit(at: originPath, "Commit")
        let cloneURL = URL(fileURLWithPath: originPath.rawValue)
        git.clone(at: tempFolderPath, cloneURL, to: "GitTestClone")

        let filePath = clonePath + Path(rawValue: "Test")!
        XCTAssertEqual(bash.run("cat \(filePath.rawValue)", directory: clonePath).output, "Hello world")
    }

    func testSwiftPackageManagerCommands() throws {
        @Command(\.bash) var bash
        @Command(\.package) var swiftPackage
        let tempFolderPath = Path(rawValue: NSTemporaryDirectory())!
        let packagePath = tempFolderPath + Path(rawValue: "SwiftPackageManagerTest")!
        
        bash.run("cd \(tempFolderPath.rawValue.escapingSpaces) && rm -rf SwiftPackageManagerTest", directory: tempFolderPath)
        bash.run("cd \(tempFolderPath.rawValue.escapingSpaces) && mkdir SwiftPackageManagerTest", directory: tempFolderPath)
        
        swiftPackage.create(at: packagePath)
        let packageSwiftPath = packagePath + Path(rawValue: "Package.swift")!
        XCTAssertFalse(bash.run("cat \(packageSwiftPath.rawValue)", directory: packagePath).output.isEmpty)
        
        swiftPackage.build(at: packagePath)
        XCTAssertTrue(bash.run("cd \(packagePath.rawValue.escapingSpaces) && ls -a", directory: packagePath).output.contains(".build"))
    }

    func testArgumentsEquatableAndLiterals() throws {
        let a1 = Arguments("echo hello")
        let a2: Arguments = "echo hello"
        let a3: Arguments = ["echo", "hello"]
        XCTAssertEqual(a1, a2)
        XCTAssertEqual(a1, a3)
    }

    func testFailingCommand() throws {
        @Command(\.bash) var bash
        let fail = bash.run("not_a_real_command_12345")
        XCTAssertNotEqual(fail.statusCode, 0)
        XCTAssertFalse(fail.output.isEmpty || fail.errorOutput.isEmpty)
    }
}
