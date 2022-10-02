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

/// Watches for changes to UserDefaults using old-school Key-Value Observing.
///
/// KVO allows us to be notified of changes from anywhere (including other processes), not just via the property wrapper's setter.
///
/// We can't use Swift's block-based KVO because that requires a KeyPath, which we cannot create from a String.
final class ObserverTrampoline: NSObject {
    private let userDefaults: UserDefaults
    private let key: String
    private let block: () -> Void

    init(userDefaults: UserDefaults, key: String, block: @escaping () -> Void) {
        assert(!key.hasPrefix("@"), "Cannot observe a user default key starting with '@'")
        assert(!key.contains("."), "Cannot observe a user default key containing '.'")
        self.userDefaults = userDefaults
        self.key = key
        self.block = block
        super.init()

        userDefaults.addObserver(self, forKeyPath: key, context: nil)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        block()
    }

    deinit {
        userDefaults.removeObserver(self, forKeyPath: key, context: nil)
    }
}
