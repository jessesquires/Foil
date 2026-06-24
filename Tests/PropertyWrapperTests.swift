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
import Testing

@Suite("Property wrapper tests")
struct PropertyWrapperTests {

    let testDefaults: UserDefaults

    init() {
        self.testDefaults = UserDefaults.testSuite(name: UUID().uuidString)
    }

    @Test
    func test_WrappedValue_Bool() {
        let key = "key_\(#function)"
        let defaultValue = true
        var model = FoilDefaultStorage(wrappedValue: defaultValue, key: key, userDefaults: self.testDefaults)

        #expect(self.testDefaults.fetch(key) == defaultValue)
        #expect(model.wrappedValue == defaultValue)

        let newValue = false
        model.wrappedValue = newValue
        #expect(self.testDefaults.fetch(key) == newValue)
        #expect(model.wrappedValue == newValue)
    }

    @Test
    func test_WrappedValue_Int() {
        let key = "key_\(#function)"
        let defaultValue = 42
        var model = FoilDefaultStorage(wrappedValue: defaultValue, key: key, userDefaults: self.testDefaults)

        #expect(self.testDefaults.fetch(key) == defaultValue)
        #expect(model.wrappedValue == defaultValue)

        let newValue = 666
        model.wrappedValue = newValue
        #expect(self.testDefaults.fetch(key) == newValue)
        #expect(model.wrappedValue == newValue)
    }

    @Test
    func test_WrappedValue_UInt() {
        let key = "key_\(#function)"
        let defaultValue = UInt(42)
        var model = FoilDefaultStorage(wrappedValue: defaultValue, key: key, userDefaults: self.testDefaults)

        #expect(self.testDefaults.fetch(key) == defaultValue)
        #expect(model.wrappedValue == defaultValue)

        let newValue = UInt(666)
        model.wrappedValue = newValue
        #expect(self.testDefaults.fetch(key) == newValue)
        #expect(model.wrappedValue == newValue)
    }

    @Test
    func test_WrappedValue_Float() {
        let key = "key_\(#function)"
        let defaultValue = Float(42.0)
        var model = FoilDefaultStorage(wrappedValue: defaultValue, key: key, userDefaults: self.testDefaults)

        #expect(self.testDefaults.fetch(key) == defaultValue)
        #expect(model.wrappedValue == defaultValue)

        let newValue = Float(66.6)
        model.wrappedValue = newValue
        #expect(self.testDefaults.fetch(key) == newValue)
        #expect(model.wrappedValue == newValue)
    }

    @Test
    func test_WrappedValue_Double() {
        let key = "key_\(#function)"
        let defaultValue = Double(42.0)
        var model = FoilDefaultStorage(wrappedValue: defaultValue, key: key, userDefaults: self.testDefaults)

        #expect(self.testDefaults.fetch(key) == defaultValue)
        #expect(model.wrappedValue == defaultValue)

        let newValue = Double(66.6)
        model.wrappedValue = newValue
        #expect(self.testDefaults.fetch(key) == newValue)
        #expect(model.wrappedValue == newValue)
    }

    @Test
    func test_WrappedValue_String() {
        let key = "key_\(#function)"
        let defaultValue = "default-value"
        var model = FoilDefaultStorage(wrappedValue: defaultValue, key: key, userDefaults: self.testDefaults)

        #expect(self.testDefaults.fetch(key) == defaultValue)
        #expect(model.wrappedValue == defaultValue)

        let newValue = "new-value"
        model.wrappedValue = newValue
        #expect(self.testDefaults.fetch(key) == newValue)
        #expect(model.wrappedValue == newValue)
    }

    @Test
    func test_WrappedValue_URL() {
        let key = "key_\(#function)"
        let defaultValue = URL(string: "https://hexedbits.com")!
        var model = FoilDefaultStorage(wrappedValue: defaultValue, key: key, userDefaults: self.testDefaults)

        #expect(self.testDefaults.fetch(key) == defaultValue)
        #expect(model.wrappedValue == defaultValue)

        let newValue = URL(string: "https://jessesquires.com")!
        model.wrappedValue = newValue
        #expect(self.testDefaults.fetch(key) == newValue)
        #expect(model.wrappedValue == newValue)
    }

