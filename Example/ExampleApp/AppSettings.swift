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

import Foil
import Foundation

enum AppSettingsKey: String, CaseIterable {
    case flagEnabled
    case totalCount
    case timestamp
    case option
}

final class AppSettings: NSObject, ObservableObject {
    static let shared = AppSettings()

    @WrappedDefault(.flagEnabled)
    @objc dynamic var flagEnabled = true {
        willSet {
            objectWillChange.send()
        }
    }

    @WrappedDefault(.totalCount)
    var totalCount = 0 {
        willSet {
            objectWillChange.send()
        }
    }

    @WrappedDefaultOptional(.timestamp)
    var timestamp: Date? {
        willSet {
            objectWillChange.send()
        }
    }

    @WrappedDefaultOptional(.option)
    var option: String? {
        willSet {
            objectWillChange.send()
        }
    }

    override private init() { }

    func reset(for key: AppSettingsKey) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
}

extension WrappedDefault {
    init(wrappedValue: T, _ key: AppSettingsKey) {
        self.init(wrappedValue: wrappedValue, key: key.rawValue)
    }
}

extension WrappedDefaultOptional {
    init(_ key: AppSettingsKey) {
        self.init(key: key.rawValue)
    }
}
