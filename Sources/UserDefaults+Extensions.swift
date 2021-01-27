//
//  Created by Jesse Squires
//  https://www.jessesquires.com
//
//  Documentation
//  https://jessesquires.github.io/WrappedDefaults
//
//  GitHub
//  https://github.com/jessesquires/WrappedDefaults
//
//  Copyright © 2021-present Jesse Squires
//

import Foundation

extension UserDefaults {
    public func save<T: UserDefaultsSerializable>(_ value: T, for key: String) {
        self.set(value.storedValue, forKey: key)
    }

    public func fetch<T: UserDefaultsSerializable>(_ key: String) -> T {
        // swiftlint:disable:next force_cast
        T(storedValue: self.object(forKey: key) as! T.StoredValue)
    }

    public func registerDefault<T: UserDefaultsSerializable>(value: T, key: String) {
        self.register(defaults: [key: value.storedValue])
    }
}