    @Test
    func test_WrappedValue_Date() {
        let key = "key_\(#function)"
        let defaultValue = Date.distantPast
        var model = FoilDefaultStorage(wrappedValue: defaultValue, key: key, userDefaults: self.testDefaults)

        #expect(self.testDefaults.fetch(key) == defaultValue)
        #expect(model.wrappedValue == defaultValue)

        let newValue = Date()
        model.wrappedValue = newValue
        #expect(self.testDefaults.fetch(key) == newValue)
        #expect(model.wrappedValue == newValue)
    }

    @Test
    func test_WrappedValue_Data() {
        let key = "key_\(#function)"
        let defaultValue = Data("default-data".utf8)
        var model = FoilDefaultStorage(wrappedValue: defaultValue, key: key, userDefaults: self.testDefaults)

        #expect(self.testDefaults.fetch(key) == defaultValue)
        #expect(model.wrappedValue == defaultValue)

        let newValue = Data("new-data".utf8)
        model.wrappedValue = newValue
        #expect(self.testDefaults.fetch(key) == newValue)
        #expect(model.wrappedValue == newValue)
    }

    @Test
    func test_WrappedValue_Array() {
        let key = "key_\(#function)"
        let defaultValue = [1, 2, 3]
        var model = FoilDefaultStorage(wrappedValue: defaultValue, key: key, userDefaults: self.testDefaults)

        #expect(self.testDefaults.fetch(key) == defaultValue)
        #expect(model.wrappedValue == defaultValue)

        let newValue = [4, 5, 6]
        model.wrappedValue = newValue
        #expect(self.testDefaults.fetch(key) == newValue)
        #expect(model.wrappedValue == newValue)
    }

    @Test
    func test_WrappedValue_Set() {
        let key = "key_\(#function)"
        let defaultValue = Set(["one", "two", "three"])
        var model = FoilDefaultStorage(wrappedValue: defaultValue, key: key, userDefaults: self.testDefaults)

        #expect(self.testDefaults.fetch(key) == defaultValue)
        #expect(model.wrappedValue == defaultValue)

        let newValue = Set(["four", "five", "size"])
        model.wrappedValue = newValue
        #expect(self.testDefaults.fetch(key) == newValue)
        #expect(model.wrappedValue == newValue)
    }

    @Test
    func test_WrappedValue_Dictionary() {
        let key = "key_\(#function)"
        let defaultValue = ["key1": 42.0,
                            "key2": 4.2]
        var model = FoilDefaultStorage(wrappedValue: defaultValue, key: key, userDefaults: self.testDefaults)

        #expect(self.testDefaults.fetch(key) == defaultValue)
        #expect(model.wrappedValue == defaultValue)

        let newValue = ["key3": 0.42]
        model.wrappedValue = newValue
        #expect(self.testDefaults.fetch(key) == newValue)
        #expect(model.wrappedValue == newValue)
    }

    @Test
    func test_WrappedValue_RawRepresentable() {
        let key = "key_\(#function)"
        let defaultValue = TestFruit.apple
        var model = FoilDefaultStorage(wrappedValue: defaultValue, key: key, userDefaults: self.testDefaults)

        #expect(self.testDefaults.fetch(key) == defaultValue)
        #expect(model.wrappedValue == defaultValue)

        let newValue = TestFruit.banana
        model.wrappedValue = newValue
        #expect(self.testDefaults.fetch(key) == newValue)
        #expect(model.wrappedValue == newValue)
    }

    @Test
    func test_WrappedValue_IntOptional() {
        let key = "key_\(#function)"
        var model = FoilDefaultStorageOptional<Int>(key: key, userDefaults: self.testDefaults)

        let defaultValue: Int? = self.testDefaults.fetchOptional(key)
        #expect(defaultValue == nil)
        #expect(model.wrappedValue == nil)

        let newValue = 666
        model.wrappedValue = newValue
        #expect(self.testDefaults.fetch(key) == newValue)
        #expect(model.wrappedValue == newValue)

        model.wrappedValue = nil
        #expect(model.wrappedValue == nil)

        let fetchedValue: Int? = self.testDefaults.fetchOptional(key)
        #expect(fetchedValue == nil)
    }

