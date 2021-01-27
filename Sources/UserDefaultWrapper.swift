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

@propertyWrapper
struct WrappedDefault<T: UserDefaultsSerializable> {
    private let _defaultValue: T
    private let _userDefaults: UserDefaults

    let key: String

    var wrappedValue: T {
        get {
            self._userDefaults.fetch(self.key)
        }
        set {
            self._userDefaults.save(newValue, for: self.key)
        }
    }

    init(keyName: String,
         defaultValue: T,
         userDefaults: UserDefaults = .standard) {
        self.key = keyName
        self._defaultValue = defaultValue
        self._userDefaults = userDefaults
        userDefaults.registerDefault(value: defaultValue, key: keyName)
    }
}
