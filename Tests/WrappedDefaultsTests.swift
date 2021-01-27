//
//  Created by Jesse Squires
//  https://www.jessesquires.com
//
//  Documentation
//  https://jessesquires.github.io/WrappedDefaults
//
//  GitHub
//  https://github.com/jessesquires/WrappedDefaults
//
//  Copyright © 2021-present Jesse Squires
//

import WrappedDefaults
import XCTest

final class UserDefaultWrapperTests: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
    }

    func test_WrappedValue_String() {
        let testDefaults = UserDefaults(suiteName: UUID().uuidString)!
        var model = WrappedDefault(keyName: "key", defaultValue: "default-value", userDefaults: testDefaults)

        XCTAssertEqual(testDefaults.fetch("key"), "default-value")
        XCTAssertEqual(model.wrappedValue, "default-value")

        model.wrappedValue = "new-value"
        XCTAssertEqual(testDefaults.fetch("key"), "new-value")
        XCTAssertEqual(model.wrappedValue, "new-value")
    }

    func test_WrappedValue_Int() {
        let testDefaults = UserDefaults(suiteName: UUID().uuidString)!
        var model = WrappedDefault(keyName: "key", defaultValue: 42, userDefaults: testDefaults)

        XCTAssertEqual(testDefaults.fetch("key"), 42)
        XCTAssertEqual(model.wrappedValue, 42)

        model.wrappedValue = 666
        XCTAssertEqual(testDefaults.fetch("key"), 666)
        XCTAssertEqual(model.wrappedValue, 666)
    }
}
