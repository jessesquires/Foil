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
public struct FoilDefaultStorageOptional<T: UserDefaultsSerializable> {
    private let _userDefaults: UserDefaults
    private let _publisher: CurrentValueSubject<T?, Never>
    private let _observer: ObserverTrampoline

    /// The key for the value in `UserDefaults`.
    public let key: String

    /// The value retrieved from `UserDefaults`, if any exists.
    public var wrappedValue: T? {
        get {
            self._userDefaults.fetchOptional(self.key)
        }
        set {
            if let newValue {
                self._userDefaults.save(newValue, for: self.key)
            } else {
                self._userDefaults.delete(for: self.key)
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
        self._observer = ObserverTrampoline(userDefaults: userDefaults, key: keyName) { [unowned _publisher] in
            _publisher.send(userDefaults.fetchOptional(keyName))
        }
    }
}
