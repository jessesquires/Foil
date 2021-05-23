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

import Combine
@testable import Foil
import XCTest

final class IntegrationTests: XCTestCase {

    let settings = TestSettings()
    var cancellable = Set<AnyCancellable>()

    func test_Integration_Bool() {
        let defaultValue = settings.flag
        XCTAssertTrue(defaultValue)
        XCTAssertTrue(TestSettings.store.bool(forKey: "flag"))

        settings.flag = false
        XCTAssertFalse(TestSettings.store.bool(forKey: "flag"))
    }

    func test_Integration_Int() {
        let defaultValue = settings.count
        XCTAssertEqual(defaultValue, 42)
        XCTAssertEqual(TestSettings.store.integer(forKey: "count"), defaultValue)

        let newValue = 666
        settings.count = newValue
        XCTAssertEqual(TestSettings.store.integer(forKey: "count"), newValue)
    }

    func test_Integration_IntOptional() {
        let defaultValue = settings.countOptional
        XCTAssertNil(defaultValue)

        let newValue = 5
        settings.countOptional = newValue
        XCTAssertEqual(TestSettings.store.object(forKey: "countOptional") as? Int, newValue)

        settings.countOptional = nil
        XCTAssertNil(TestSettings.store.object(forKey: "countOptional"))
    }

    func test_Integration_Float() {
        let defaultValue = settings.mean
        XCTAssertEqual(defaultValue, 4.2)
        XCTAssertEqual(TestSettings.store.float(forKey: "mean"), defaultValue)

        let newValue = Float(66.6)
        settings.mean = newValue
        XCTAssertEqual(TestSettings.store.float(forKey: "mean"), newValue)
    }

    func test_Integration_Double() {
        let defaultValue = settings.average
        XCTAssertEqual(defaultValue, 42.0)
        XCTAssertEqual(TestSettings.store.double(forKey: "average"), defaultValue)

        let newValue = 6.66
        settings.average = newValue
        XCTAssertEqual(TestSettings.store.double(forKey: "average"), newValue)
    }

    func test_Integration_StringOptional() {
        let defaultValue = settings.username
        XCTAssertNil(defaultValue)

        let newValue = "@jessesquires"
        settings.username = newValue
        XCTAssertEqual(TestSettings.store.string(forKey: "username"), newValue)

        settings.username = nil
        XCTAssertNil(TestSettings.store.string(forKey: "username") as String?)
    }

    func test_Integration_URLOptional() {
        let defaultValue = settings.website
        XCTAssertNil(defaultValue)

        let newValue = URL(string: "www.jessesquires.com")
        settings.website = newValue
        XCTAssertEqual(TestSettings.store.url(forKey: "website"), newValue)

        settings.website = nil
        XCTAssertNil(TestSettings.store.url(forKey: "website") as URL?)
    }

    func test_Integration_Date() {
        let defaultValue = settings.timestamp
        XCTAssertEqual(defaultValue, .distantPast)
        XCTAssertEqual(TestSettings.store.object(forKey: "timestamp") as? Date, defaultValue)

        let newValue = Date()
        settings.timestamp = newValue
        XCTAssertEqual(TestSettings.store.object(forKey: "timestamp") as? Date, newValue)
    }

    func test_Integration_DataOptional() {
        let defaultValue = settings.data
        XCTAssertNil(defaultValue)

        let newValue = "text data".data(using: .utf8)
        settings.data = newValue
        XCTAssertEqual(TestSettings.store.data(forKey: "data"), newValue)

        settings.data = nil
        XCTAssertNil(TestSettings.store.data(forKey: "data"))
    }

    func test_Integration_Array() {
        let defaultValue = settings.list
        XCTAssertEqual(defaultValue, [])
        XCTAssertEqual(TestSettings.store.array(forKey: "list") as? [Double], defaultValue)

        let newValue = [6.66, 7.77, 8.88]
        settings.list = newValue
        XCTAssertEqual(TestSettings.store.array(forKey: "list") as? [Double], newValue)
    }

    func test_Integration_Set() {
        let defaultValue = settings.set
        XCTAssertEqual(defaultValue, [1, 2, 3])

        let newValue = Set([6, 77, 888])
        settings.set = newValue
        XCTAssertEqual(TestSettings.store.object(forKey: "set") as? Set<Int>.StoredValue, newValue.storedValue)
    }

    func test_Integration_Dictionary() {
        let defaultValue = settings.pairs
        XCTAssertEqual(defaultValue, [:])
        XCTAssertEqual(TestSettings.store.dictionary(forKey: "pairs") as? [String: Int], defaultValue)

        let newValue = ["six": 6, "seventy-seven": 77, "eight-hundred eighty eight": 888]
        settings.pairs = newValue
        XCTAssertEqual(TestSettings.store.dictionary(forKey: "pairs") as? [String: Int], newValue)
    }

    func test_Integration_RawRepresentable() {
        let defaultValue = settings.fruit
        XCTAssertEqual(defaultValue, .apple)
        XCTAssertEqual(TestSettings.store.object(forKey: "fruit") as? TestFruit.StoredValue, TestFruit.apple.rawValue)

        let newValue = TestFruit.orange
        settings.fruit = newValue
        XCTAssertEqual(TestSettings.store.object(forKey: "fruit") as? TestFruit.StoredValue, newValue.storedValue)
    }

    func test_Integration_CustomType() {
        let defaultValue = settings.custom
        XCTAssertNil(defaultValue)

        let newValue = CustomType(abc: "test", xyz: 123)
        settings.custom = newValue
        XCTAssertEqual(settings.custom?.abc, "test")
        XCTAssertEqual(settings.custom?.xyz, 123)
        XCTAssertEqual(TestSettings.store.object(forKey: "custom") as? CustomType.StoredValue, "test|123")

        settings.custom = nil
        XCTAssertNil(TestSettings.store.object(forKey: "custom"))
    }

    func test_Integration_Publisher() {
        let promise = expectation(description: #function)
        var publishedValue: String?

        settings
            .publisher(for: \.nickname, options: [.new])
            .sink {
                publishedValue = $0
                promise.fulfill()
            }
            .store(in: &cancellable)

        settings.nickname = "abc123"
        wait(for: [promise], timeout: 5)

        XCTAssertEqual(settings.nickname, publishedValue)
    }
}
