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

import Combine
import Foundation

/// A property wrapper that uses `UserDefaults` as a backing store,
/// whose `wrappedValue` is non-optional and registers a **non-optional default value**.
@propertyWrapper
public struct WrappedDefault<T: UserDefaultsSerializable> {
    private let _userDefaults: UserDefaults
    private let _publisher: CurrentValueSubject<T, Never>

    /// The key for the value in `UserDefaults`.
    public let key: String

    /// The value retrieved from `UserDefaults`.
    public var wrappedValue: T {
        get {
            self._userDefaults.fetch(self.key)
        }
        set {
            self._userDefaults.save(newValue, for: self.key)
            self._publisher.send(newValue)
        }
    }

    /// A publisher that delivers updates to subscribers.
    public var projectedValue: AnyPublisher<T, Never> {
        self._publisher.eraseToAnyPublisher()
    }

    /// Initializes the property wrapper.
    /// - Parameters:
    ///   - wrappedValue: The default value to register for the specified key.
    ///   - keyName: The key for the value in `UserDefaults`.
    ///   - userDefaults: The `UserDefaults` backing store. The default value is `.standard`.
    public init(wrappedValue: T, key keyName: String, userDefaults: UserDefaults = .standard) {
        self.key = keyName
        self._userDefaults = userDefaults
        userDefaults.registerDefault(value: wrappedValue, key: keyName)

        // Publisher must be initialized after `registerDefault`,
        // because `fetch` assumes that `registerDefault` has been called before
        // and uses force unwrap
        self._publisher = CurrentValueSubject<T, Never>(userDefaults.fetch(keyName))
    }
}
