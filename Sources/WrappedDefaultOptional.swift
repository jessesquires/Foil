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
/// whose `wrappedValue` is optional and **does not provide default value**.
@propertyWrapper
public struct WrappedDefaultOptional<T: UserDefaultsSerializable> {
    private let _userDefaults: UserDefaults

    /// The key for the value in `UserDefaults`.
    public let key: String

    /// The value retreived from `UserDefaults`, if any exists.
    public var wrappedValue: T? {
        get {
            T.fetchOptional(forKey: self.key, from: self._userDefaults)
        }
        set {
            if let newValue = newValue {
                T.set(newValue, forKey: self.key, from: self._userDefaults)
            } else {
                self._userDefaults.removeObject(forKey: self.key)
            }
        }
    }

    /// Initializes the property wrapper.
    /// - Parameters:
    ///   - keyName: The key for the value in `UserDefaults`.
    ///   - userDefaults: The `UserDefaults` backing store. The default value is `.standard`.
    public init(keyName: String,
                userDefaults: UserDefaults = .standard) {
        self.key = keyName
        self._userDefaults = userDefaults
    }
}
