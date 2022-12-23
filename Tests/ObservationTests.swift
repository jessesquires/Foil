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

let timeout = TimeInterval(5)

final class ObservationTests: XCTestCase {

    var cancellable = Set<AnyCancellable>()

    var observer: NSKeyValueObservation?

    override func setUpWithError() throws {
        try super.setUpWithError()
        TestSettings.reset()
    }

    func test_Integration_ProjectedValue() {
        let settings = TestSettings()
        let expectation = self.expectation(description: #function)
        let expectedValue = 1_000.0
        var publishedValue: Double?

        settings.$average
            .sink { newValue in
                publishedValue = newValue

                // `receiveValue` in sink triggers twice:
                // 1. with the initial value 42
                // 2. when new value is set
                if newValue == expectedValue {
                    expectation.fulfill()
                }
            }
            .store(in: &self.cancellable)

        settings.average = expectedValue
        self.wait(for: [expectation], timeout: timeout)

        XCTAssertEqual(settings.average, publishedValue)
    }

    func test_Integration_ProjectedValue_ExternalChange() {
        let settings = TestSettings()
        let expectation = self.expectation(description: #function)
        let expectedValue = 1_000.0
        var publishedValue: Double?

        settings.$average
            .sink { newValue in
                publishedValue = newValue

                if newValue == expectedValue {
                    expectation.fulfill()
                }
            }
            .store(in: &self.cancellable)

        type(of: settings).store.set(expectedValue, forKey: "average")
        self.wait(for: [expectation], timeout: timeout)

        XCTAssertEqual(settings.average, publishedValue)
    }

    func test_Integration_Publisher() {
        let settings = TestSettings()
        let expectation = self.expectation(description: #function)
        var publishedValue: String?

        settings
            .publisher(for: \.userId, options: [.new])
            .sink { newValue in
                publishedValue = newValue
                expectation.fulfill()
            }
            .store(in: &self.cancellable)

        settings.userId = "test_publisher"
        self.wait(for: [expectation], timeout: timeout)

        XCTAssertEqual(settings.userId, publishedValue)
    }

    func test_Integration_KVO() {
        let settings = TestSettings()
        let expectation = self.expectation(description: #function)
        var changedValue: String?

        self.observer = settings.observe(\.userId, options: [.new, .old]) { _, change in
            guard let newValue = change.newValue else {
                return
            }
            changedValue = newValue
            expectation.fulfill()
        }

        settings.userId = "test_kvo"
        self.wait(for: [expectation], timeout: timeout)

        XCTAssertEqual(settings.userId, changedValue)
    }
}
