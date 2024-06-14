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
    case option
    case timestamp
    case totalCount
}

final class AppSettings: NSObject, ObservableObject, @unchecked Sendable {
    static let shared = AppSettings()

    @FoilDefaultStorage(.flagEnabled)
    @objc dynamic var flagEnabled = true {
        willSet {
            objectWillChange.send()
        }
    }

    @FoilDefaultStorage(.totalCount)
    var totalCount = 0 {
        willSet {
            objectWillChange.send()
        }
    }

    @FoilDefaultStorageOptional(.timestamp)
    var timestamp: Date? {
        willSet {
            objectWillChange.send()
        }
    }

    @FoilDefaultStorageOptional(.option)
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

extension FoilDefaultStorage {
    init(wrappedValue: T, _ key: AppSettingsKey) {
        self.init(wrappedValue: wrappedValue, key: key.rawValue)
    }
}

extension FoilDefaultStorageOptional {
    init(_ key: AppSettingsKey) {
        self.init(key: key.rawValue)
    }
}
