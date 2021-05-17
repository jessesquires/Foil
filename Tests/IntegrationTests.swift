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

        settings.flag = false
        XCTAssertFalse(TestSettings.store.fetch("flag"))
    }

    func test_Integration_Int() {
        let defaultValue = settings.count
        XCTAssertEqual(defaultValue, 42)

        let newValue = 666
        settings.count = newValue
        XCTAssertEqual(TestSettings.store.fetch("count"), newValue)
    }

    func test_Integration_Float() {
        let defaultValue = settings.mean
        XCTAssertEqual(defaultValue, 4.2)

        let newValue = Float(66.6)
        settings.mean = newValue
        XCTAssertEqual(TestSettings.store.fetch("mean"), newValue)
    }

    func test_Integration_Double() {
        let defaultValue = settings.average
        XCTAssertEqual(defaultValue, 42.0)

        let newValue = 6.66
        settings.average = newValue
        XCTAssertEqual(TestSettings.store.fetch("average"), newValue)
    }

    func test_Integration_StringOptional() {
        let defaultValue = settings.username
        XCTAssertNil(defaultValue)

        let newValue = "@jessesquires"
        settings.username = newValue
        XCTAssertEqual(TestSettings.store.fetch("username"), newValue)

        settings.username = nil
        XCTAssertNil(TestSettings.store.fetchOptional("username") as String?)
    }

    func test_Integration_URLOptional() {
        let defaultValue = settings.website
        XCTAssertNil(defaultValue)

        let newValue = URL(string: "www.jessesquires.com")
        settings.website = newValue
        XCTAssertEqual(TestSettings.store.fetch("website"), newValue)

        settings.website = nil
        XCTAssertNil(TestSettings.store.fetchOptional("website") as URL?)
    }

    func test_Integration_Date() {
        let defaultValue = settings.timestamp
        XCTAssertEqual(defaultValue, .distantPast)

        let newValue = Date()
        settings.timestamp = newValue
        XCTAssertEqual(TestSettings.store.fetch("timestamp"), newValue)
    }

    func test_Integration_DataOptional() {
        let defaultValue = settings.data
        XCTAssertNil(defaultValue)

        let newValue = "text data".data(using: .utf8)
        settings.data = newValue
        XCTAssertEqual(TestSettings.store.fetch("data"), newValue)

        settings.data = nil
        XCTAssertNil(TestSettings.store.fetchOptional("data") as URL?)
    }

    func test_Integration_Array() {
        let defaultValue = settings.list
        XCTAssertEqual(defaultValue, [])

        let newValue = [6.66, 7.77, 8.88]
        settings.list = newValue
        XCTAssertEqual(TestSettings.store.fetch("list"), newValue)
    }

    func test_Integration_Set() {
        let defaultValue = settings.set
        XCTAssertEqual(defaultValue, [1, 2, 3])

        let newValue = Set([6, 77, 888])
        settings.set = newValue
        XCTAssertEqual(TestSettings.store.fetch("set"), newValue)
    }

    func test_Integration_Dictionary() {
        let defaultValue = settings.pairs
        XCTAssertEqual(defaultValue, [:])

        let newValue = ["six": 6, "seventy-seven": 77, "eight-hundred eighty eight": 888]
        settings.pairs = newValue
        XCTAssertEqual(TestSettings.store.fetch("pairs"), newValue)
    }

    func test_Integration_RawRepresentable() {
        let defaultValue = settings.fruit
        XCTAssertEqual(defaultValue, .apple)

        let newValue = TestFruit.orange
        settings.fruit = newValue
        XCTAssertEqual(TestSettings.store.fetch("fruit"), newValue)
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
