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
}

final class AppSettings {
    static let shared = AppSettings()

    @WrappedDefault(key: .flagEnabled, defaultValue: true)
    var flagEnabled: Bool

    @WrappedDefault(key: .totalCount, defaultValue: 0)
    var totalCount: Int

    @WrappedDefaultOptional(key: .timestamp)
    var timestamp: Date?

    private init() { }

    func reset(for key: AppSettingsKey) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
}

extension WrappedDefault {
    init(key: AppSettingsKey, defaultValue: T) {
        self.init(keyName: key.rawValue, defaultValue: defaultValue)
    }
}

extension WrappedDefaultOptional {
    init(key: AppSettingsKey) {
        self.init(keyName: key.rawValue)
    }
}
