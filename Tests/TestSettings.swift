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

    subscript(_ key: Key) -> TestFruit? {
        get { self.rawValue[key.rawValue] }
        set { self.rawValue[key.rawValue] = newValue }
    }
}

struct User: Hashable, Codable, UserDefaultsSerializable {
    let id: UUID
    let name: String
    let highScore: Double
    let lastLogin: Date
}

final class TestSettings: NSObject {
    static let suiteName = UUID().uuidString

    static let store = UserDefaults.testSuite(name: suiteName)

    // swiftlint:disable:next type_contents_order
    static func reset() {
        Self.store.reset(name: Self.suiteName)
    }

    @WrappedDefault(key: "flag", userDefaults: store)
    var flag = true

    @WrappedDefault(key: "count", userDefaults: store)
    var count = 42

    @WrappedDefault(key: "max", userDefaults: store)
    var max = UInt(42)

    @WrappedDefault(key: "mean", userDefaults: store)
    var mean = Float(4.2)

    @WrappedDefault(key: "average", userDefaults: store)
    var average = 42.0

    @WrappedDefaultOptional(key: "username", userDefaults: store)
    var username: String?

    @WrappedDefaultOptional(key: "website", userDefaults: store)
    var website: URL?

    @WrappedDefault(key: "timestamp", userDefaults: store)
    var timestamp = Date.distantPast

    @WrappedDefaultOptional(key: "data", userDefaults: store)
    var data: Data?

    @WrappedDefault(key: "list", userDefaults: store)
    var list = [Double]()

    @WrappedDefault(key: "set", userDefaults: store)
    var set = Set([1, 2, 3])

    @WrappedDefault(key: "pairs", userDefaults: store)
    var pairs = [String: Int]()

    @WrappedDefault(key: "fruit", userDefaults: store)
    var fruit = TestFruit.apple

    @WrappedDefault(key: "customRawRepresented", userDefaults: store)
    var customRawRepresented = TestCustomRepresented(rawValue: [:])

    @WrappedDefaultOptional(key: "userId", userDefaults: store)
    @objc dynamic var userId: String?

    @WrappedDefaultOptional(key: "user", userDefaults: store)
    var user: User?
}