    @Test
    func test_WrappedValue_StringOptional() {
        let key = "key_\(#function)"
        var model = FoilDefaultStorageOptional<String>(key: key, userDefaults: self.testDefaults)

        let defaultValue: String? = self.testDefaults.fetchOptional(key)
        #expect(defaultValue == nil)
        #expect(model.wrappedValue == nil)

        let newValue = "some text"
        model.wrappedValue = newValue
        #expect(self.testDefaults.fetch(key) == newValue)
        #expect(model.wrappedValue == newValue)

        model.wrappedValue = nil
        #expect(model.wrappedValue == nil)

        let fetchedValue: String? = self.testDefaults.fetchOptional(key)
        #expect(fetchedValue == nil)
    }

    @Test
    func test_WrappedValue_URLOptional() {
        let key = "key_\(#function)"
        var model = FoilDefaultStorageOptional<URL>(key: key, userDefaults: self.testDefaults)

        let defaultValue: URL? = self.testDefaults.fetchOptional(key)
        #expect(defaultValue == nil)
        #expect(model.wrappedValue == nil)

        let newValue = URL(string: "www.jessesquires.com")
        model.wrappedValue = newValue
        #expect(self.testDefaults.fetch(key) == newValue)
        #expect(model.wrappedValue == newValue)

        model.wrappedValue = nil
        #expect(model.wrappedValue == nil)

        let fetchedValue: URL? = self.testDefaults.fetchOptional(key)
        #expect(fetchedValue == nil)
    }

    @Test
    func test_WrappedValue_DateOptional() {
        let key = "key_\(#function)"
        var model = FoilDefaultStorageOptional<Date>(key: key, userDefaults: self.testDefaults)

        let defaultValue: Date? = self.testDefaults.fetchOptional(key)
        #expect(defaultValue == nil)
        #expect(model.wrappedValue == nil)

        let newValue = Date()
        model.wrappedValue = newValue
        #expect(self.testDefaults.fetch(key) == newValue)
        #expect(model.wrappedValue == newValue)

        model.wrappedValue = nil
        #expect(model.wrappedValue == nil)

        let fetchedValue: Date? = self.testDefaults.fetchOptional(key)
        #expect(fetchedValue == nil)
    }


    @Test// swiftlint:disable discouraged_optional_collection
    func test_WrappedValue_DictionaryOptional() {
        let key = "key_\(#function)"
        var model = FoilDefaultStorageOptional<[String: TestFruit]>(key: key, userDefaults: self.testDefaults)

        let defaultValue: [String: TestFruit]? = self.testDefaults.fetchOptional(key)
        #expect(defaultValue == nil)
        #expect(model.wrappedValue == nil)

        let newValue = ["key1": TestFruit.apple, "key2": .orange]
        model.wrappedValue = newValue
        #expect(self.testDefaults.fetch(key) == newValue)
        #expect(model.wrappedValue == newValue)

        model.wrappedValue = nil
        #expect(model.wrappedValue == nil)

        let fetchedValue: [String: TestFruit]? = self.testDefaults.fetchOptional(key)
        #expect(fetchedValue == nil)
    }
    // swiftlint:enable discouraged_optional_collection

    @Test
    func test_WrappedValue_MismatchedOptional() {
        let key = "key_\(#function)"
        let model = FoilDefaultStorageOptional<Date>(key: key, userDefaults: self.testDefaults)
        testDefaults.save("not-a-date", for: key)

        let defaultValue: Date? = self.testDefaults.fetchOptional(key)
        #expect(defaultValue == nil)
        #expect(model.wrappedValue == nil)
    }

    @Test
    func test_WrappedValue_Codable_Optional() {
        let key = "key_\(#function)"
        var model = FoilDefaultStorageOptional<User>(key: key, userDefaults: self.testDefaults)

        let defaultValue: User? = self.testDefaults.fetchOptional(key)
        #expect(defaultValue == nil)
        #expect(model.wrappedValue == nil)

        let newValue = User(id: UUID(), name: "John Doe", highScore: 9_000, lastLogin: Date())
        model.wrappedValue = newValue
        #expect(self.testDefaults.fetch(key) == newValue)
        #expect(model.wrappedValue == newValue)

        model.wrappedValue = nil
        #expect(model.wrappedValue == nil)

        let fetchedValue: User? = self.testDefaults.fetchOptional(key)
        #expect(fetchedValue == nil)
    }
}
