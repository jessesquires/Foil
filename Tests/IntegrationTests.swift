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
import XCTest

final class IntegrationTests: XCTestCase {

    let settings = TestSettings()

    override func setUpWithError() throws {
        try super.setUpWithError()
        TestSettings.reset()
    }

    func test_Integration_Bool() {
        let defaultValue = self.settings.flag
        XCTAssertTrue(defaultValue)

        self.settings.flag = false
        XCTAssertFalse(TestSettings.store.fetch("flag"))
    }

    func test_Integration_Int() {
        let defaultValue = self.settings.count
        XCTAssertEqual(defaultValue, 42)

        let newValue = 666
        self.settings.count = newValue
        XCTAssertEqual(TestSettings.store.fetch("count"), newValue)
    }

    func test_Integration_UInt() {
        let defaultValue = self.settings.max
        XCTAssertEqual(defaultValue, 42)

        let newValue = UInt(666)
        self.settings.max = newValue
        XCTAssertEqual(TestSettings.store.fetch("max"), newValue)
    }

    func test_Integration_Float() {
        let defaultValue = self.settings.mean
        XCTAssertEqual(defaultValue, 4.2)

        let newValue = Float(66.6)
        self.settings.mean = newValue
        XCTAssertEqual(TestSettings.store.fetch("mean"), newValue)
    }

    func test_Integration_Double() {
        let defaultValue = self.settings.average
        XCTAssertEqual(defaultValue, 42.0)

        let newValue = 6.66
        self.settings.average = newValue
        XCTAssertEqual(TestSettings.store.fetch("average"), newValue)
    }

    func test_Integration_StringOptional() {
        let defaultValue = self.settings.username
        XCTAssertNil(defaultValue)

        let newValue = "@jessesquires"
        self.settings.username = newValue
        XCTAssertEqual(TestSettings.store.fetch("username"), newValue)

        self.settings.username = nil
        XCTAssertNil(TestSettings.store.fetchOptional("username") as String?)
    }

    func test_Integration_URLOptional() {
        let defaultValue = self.settings.website
        XCTAssertNil(defaultValue)

        let newValue = URL(string: "www.jessesquires.com")
        self.settings.website = newValue
        XCTAssertEqual(TestSettings.store.fetch("website"), newValue)

        self.settings.website = nil
        XCTAssertNil(TestSettings.store.fetchOptional("website") as URL?)
    }

    func test_Integration_Date() {
        let defaultValue = self.settings.timestamp
        XCTAssertEqual(defaultValue, .distantPast)

        let newValue = Date()
        self.settings.timestamp = newValue
        XCTAssertEqual(TestSettings.store.fetch("timestamp"), newValue)
    }

    func test_Integration_DataOptional() {
        let defaultValue = self.settings.data
        XCTAssertNil(defaultValue)

        let newValue = "text data".data(using: .utf8)
        self.settings.data = newValue
        XCTAssertEqual(TestSettings.store.fetch("data"), newValue)

        self.settings.data = nil
        XCTAssertNil(TestSettings.store.fetchOptional("data") as Data?)
    }

    func test_Integration_Array() {
        let defaultValue = self.settings.list
        XCTAssertEqual(defaultValue, [])

        let newValue = [6.66, 7.77, 8.88]
        self.settings.list = newValue
        XCTAssertEqual(TestSettings.store.fetch("list"), newValue)
    }

    func test_Integration_Set() {
        let defaultValue = self.settings.set
        XCTAssertEqual(defaultValue, [1, 2, 3])

        let newValue = Set([6, 77, 888])
        self.settings.set = newValue
        XCTAssertEqual(TestSettings.store.fetch("set"), newValue)
    }

    func test_Integration_Dictionary() {
        let defaultValue = self.settings.pairs
        XCTAssertEqual(defaultValue, [:])

        let newValue = ["six": 6, "seventy-seven": 77, "eight-hundred eighty eight": 888]
        self.settings.pairs = newValue
        XCTAssertEqual(TestSettings.store.fetch("pairs"), newValue)
    }

    func test_Integration_RawRepresentable() {
        let defaultValue = self.settings.fruit
        XCTAssertEqual(defaultValue, .apple)

        let newValue = TestFruit.orange
        self.settings.fruit = newValue
        XCTAssertEqual(TestSettings.store.fetch("fruit"), newValue)
    }

    func test_Integration_Custom_RawRepresentable() {
        let defaultValue = self.settings.customRawRepresented
        XCTAssert(defaultValue.rawValue.isEmpty)

        var newValue = TestFruit.apple
        self.settings.customRawRepresented[.key1] = newValue
        XCTAssertEqual(self.settings.customRawRepresented[.key1], newValue)

        newValue = TestFruit.orange
        self.settings.customRawRepresented[.key2] = newValue
        XCTAssertEqual(self.settings.customRawRepresented[.key2], newValue)

        let expectedValue = ["key1": TestFruit.apple.rawValue, "key2": TestFruit.orange.rawValue]
        XCTAssertEqual(TestSettings.store.fetch("customRawRepresented"), expectedValue)
    }

    func test_Integration_Codable() {
        let defaultValue = self.settings.user
        XCTAssertNil(defaultValue)

        let newValue = User(id: UUID(), name: "John Doe", highScore: 9_999, lastLogin: Date())
        self.settings.user = newValue
        XCTAssertEqual(self.settings.user, newValue)
    }
}
