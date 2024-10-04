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
    case banana
    case orange
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

final class TestSettings: NSObject, @unchecked Sendable {
    static let suiteName = UUID().uuidString

    nonisolated(unsafe) static let store = UserDefaults.testSuite(name: suiteName)

    // swiftlint:disable:next type_contents_order
    static func reset() {
        Self.store.reset(name: Self.suiteName)
    }

    @FoilDefaultStorage(key: "flag", userDefaults: store)
    var flag = true

    @FoilDefaultStorage(key: "count", userDefaults: store)
    var count = 42

    @FoilDefaultStorage(key: "max", userDefaults: store)
    var max = UInt(42)

    @FoilDefaultStorage(key: "mean", userDefaults: store)
    var mean = Float(4.2)

    @FoilDefaultStorage(key: "average", userDefaults: store)
    var average = 42.0

    @FoilDefaultStorageOptional(key: "username", userDefaults: store)
    var username: String?

    @FoilDefaultStorageOptional(key: "website", userDefaults: store)
    var website: URL?

    @FoilDefaultStorage(key: "timestamp", userDefaults: store)
    var timestamp = Date.distantPast

    @FoilDefaultStorageOptional(key: "data", userDefaults: store)
    var data: Data?

    @FoilDefaultStorage(key: "list", userDefaults: store)
    var list = [Double]()

    @FoilDefaultStorage(key: "set", userDefaults: store)
    var set = Set([1, 2, 3])

    @FoilDefaultStorage(key: "pairs", userDefaults: store)
    var pairs = [String: Int]()

    @FoilDefaultStorage(key: "fruit", userDefaults: store)
    var fruit = TestFruit.apple

    @FoilDefaultStorage(key: "customRawRepresented", userDefaults: store)
    var customRawRepresented = TestCustomRepresented(rawValue: [:])

    @FoilDefaultStorageOptional(key: "userId", userDefaults: store)
    @objc dynamic var userId: String?

    @FoilDefaultStorageOptional(key: "user", userDefaults: store)
    var user: User?
}
