//
//  Created by Jesse Squires
//  https://www.jessesquires.com
//
//  Documentation
//  https://jessesquires.github.io/Foil
//
//  GitHub
//  https://github.com/jessesquires/Foil
//
//  Copyright © 2021-present Jesse Squires
//

import Foundation

/// Describes a value that can be saved to and fetched from `UserDefaults`.
/// 
/// Default conformances are provided for:
///    - `Bool`
///    - `Int`
///    - `Float`
///    - `Double`
///    - `String`
///    - `URL`
///    - `Date`
///    - `Data`
///    - `Array`
///    - `Set`
///    - `Dictionary`
///    - `RawRepresentable` types
public protocol UserDefaultsSerializable {

    /// The type of the value that is stored in `UserDefaults`.
    associatedtype StoredValue

    /// The value to store in `UserDefaults`.
    var storedValue: StoredValue { get }

    /// Initializes the object using the provided value.
    /// 
    /// - Parameter storedValue: The previously store value fetched from `UserDefaults`.
    init(storedValue: StoredValue)

    /// Returns the object associated with the specified key in the user‘s defaults database.
    /// - Parameters:
    ///   - defaultName: A key in the current user‘s defaults database.
    ///   - userDefaults: The user’s defaults database, where you store key-value pairs persistently across launches of your app.
    static func fetch(forKey defaultName: String, from userDefaults: UserDefaults) -> Self

    /// Returns the object associated with the specified key in the user‘s defaults database.
    /// - Parameters:
    ///   - defaultName: A key in the current user‘s defaults database.
    ///   - userDefaults: The user’s defaults database, where you store key-value pairs persistently across launches of your app.
    static func fetchOptional(forKey defaultName: String, from userDefaults: UserDefaults) -> Self?

    /// Sets the value of the specified default key in the user‘s defaults database.
    /// - Parameters:
    ///   - value: The object to store in the defaults database.
    ///   - defaultName: The key with which to associate the value.
    ///   - userDefaults: The user’s defaults database, where you store key-value pairs persistently across launches of your app.
    static func set(_ value: Self, forKey defaultName: String, from userDefaults: UserDefaults)
}

extension UserDefaultsSerializable {
    public var storedValue: Self { self }

    public init(storedValue: Self) {
        self = storedValue
    }

    public static func fetch(forKey defaultName: String, from userDefaults: UserDefaults) -> Self {
        fetchOptional(forKey: defaultName, from: userDefaults)!
    }

    public static func fetchOptional(forKey defaultName: String, from userDefaults: UserDefaults) -> Self? {
        guard let object = userDefaults.object(forKey: defaultName) as? StoredValue else { return nil }
        return Self(storedValue: object)
    }

    public static func set(_ value: Self, forKey defaultName: String, from userDefaults: UserDefaults) {
        userDefaults.set(value.storedValue, forKey: defaultName)
    }
}

/// :nodoc:
extension Bool: UserDefaultsSerializable {}

/// :nodoc:
extension Int: UserDefaultsSerializable {}

/// :nodoc:
extension Float: UserDefaultsSerializable {}

/// :nodoc:
extension Double: UserDefaultsSerializable {}

/// :nodoc:
extension String: UserDefaultsSerializable {}

/// :nodoc:
extension Date: UserDefaultsSerializable {}

/// :nodoc:
extension Data: UserDefaultsSerializable {}

/// :nodoc:
extension URL: UserDefaultsSerializable {
    public static func fetchOptional(forKey defaultName: String, from userDefaults: UserDefaults) -> Self? {
        userDefaults.url(forKey: defaultName)
    }

    public static func set(_ value: Self, forKey defaultName: String, from userDefaults: UserDefaults) {
        userDefaults.set(value, forKey: defaultName)
    }
}

/// :nodoc:
extension Array: UserDefaultsSerializable where Element: UserDefaultsSerializable {
    public var storedValue: [Element.StoredValue] {
        self.map { $0.storedValue }
    }

    public init(storedValue: [Element.StoredValue]) {
        self = storedValue.map { Element(storedValue: $0) }
    }
}

/// :nodoc:
extension Set: UserDefaultsSerializable where Element: UserDefaultsSerializable {
    public var storedValue: [Element.StoredValue] {
        self.map { $0.storedValue }
    }

    public init(storedValue: [Element.StoredValue]) {
        self = Set(storedValue.map { Element(storedValue: $0) })
    }
}

/// :nodoc:
extension Dictionary: UserDefaultsSerializable where Key == String, Value: UserDefaultsSerializable {
    public var storedValue: [String: Value.StoredValue] {
        self.mapValues { $0.storedValue }
    }

    public init(storedValue: [String: Value.StoredValue]) {
        self = storedValue.mapValues { Value(storedValue: $0) }
    }
}

/// :nodoc:
extension UserDefaultsSerializable where Self: RawRepresentable {
    public var storedValue: RawValue { self.rawValue }

    public init(storedValue: RawValue) {
        self = Self(rawValue: storedValue)!
    }
}
