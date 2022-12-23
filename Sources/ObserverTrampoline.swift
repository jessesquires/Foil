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

/// Watches for changes to `UserDefaults` using old-school Key-Value Observing.
///
/// KVO allows us to be notified of changes from anywhere (including other processes),
/// not just via the property wrapper's setter.
///
/// We can't use Swift's block-based KVO because that requires a `KeyPath`,
/// which we cannot create from a `String`.
final class ObserverTrampoline: NSObject {
    private let userDefaults: UserDefaults
    private let key: String
    private let action: () -> Void

    init(userDefaults: UserDefaults, key: String, action: @escaping () -> Void) {
        assert(!key.hasPrefix("@"), "Error: key name cannot begin with a '@' character and be observed via KVO.")
        assert(!key.contains("."), "Error: key name cannot contain a '.' character anywhere and be observed via KVO.")
        self.userDefaults = userDefaults
        self.key = key
        self.action = action
        super.init()
        userDefaults.addObserver(self, forKeyPath: key, context: nil)
    }

    deinit {
        self.userDefaults.removeObserver(self, forKeyPath: self.key, context: nil)
    }

    // swiftlint:disable:next block_based_kvo
    override func observeValue(
        forKeyPath keyPath: String?,
        of object: Any?,
        // swiftlint:disable:next discouraged_optional_collection
        change: [NSKeyValueChangeKey: Any]?,
        context: UnsafeMutableRawPointer?) {
            self.action()
    }
}
