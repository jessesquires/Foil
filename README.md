# Foil [![Actions Status](https://github.com/jessesquires/Foil/workflows/CI/badge.svg)](https://github.com/jessesquires/Foil/actions)

*A lightweight [property wrapper](https://docs.swift.org/swift-book/ReferenceManual/Attributes.html#ID348) for UserDefaults done right*

## About

#### Why the name?

Foil, as in let me quickly and easily **wrap** and **store** this leftover food in some **foil** so I can eat it later. 🌯 😉

> [Foil](https://www.wordnik.com/words/aluminum%20foil):<br>
> **noun**<br>
> *North America*<br>
> A very thin, pliable, easily torn sheet of aluminum used for cooking, packaging, cosmetics, and insulation.

## Usage

You can use `@WrappedDefault` for non-optional values and `@WrappedDefaultOptional` for optional ones. 
You may wish to store all your user defaults in one place, however, that is not necessary. **Any** property on **any type** can use this wrapper.

```swift
final class AppSettings {
    static let shared = AppSettings()
    
    @WrappedDefault(keyName: "flagEnabled", defaultValue: true)
    var flagEnabled: Bool
    
    @WrappedDefault(keyName: "totalCount", defaultValue: 0)
    var totalCount: Int
    
    @WrappedDefaultOptional(keyName: "timestamp")
    var timestamp: Date?
}

// Usage

func userDidToggleSetting(_ sender: UISwitch) {
    AppSettings.shared.flagEnabled = sender.isOn
}
```

There is also an included example app project.

### Using `enum` keys

If you prefer using an `enum` for the keys, writing an extension specific to your app is easy. However, this is not required. In fact, unless you have a specific reason to reference the keys, this is completely unneccessary.

```swift
enum AppSettingsKey: String, CaseIterable {
    case flagEnabled
    case totalCount
    case timestamp
}

extension WrappedDefault {
    init(key: AppSettingsKey, defaultValue: T) {
        self.init(keyName: key.rawValue, defaultValue: defaultValue)
    }
}

extension WrappedDefaultOptional {
    init(key: AppSettingsKey) {
        self.init(keyName: key.rawValue)
    }
}
```

### Supported types

The following types are supported by default for use with `@WrappedDefault`. 

Adding support for custom types is possible by conforming to `UserDefaultsSerializable`. However, **this is highly discouraged**. `UserDefaults` is not intended for storing complex data structures and object graphs. You should probably be using a proper database (or serializing to disk via `Codable`) instead.

- `Bool`
- `Int`
- `Float`
- `Double`
- `String`
- `URL`
- `Date`
- `Data`
- `Array`
- `Set`
- `Dictionary`
- `RawRepresentable` types

## Additional Resources

- [NSUserDefaults in Practice](http://dscoder.com/defaults.html), the excellent guide by [David Smith](https://twitter.com/Catfish_Man)
- [UserDefaults documentation](https://developer.apple.com/documentation/foundation/userdefaults)

## Supported Platforms

- iOS 12.0+
- tvOS 12.0+
- watchOS 5.0+
- macOS 10.13+

## Requirements

- Swift 5.3+
- Xcode 12.0+
- [SwiftLint](https://github.com/realm/SwiftLint)

## Installation

### [CocoaPods](http://cocoapods.org)

````ruby
pod 'Foil', '~> 1.0.0'
````

### [Swift Package Manager](https://swift.org/package-manager/)

```swift
dependencies: [
    .package(url: "https://github.com/jessesquires/Foil.git", from: "1.0.0")
]
```

Alternatively, you can add the package [directly via Xcode](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app).

## Documentation

You can read the [documentation here](https://jessesquires.github.io/Foil). Generated with [jazzy](https://github.com/realm/jazzy). Hosted by [GitHub Pages](https://pages.github.com).

## Contributing

Interested in making contributions to this project? Please review the guides below.

- [Contributing Guidelines](https://github.com/jessesquires/.github/blob/main/CONTRIBUTING.md)
- [Code of Conduct](https://github.com/jessesquires/.github/blob/main/CODE_OF_CONDUCT.md)
- [Support and Help](https://github.com/jessesquires/.github/blob/main/SUPPORT.md)
- [Security Policy](https://github.com/jessesquires/.github/blob/main/SECURITY.md)

Also, consider [sponsoring this project](https://www.jessesquires.com/sponsor/) or [buying my apps](https://www.hexedbits.com)! ✌️

## Credits

Created and maintained by [**Jesse Squires**](https://www.jessesquires.com).

## License

Released under the MIT License. See `LICENSE` for details.

> **Copyright &copy; 2021-present Jesse Squires.**
