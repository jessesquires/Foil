# Foil [![Actions Status](https://github.com/jessesquires/Foil/workflows/CI/badge.svg)](https://github.com/jessesquires/Foil/actions)

*A lightweight [property wrapper](https://docs.swift.org/swift-book/ReferenceManual/Attributes.html#ID348) for UserDefaults done right*

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fjessesquires%2FFoil%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/jessesquires/Foil) <br> [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fjessesquires%2FFoil%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/jessesquires/Foil)

## About

Read the post: [A better approach to writing a UserDefaults Property Wrapper](https://www.jessesquires.com/blog/2021/03/26/a-better-approach-to-writing-a-userdefaults-property-wrapper/)

#### Why the name?

Foil, as in "let me quickly and easily **wrap** and **store** this leftover food in some **foil** so I can eat it later." 🌯 😉

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

    @WrappedDefault(key: "flagEnabled")
    var flagEnabled = true

    @WrappedDefault(key: "totalCount")
    var totalCount = 0

    @WrappedDefaultOptional(key: "timestamp")
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
    init(wrappedValue: T, _ key: AppSettingsKey) {
        self.init(wrappedValue: wrappedValue, key: key.rawValue)
    }
}

extension WrappedDefaultOptional {
    init(_ key: AppSettingsKey) {
        self.init(key: key.rawValue)
    }
}
```

### Observing changes

There are [many ways to observe property changes](https://www.jessesquires.com/blog/2021/08/08/different-ways-to-observe-properties-in-swift/). The most common are by using Key-Value Observing or a Combine Publisher. KVO observing requires the object with the property to inherit from `NSObject` and the property must be declared as `@objc dynamic`.

```swift
final class AppSettings: NSObject {
    static let shared = AppSettings()

    @WrappedDefaultOptional(key: "userId")
    @objc dynamic var userId: String?

    @WrappedDefaultOptional(key: "average")
    var average: Double?
}
```

#### Using KVO

```swift
let observer = AppSettings.shared.observe(\.userId, options: [.new]) { settings, change in
    print(change)
}
```

#### Using Combine

**Note:** that `average` does not need the `@objc dynamic` annotation, `.receiveValue` will fire immediately with the current value of `average` and on every change after.

```swift
AppSettings.shared.$average
    .sink {
        print($0)
    }
    .store(in: &cancellable)
```

#### Combine Alternative with KVO

**Note:** in this case, `userId` needs the `@objc dynamic` annotation and `AppSettings` needs to inherit from `NSObject`. Then `receiveValue` will fire only on changes to wrapped object's value. It will not publish the initial value as in the example above.

```swift
AppSettings.shared
    .publisher(for: \.userId, options: [.new])
    .sink {
        print($0)
    }
    .store(in: &cancellable)
```

### Supported types

The following types are supported by default for use with `@WrappedDefault`.

Adding support for custom types is possible by conforming to `UserDefaultsSerializable`. However, **this is highly discouraged**. `UserDefaults` is not intended for storing complex data structures and object graphs. You should probably be using a proper database (or serializing to disk via `Codable`) instead.

- `Bool`
- `Int`
- `UInt`
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
- [Preferences and Settings Programming Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/UserDefaults/Introduction/Introduction.html#//apple_ref/doc/uid/10000059i-CH1-SW1)
- [Property List Programming Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/PropertyLists/Introduction/Introduction.html#//apple_ref/doc/uid/10000048i)

## Supported Platforms

- iOS 13.0+
- tvOS 13.0+
- watchOS 6.0+
- macOS 11+

## Requirements

- Swift 5.5+
- Xcode 13.0+
- [SwiftLint](https://github.com/realm/SwiftLint)

## Installation

### [CocoaPods](http://cocoapods.org)

````ruby
pod 'Foil', '~> 3.0.0'
````

### [Swift Package Manager](https://swift.org/package-manager/)

```swift
dependencies: [
    .package(url: "https://github.com/jessesquires/Foil.git", from: "3.0.0")
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

Also consider [sponsoring this project](https://github.com/sponsors/jessesquires) or [buying my apps](https://www.hexedbits.com)! ✌️

## Credits

Created and maintained by [**Jesse Squires**](https://www.jessesquires.com).

## License

Released under the MIT License. See `LICENSE` for details.

> **Copyright &copy; 2021-present Jesse Squires.**
