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
/// whose `wrappedValue` is optional and **does not provide default value**.
@propertyWrapper
public struct WrappedDefaultOptional<T: UserDefaultsSerializable> {
    private let _userDefaults: UserDefaults
    private let _publisher: CurrentValueSubject<T?, Never>

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
                self._publisher.send(newValue)
            } else {
                self._userDefaults.delete(for: self.key)
                self._publisher.send(nil)
            }
        }
    }

    /// A publisher that delivers updates to subscribers.
    public var projectedValue: AnyPublisher<T?, Never> {
        self._publisher.eraseToAnyPublisher()
    }

    /// Initializes the property wrapper.
    /// - Parameters:
    ///   - keyName: The key for the value in `UserDefaults`.
    ///   - userDefaults: The `UserDefaults` backing store. The default value is `.standard`.
    public init(key keyName: String, userDefaults: UserDefaults = .standard) {
        self.key = keyName
        self._userDefaults = userDefaults
        self._publisher = CurrentValueSubject<T?, Never>(userDefaults.fetchOptional(keyName))
    }
}
