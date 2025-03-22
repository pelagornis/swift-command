# Getting started

Learn how to quickly execute commands on Swift using Command.

## Installation
Command was deployed as Swift Package Manager. Package to install in a project. Add as a dependent item within the swift manifest.
```swift
let package = Package(
    ...
    dependencies: [
        .package(url: "https://github.com/pelagornis/swift-command", from: "1.2.3")
    ],
    ...
)
```
Then import the Command from thr location you want to use.

```swift
import Command
```

## Using Command
Command offers the most commonly used `bash` and `zsh` and `make`, which in addition helps users scale easily.

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

### Extension
Command is easier to scale.

```swift
extension CommandValues {
    var swift: Alias {
        Alias(executableURL: "/usr/bin/swift")
    }
}

@Command(\.swift) var swiftCommand
```


## License
**swift-command** is under MIT license. See the [LICENSE](LICENSE) file for more info.
