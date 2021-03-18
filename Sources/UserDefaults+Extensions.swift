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

// swiftlint:disable force_cast

extension UserDefaults {

    /// Sets the value of the specified default key.
    /// 
    /// - Parameters:
    ///   - value: The object to store in the defaults database.
    ///   - key: The key with which to associate the value.
    public func save<T: UserDefaultsSerializable>(_ value: T, for key: String) {
        if T.self == URL.self {
            // HACK: for URL
            // Attempt to insert non-property list object, NSInvalidArgumentException
            self.set(value as? URL, forKey: key)
            return
        }
        self.set(value.storedValue, forKey: key)
    }

    /// Removes the value of the specified default key.
    ///
    /// - Parameter key: The key whose value you want to remove.
    public func delete(for key: String) {
        self.removeObject(forKey: key)
    }

    /// Returns the object associated with the specified key.
    ///
    /// - Parameter key: A key in the current user‘s defaults database.
    /// - Returns: The non-optional object associated with the specified key, or its default value.
    public func fetch<T: UserDefaultsSerializable>(_ key: String) -> T {
        self.fetchOptional(key)!
    }

    /// Returns the object associated with the specified key, if any exists.
    ///
    /// - Parameter key: A key in the current user‘s defaults database.
    /// - Returns: The object associated with the specified key, or `nil`.
    public func fetchOptional<T: UserDefaultsSerializable>(_ key: String) -> T? {
        let fetched: Any?

        if T.self == URL.self {
            // HACK: for URL
            // Could not cast value of type '_NSInlineData' to 'NSURL'
            fetched = self.url(forKey: key)
        } else {
            fetched = self.object(forKey: key)
        }

        if fetched == nil {
            return nil
        }

        return T(storedValue: fetched as! T.StoredValue)
    }

    /// Adds the key-value pair to the registration domain.
    ///
    /// - Parameters:
    ///   - value: The object to store in the registration domain database.
    ///   - key: The key with which to associate the value.
    public func registerDefault<T: UserDefaultsSerializable>(value: T, key: String) {
        self.register(defaults: [key: value.storedValue])
    }
}

// swiftlint:enable force_cast
