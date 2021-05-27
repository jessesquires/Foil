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

@testable import Foil
import Foundation

enum TestFruit: String, UserDefaultsSerializable {
    case apple
    case orange
    case banana
}

struct TestCustomRepresented: RawRepresentable, UserDefaultsSerializable {
    enum Key: String {
        case key1, key2, key3
    }

    var rawValue: [String: TestFruit]

    init(rawValue: [String: TestFruit]) {
        self.rawValue = rawValue
    }

    subscript(_ key: Key) -> TestFruit? {
        get { rawValue[key.rawValue] }
        set { rawValue[key.rawValue] = newValue }
    }
}

final class TestSettings: NSObject {

    static var store = UserDefaults.testSuite()

    @WrappedDefault(keyName: "flag", defaultValue: true, userDefaults: store)
    var flag: Bool

    @WrappedDefault(keyName: "count", defaultValue: 42, userDefaults: store)
    var count: Int

    @WrappedDefault(keyName: "max", defaultValue: 42, userDefaults: store)
    var max: UInt

    @WrappedDefault(keyName: "mean", defaultValue: 4.2, userDefaults: store)
    var mean: Float

    @WrappedDefault(keyName: "average", defaultValue: 42.0, userDefaults: store)
    var average: Double

    @WrappedDefaultOptional(keyName: "username", userDefaults: store)
    var username: String?

    @WrappedDefaultOptional(keyName: "website", userDefaults: store)
    var website: URL?

    @WrappedDefault(keyName: "timestamp", defaultValue: .distantPast, userDefaults: store)
    var timestamp: Date

    @WrappedDefaultOptional(keyName: "data", userDefaults: store)
    var data: Data?

    @WrappedDefault(keyName: "list", defaultValue: [], userDefaults: store)
    var list: [Double]

    @WrappedDefault(keyName: "set", defaultValue: [1, 2, 3], userDefaults: store)
    var set: Set<Int>

    @WrappedDefault(keyName: "pairs", defaultValue: [:], userDefaults: store)
    var pairs: [String: Int]

    @WrappedDefault(keyName: "fruit", defaultValue: .apple, userDefaults: store)
    var fruit: TestFruit

    @WrappedDefault(keyName: "customRawRepresented", defaultValue: TestCustomRepresented(rawValue: [:]), userDefaults: store)
    var customRawRepresented: TestCustomRepresented

    @WrappedDefaultOptional(keyName: "nickname", userDefaults: store)
    @objc dynamic var nickname: String?
}
