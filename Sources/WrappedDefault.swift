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

/// A property wrapper that uses `UserDefaults` as a backing store,
/// whose `wrappedValue` is non-optional and registers a **non-optional default value**.
@propertyWrapper
public struct WrappedDefault<T: UserDefaultsSerializable> {
    private let _userDefaults: UserDefaults

    /// The key for the value in `UserDefaults`.
    public let key: String

    /// The value retreived from `UserDefaults`.
    public var wrappedValue: T {
        get {
            T.fetch(forKey: self.key, from: self._userDefaults)
        }
        set {
            T.set(newValue, forKey: self.key, from: self._userDefaults)
        }
    }

    /// Initializes the property wrapper.
    /// - Parameters:
    ///   - keyName: The key for the value in `UserDefaults`.
    ///   - defaultValue: The default value to register for the specified key.
    ///   - userDefaults: The `UserDefaults` backing store. The default value is `.standard`.
    public init(keyName: String,
                defaultValue: T,
                userDefaults: UserDefaults = .standard) {
        self.key = keyName
        self._userDefaults = userDefaults
        userDefaults.register(defaults: [keyName: defaultValue.storedValue])
    }
}
