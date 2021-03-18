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

    /// Returns the object associated with the specified key.
    ///
    /// - Parameter key: A key in the current user‘s defaults database.
    /// - Returns: The object associated with the specified key, or its default value.
    public func fetch<T: UserDefaultsSerializable>(_ key: String) -> T {
        if T.self == URL.self {
            // HACK: for URL
            // Could not cast value of type '_NSInlineData' to 'NSURL'
            let storedURL = self.url(forKey: key)!
            return T(storedValue: storedURL as! T.StoredValue)
        }

        return T(storedValue: self.object(forKey: key) as! T.StoredValue)
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
