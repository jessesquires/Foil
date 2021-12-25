//
// Created by Jesse Squires on 3/18/21.
// Copyright © 2021 Hexed Bits. All rights reserved.
// 

import Foil
import Foundation

enum AppSettingsKey: String, CaseIterable {
    case flagEnabled
    case totalCount
    case timestamp
    case option
}

final class AppSettings: NSObject {
    static let shared = AppSettings()

    @WrappedDefault(.flagEnabled)
    @objc dynamic var flagEnabled = true

    @WrappedDefault(.totalCount)
    var totalCount = 0

    @WrappedDefaultOptional(.timestamp)
    var timestamp: Date?

    @WrappedDefaultOptional(.option)
    var option: String?

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
