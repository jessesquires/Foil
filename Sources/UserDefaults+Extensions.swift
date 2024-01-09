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

extension UserDefaults {

    func save<T: UserDefaultsSerializable>(_ value: T, for key: String) {
        if T.self == URL.self {
            // Hack for URL, which is special
            // See: http://dscoder.com/defaults.html
            // Error: Attempt to insert non-property list object, NSInvalidArgumentException
            self.set(value as? URL, forKey: key)
            return
        }
        self.set(value.storedValue, forKey: key)
    }

    func delete(for key: String) {
        self.removeObject(forKey: key)
    }

    func fetch<T: UserDefaultsSerializable>(_ key: String) -> T {
        self.fetchOptional(key)!
    }

    func fetchOptional<T: UserDefaultsSerializable>(_ key: String) -> T? {
        let fetched: Any?

        if T.self == URL.self {
            // Hack for URL, which is special
            // See: http://dscoder.com/defaults.html
            // Error: Could not cast value of type '_NSInlineData' to 'NSURL'
            fetched = self.url(forKey: key)
        } else {
            fetched = self.object(forKey: key)
        }

        if fetched == nil {
            return nil
        }

        guard let storedValue = fetched as? T.StoredValue else {
            return nil
        }

        return T(storedValue: storedValue)
    }

    func registerDefault<T: UserDefaultsSerializable>(value: T, key: String) {
        self.register(defaults: [key: value.storedValue])
    }
}
