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
/// whose `wrappedValue` is optional and provides a **does not provide default value**.
@propertyWrapper
public struct WrappedDefaultOptional<T: UserDefaultsSerializable> {
    private let _userDefaults: UserDefaults

    /// The key for the value in `UserDefaults`.
    public let key: String

    /// The value retreived from `UserDefaults`, if any exists.
    public var wrappedValue: T? {
        get {
            self._userDefaults.fetchOptional(self.key)
        }
        set {
            if let newValue = newValue {
                self._userDefaults.save(newValue, for: self.key)
            } else {
                self._userDefaults.delete(for: self.key)
            }
        }
    }

    /// Initializes the property wrapper.
    /// - Parameters:
    ///   - keyName: The key for the value in `UserDefaults`.
    ///   - userDefaults: The `UserDefaults` backing store.
    public init(keyName: String,
                userDefaults: UserDefaults = .standard) {
        self.key = keyName
        self._userDefaults = userDefaults
    }
}
