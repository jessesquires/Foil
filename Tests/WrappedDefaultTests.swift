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

final class WrappedDefaultTests: XCTestCase {

    let domain = UUID().uuidString
    lazy var testDefaults = UserDefaults.testSuite(name: self.domain)

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        testDefaults.reset(name: domain)
    }

    func test_WrappedValue_Bool() {
        let key = "key_\(#function)"
        let defaultValue = true
        var model = WrappedDefault(keyName: key, defaultValue: defaultValue, userDefaults: testDefaults)

        XCTAssertEqual(testDefaults.fetch(key), defaultValue)
        XCTAssertEqual(model.wrappedValue, defaultValue)

        let newValue = false
        model.wrappedValue = newValue
        XCTAssertEqual(testDefaults.fetch(key), newValue)
        XCTAssertEqual(model.wrappedValue, newValue)
    }

    func test_WrappedValue_Int() {
        let key = "key_\(#function)"
        let defaultValue = 42
        var model = WrappedDefault(keyName: key, defaultValue: defaultValue, userDefaults: testDefaults)

        XCTAssertEqual(testDefaults.fetch(key), defaultValue)
        XCTAssertEqual(model.wrappedValue, defaultValue)

        let newValue = 666
        model.wrappedValue = newValue
        XCTAssertEqual(testDefaults.fetch(key), newValue)
        XCTAssertEqual(model.wrappedValue, newValue)
    }

    func test_WrappedValue_Float() {
        let key = "key_\(#function)"
        let defaultValue = Float(42.0)
        var model = WrappedDefault(keyName: key, defaultValue: defaultValue, userDefaults: testDefaults)

        XCTAssertEqual(testDefaults.fetch(key), defaultValue)
        XCTAssertEqual(model.wrappedValue, defaultValue)

        let newValue = Float(66.6)
        model.wrappedValue = newValue
        XCTAssertEqual(testDefaults.fetch(key), newValue)
        XCTAssertEqual(model.wrappedValue, newValue)
    }

    func test_WrappedValue_Double() {
        let key = "key_\(#function)"
        let defaultValue = Double(42.0)
        var model = WrappedDefault(keyName: key, defaultValue: defaultValue, userDefaults: testDefaults)

        XCTAssertEqual(testDefaults.fetch(key), defaultValue)
        XCTAssertEqual(model.wrappedValue, defaultValue)

        let newValue = Double(66.6)
        model.wrappedValue = newValue
        XCTAssertEqual(testDefaults.fetch(key), newValue)
        XCTAssertEqual(model.wrappedValue, newValue)
    }

    func test_WrappedValue_String() {
        let key = "key_\(#function)"
        let defaultValue = "default-value"
        var model = WrappedDefault(keyName: key, defaultValue: defaultValue, userDefaults: testDefaults)

        XCTAssertEqual(testDefaults.fetch(key), defaultValue)
        XCTAssertEqual(model.wrappedValue, defaultValue)

        let newValue = "new-value"
        model.wrappedValue = newValue
        XCTAssertEqual(testDefaults.fetch(key), newValue)
        XCTAssertEqual(model.wrappedValue, newValue)
    }

    func test_WrappedValue_URL() {
        let key = "key_\(#function)"
        let defaultValue = URL(string: "https://hexedbits.com")!
        var model = WrappedDefault(keyName: key, defaultValue: defaultValue, userDefaults: testDefaults)

        XCTAssertEqual(testDefaults.fetch(key), defaultValue)
        XCTAssertEqual(model.wrappedValue, defaultValue)

        let newValue = URL(string: "https://jessesquires.com")!
        model.wrappedValue = newValue
        XCTAssertEqual(testDefaults.fetch(key), newValue)
        XCTAssertEqual(model.wrappedValue, newValue)
    }

    func test_WrappedValue_Date() {
        let key = "key_\(#function)"
        let defaultValue = Date.distantPast
        var model = WrappedDefault(keyName: key, defaultValue: defaultValue, userDefaults: testDefaults)

        XCTAssertEqual(testDefaults.fetch(key), defaultValue)
        XCTAssertEqual(model.wrappedValue, defaultValue)

        let newValue = Date()
        model.wrappedValue = newValue
        XCTAssertEqual(testDefaults.fetch(key), newValue)
        XCTAssertEqual(model.wrappedValue, newValue)
    }

    func test_WrappedValue_Data() {
        let key = "key_\(#function)"
        let defaultValue = "default-data".data(using: .utf8)!
        var model = WrappedDefault(keyName: key, defaultValue: defaultValue, userDefaults: testDefaults)

        XCTAssertEqual(testDefaults.fetch(key), defaultValue)
        XCTAssertEqual(model.wrappedValue, defaultValue)

        let newValue = "new-data".data(using: .utf8)!
        model.wrappedValue = newValue
        XCTAssertEqual(testDefaults.fetch(key), newValue)
        XCTAssertEqual(model.wrappedValue, newValue)
    }

    func test_WrappedValue_Array() {
        let key = "key_\(#function)"
        let defaultValue = [1, 2, 3]
        var model = WrappedDefault(keyName: key, defaultValue: defaultValue, userDefaults: testDefaults)

        XCTAssertEqual(testDefaults.fetch(key), defaultValue)
        XCTAssertEqual(model.wrappedValue, defaultValue)

        let newValue = [4, 5, 6]
        model.wrappedValue = newValue
        XCTAssertEqual(testDefaults.fetch(key), newValue)
        XCTAssertEqual(model.wrappedValue, newValue)
    }

    func test_WrappedValue_Set() {
        let key = "key_\(#function)"
        let defaultValue = Set(["one", "two", "three"])
        var model = WrappedDefault(keyName: key, defaultValue: defaultValue, userDefaults: testDefaults)

        XCTAssertEqual(testDefaults.fetch(key), defaultValue)
        XCTAssertEqual(model.wrappedValue, defaultValue)

        let newValue = Set(["four", "five", "size"])
        model.wrappedValue = newValue
        XCTAssertEqual(testDefaults.fetch(key), newValue)
        XCTAssertEqual(model.wrappedValue, newValue)
    }

    func test_WrappedValue_Dictionary() {
        let key = "key_\(#function)"
        let defaultValue = ["key1": 42.0,
                            "key2": 4.2]
        var model = WrappedDefault(keyName: key, defaultValue: defaultValue, userDefaults: testDefaults)

        XCTAssertEqual(testDefaults.fetch(key), defaultValue)
        XCTAssertEqual(model.wrappedValue, defaultValue)

        let newValue = ["key3": 0.42]
        model.wrappedValue = newValue
        XCTAssertEqual(testDefaults.fetch(key), newValue)
        XCTAssertEqual(model.wrappedValue, newValue)
    }

    func test_WrappedValue_RawRepresentable() {
        let key = "key_\(#function)"
        let defaultValue = TestFruit.apple
        var model = WrappedDefault(keyName: key, defaultValue: defaultValue, userDefaults: testDefaults)

        XCTAssertEqual(testDefaults.fetch(key), defaultValue)
        XCTAssertEqual(model.wrappedValue, defaultValue)

        let newValue = TestFruit.banana
        model.wrappedValue = newValue
        XCTAssertEqual(testDefaults.fetch(key), newValue)
        XCTAssertEqual(model.wrappedValue, newValue)
    }

    func test_WrappedValue_IntOptional() {
        let key = "key_\(#function)"
        var model = WrappedDefaultOptional<Int>(keyName: key, userDefaults: testDefaults)

        let defaultValue: Int? = testDefaults.fetchOptional(key)
        XCTAssertNil(defaultValue)
        XCTAssertNil(model.wrappedValue)

        let newValue = 666
        model.wrappedValue = newValue
        XCTAssertEqual(testDefaults.fetch(key), newValue)
        XCTAssertEqual(model.wrappedValue, newValue)

        model.wrappedValue = nil
        XCTAssertNil(model.wrappedValue)

        let fetchedValue: Int? = testDefaults.fetchOptional(key)
        XCTAssertNil(fetchedValue)
    }

    func test_WrappedValue_StringOptional() {
        let key = "key_\(#function)"
        var model = WrappedDefaultOptional<String>(keyName: key, userDefaults: testDefaults)

        let defaultValue: String? = testDefaults.fetchOptional(key)
        XCTAssertNil(defaultValue)
        XCTAssertNil(model.wrappedValue)

        let newValue = "some text"
        model.wrappedValue = newValue
        XCTAssertEqual(testDefaults.fetch(key), newValue)
        XCTAssertEqual(model.wrappedValue, newValue)

        model.wrappedValue = nil
        XCTAssertNil(model.wrappedValue)

        let fetchedValue: String? = testDefaults.fetchOptional(key)
        XCTAssertNil(fetchedValue)
    }

    func test_WrappedValue_URLOptional() {
        let key = "key_\(#function)"
        var model = WrappedDefaultOptional<URL>(keyName: key, userDefaults: testDefaults)

        let defaultValue: URL? = testDefaults.fetchOptional(key)
        XCTAssertNil(defaultValue)
        XCTAssertNil(model.wrappedValue)

        let newValue = URL(string: "www.jessesquires.com")
        model.wrappedValue = newValue
        XCTAssertEqual(testDefaults.fetch(key), newValue)
        XCTAssertEqual(model.wrappedValue, newValue)

        model.wrappedValue = nil
        XCTAssertNil(model.wrappedValue)

        let fetchedValue: URL? = testDefaults.fetchOptional(key)
        XCTAssertNil(fetchedValue)
    }

    func test_WrappedValue_DateOptional() {
        let key = "key_\(#function)"
        var model = WrappedDefaultOptional<Date>(keyName: key, userDefaults: testDefaults)

        let defaultValue: Date? = testDefaults.fetchOptional(key)
        XCTAssertNil(defaultValue)
        XCTAssertNil(model.wrappedValue)

        let newValue = Date()
        model.wrappedValue = newValue
        XCTAssertEqual(testDefaults.fetch(key), newValue)
        XCTAssertEqual(model.wrappedValue, newValue)

        model.wrappedValue = nil
        XCTAssertNil(model.wrappedValue)

        let fetchedValue: Date? = testDefaults.fetchOptional(key)
        XCTAssertNil(fetchedValue)
    }

    // swiftlint:disable discouraged_optional_collection
    func test_WrappedValue_DictionaryOptional() {
        let key = "key_\(#function)"
        var model = WrappedDefaultOptional<[String: TestFruit]>(keyName: key, userDefaults: testDefaults)

        let defaultValue: [String: TestFruit]? = testDefaults.fetchOptional(key)
        XCTAssertNil(defaultValue)
        XCTAssertNil(model.wrappedValue)

        let newValue = ["key1": TestFruit.apple, "key2": .orange]
        model.wrappedValue = newValue
        XCTAssertEqual(testDefaults.fetch(key), newValue)
        XCTAssertEqual(model.wrappedValue, newValue)

        model.wrappedValue = nil
        XCTAssertNil(model.wrappedValue)

        let fetchedValue: [String: TestFruit]? = testDefaults.fetchOptional(key)
        XCTAssertNil(fetchedValue)
    }
    // swiftlint:enable discouraged_optional_collection
}
