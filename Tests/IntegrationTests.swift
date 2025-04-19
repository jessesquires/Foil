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


@Suite("Integration tests")
struct IntegrationTests {

    let settings = TestSettings(suiteName: UUID().uuidString)

    @Test
    func test_Integration_Bool() {
        let defaultValue = settings.flag.wrappedValue
        #expect(defaultValue)

        settings.flag.wrappedValue = false
        #expect(settings.store.fetch("flag") == false)
    }

    @Test
    func test_Integration_Int() {
        let defaultValue = settings.count.wrappedValue
        #expect(defaultValue == 42)

        let newValue = 666
        settings.count.wrappedValue = newValue
        #expect(settings.store.fetch("count") == newValue)
    }

    @Test
    func test_Integration_UInt() {
        let defaultValue = settings.max.wrappedValue
        #expect(defaultValue == 42)

        let newValue = UInt(666)
        settings.max.wrappedValue = newValue
        #expect(settings.store.fetch("max") == newValue)
    }

    @Test
    func test_Integration_Float() {
        let defaultValue = settings.mean.wrappedValue
        #expect(defaultValue == 4.2)

        let newValue = Float(66.6)
        settings.mean.wrappedValue = newValue
        #expect(settings.store.fetch("mean") == newValue)
    }

    @Test
    func test_Integration_Double() {
        let defaultValue = settings.average.wrappedValue
        #expect(defaultValue == 42.0)

        let newValue = 6.66
        settings.average.wrappedValue = newValue
        #expect(settings.store.fetch("average") == newValue)
    }

    @Test
    func test_Integration_StringOptional() {
        let defaultValue = settings.username.wrappedValue
        #expect(defaultValue == nil)

        let newValue = "@jessesquires"
        settings.username.wrappedValue = newValue
        #expect(settings.store.fetch("username") == newValue)

        settings.username.wrappedValue = nil
        #expect(settings.store.fetchOptional("username") as String? == nil)
    }

    @Test
    func test_Integration_URLOptional() {
        let defaultValue = settings.website.wrappedValue
        #expect(defaultValue == nil)

        let newValue = URL(string: "www.jessesquires.com")
        settings.website.wrappedValue = newValue
        #expect(settings.store.fetch("website") == newValue)

        settings.website.wrappedValue = nil
        #expect(settings.store.fetchOptional("website") as URL? == nil)
    }

    @Test
    func test_Integration_Date() {
        let defaultValue = settings.timestamp.wrappedValue
        #expect(defaultValue == .distantPast)

        let newValue = Date()
        settings.timestamp.wrappedValue = newValue
        #expect(settings.store.fetch("timestamp") == newValue)
    }

    @Test
    func test_Integration_DataOptional() {
        let defaultValue = settings.data.wrappedValue
        #expect(defaultValue == nil)

        let newValue = Data("text data".utf8)
        settings.data.wrappedValue = newValue
        #expect(settings.store.fetch("data") == newValue)

        settings.data.wrappedValue = nil
        #expect(settings.store.fetchOptional("data") as Data? == nil)
    }

    @Test
    func test_Integration_Array() {
        let defaultValue = settings.list.wrappedValue
        #expect(defaultValue == [])

        let newValue = [6.66, 7.77, 8.88]
        settings.list.wrappedValue = newValue
        #expect(settings.store.fetch("list") == newValue)
    }

    @Test
    func test_Integration_Set() {
        let defaultValue = settings.set.wrappedValue
        #expect(defaultValue == [1, 2, 3])

        let newValue = Set([6, 77, 888])
        settings.set.wrappedValue = newValue
        #expect(settings.store.fetch("set") == newValue)
    }

    @Test
    func test_Integration_Dictionary() {
        let defaultValue = settings.pairs.wrappedValue
        #expect(defaultValue == [:])

        let newValue = ["six": 6, "seventy-seven": 77, "eight-hundred eighty eight": 888]
        settings.pairs.wrappedValue = newValue
        #expect(settings.store.fetch("pairs") == newValue)
    }

    @Test
    func test_Integration_RawRepresentable() {
        let defaultValue = settings.fruit.wrappedValue
        #expect(defaultValue == .apple)

        let newValue = TestFruit.orange
        settings.fruit.wrappedValue = newValue
        #expect(settings.store.fetch("fruit") == newValue)
    }

    @Test
    func test_Integration_Custom_RawRepresentable() {
        let defaultValue = settings.customRawRepresented.wrappedValue
        #expect(defaultValue.rawValue.isEmpty)

        var newValue = TestFruit.apple
        settings.customRawRepresented.wrappedValue[.key1] = newValue
        #expect(settings.customRawRepresented.wrappedValue[.key1] == newValue)

        newValue = TestFruit.orange
        settings.customRawRepresented.wrappedValue[.key2] = newValue
        #expect(settings.customRawRepresented.wrappedValue[.key2] == newValue)

        let expectedValue = ["key1": TestFruit.apple.rawValue, "key2": TestFruit.orange.rawValue]
        #expect(settings.store.fetch("customRawRepresented") == expectedValue)
    }

    @Test
    func test_Integration_Codable() {
        let defaultValue = settings.user.wrappedValue
        #expect(defaultValue == nil)

        let newValue = User(id: UUID(), name: "John Doe", highScore: 9_999, lastLogin: Date())
        settings.user.wrappedValue = newValue
        #expect(settings.user.wrappedValue == newValue)
    }
}
