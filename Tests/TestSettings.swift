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
    let suiteName: String
    let store: UserDefaults

    var flag: FoilDefaultStorage<Bool>
    var count: FoilDefaultStorage<Int>
    var max: FoilDefaultStorage<UInt>
    var mean: FoilDefaultStorage<Float>
    var average: FoilDefaultStorage<Double>
    var username: FoilDefaultStorageOptional<String>
    var website: FoilDefaultStorageOptional<URL>
    var timestamp: FoilDefaultStorage<Date>
    var data: FoilDefaultStorageOptional<Data>
    var list: FoilDefaultStorage<Array<Double>>
    var set: FoilDefaultStorage<Set<Int>>
    var pairs: FoilDefaultStorage<[String:Int]>
    var fruit: FoilDefaultStorage<TestFruit>
    var customRawRepresented: FoilDefaultStorage<TestCustomRepresented>
    var _userId: FoilDefaultStorageOptional<String>
    @objc dynamic var userId: String? {
        get { _userId.wrappedValue }
        set { _userId.wrappedValue = newValue }
    }
    var user: FoilDefaultStorageOptional<User>

    init(suiteName: String) {
        self.suiteName = suiteName
        self.store = UserDefaults.testSuite(name: suiteName)

        self.flag = .init(wrappedValue: true, key: "flag", userDefaults: store)
        self.count = .init(wrappedValue: 42, key: "count", userDefaults: store)
        self.max = .init(wrappedValue: UInt(42), key: "max", userDefaults: store)
        self.mean = .init(wrappedValue: Float(4.2), key: "mean", userDefaults: store)
        self.average = .init(wrappedValue: Double(42.0), key: "average", userDefaults: store)
        self.username = .init(key: "username", userDefaults: store)
        self.website = .init(key: "website", userDefaults: store)
        self.timestamp = .init(wrappedValue: Date.distantPast, key: "timestamp", userDefaults: store)
        self.data = .init(key: "data", userDefaults: store)
        self.list = .init(wrappedValue: [Double](), key: "list", userDefaults: store)
        self.set = .init(wrappedValue:  Set([1, 2, 3]), key: "set", userDefaults: store)
        self.pairs = .init(wrappedValue: [String: Int](), key: "pairs", userDefaults: store)
        self.fruit = .init(wrappedValue: TestFruit.apple, key: "fruit", userDefaults: store)
        self.customRawRepresented = FoilDefaultStorage(
            wrappedValue: TestCustomRepresented(rawValue: [:]),
            key: "customRawRepresented",
            userDefaults: store
        )
        self._userId =  .init(key: "userId", userDefaults: store)
        self.user = .init(key: "user", userDefaults: store)
    }

    // swiftlint:disable:next type_contents_order
    func reset() {
        store.reset(name: suiteName)
    }
}
