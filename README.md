# Command
![Official](https://img.shields.io/badge/project-official-green.svg?colorA=303033&colorB=226af6&label=Pelagornis)
![SPM](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)
![Swift](https://img.shields.io/badge/Swift-5.7-orange.svg)
[![License](https://img.shields.io/github/license/pelagornis/swift-command)](https://github.com/pelagornis/swift-command/blob/main/LICENSE)
![Platform](https://img.shields.io/badge/platforms-macOS%2010.5-red)

⌘ Running Command from Swift

## Installation
Command was deployed as Swift Package Manager. Package to install in a project. Add as a dependent item within the swift manifest.
```swift
let package = Package(
    ...
    dependencies: [
        .package(url: "https://github.com/pelagornis/swift-command.git", from: "1.3.0")
    ],
    ...
)
```
Then import the `Command` from thr location you want to use.

```swift
import Command
```

## Documentation
The documentation for releases and ``main`` are available here:
- [``main``](https://pelagornis.github.io/swift-command/main/documentation/command)


## Using
If you want to use Bash.

```swift
@Command(\.bash) var bashCommand
bashCommand.run("command")
```
Or if you want to use zsh.

```swift
@Command(\.zsh) var zshCommand
zshCommand.run("command")
```

Or if you want to use Makefile command.

```swift
@Command(\.make) var makeCommand
makeCommand.run("command")
```
## Alias
Create a shortcut name for a command.
```swift
let git = Alias(executableURL: "/usr/bin/git")
git.run("command", directory: "/path/to/directory")
```

## Frequently Used Commands
Command supports frequently used features.

Support `Git` Command
```swift
@Command(\.git) var git

git.`init`()
git.add()
git.clone(repositoryURL)
git.commit("comment")
git.push()
git.pull(remote: "origin")
git.checkout(branch: "gh-page")
```

Support `Swift Package` Command
```swift
@Command(\.package) var swiftPackage

swiftPackage.create()
swiftPackage.create(type: .executable)
swiftPackage.update()
swiftPackage.generateXcodeproj()
swiftPackage.build()
swiftPackage.test()
```

Support `Fastlane` Command
```swift
@Command(\.fastlane) var fastlane

fastlane.`init`()
fastlane.tests()
fastlane.snapshot()
fastlane.deliver()
fastlane.frameit()
fastlane.run("fastlane command")
```

Support `Tuist` Command
```swift
@Command(\.tuist) var tuist

tuist.build()
tuist.clean()
tuist.fetch()
tuist.edit()
tuist.graph()
tuist.generate()
tuist.migration([])
tuist.scaffold("template", [])
tuist.test()
tuist.run("tuist command")
```

### Extension
Command is easier to scale.

```swift
extension CommandValues {
    var swift: Alias {
        Alias(executableURL: "/usr/bin/swift")
    }
}


// Usage
@Command(\.swift) var swiftCommand
```

## License
**swift-command** is under MIT license. See the [LICENSE](LICENSE) file for more info.
