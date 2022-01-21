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
import XCTest

let timeout = TimeInterval(5)

@available(iOS 13.0, watchOS 6.0, tvOS 13.0, macOS 10.15, *)
final class ObservationTests: XCTestCase {

    let settings = TestSettings()

    var cancellable = Set<AnyCancellable>()

    var observer: NSKeyValueObservation?

    func test_Integration_ProjectedValue() {
        let expectation = self.expectation(description: #function)
        let expectedValue = 1_000.0
        var publishedValue: Double?

        self.settings.$average
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

        self.settings.average = expectedValue
        self.wait(for: [expectation], timeout: timeout)

        XCTAssertEqual(self.settings.average, publishedValue)
    }

    func test_Integration_Publisher() {
        let expectation = self.expectation(description: #function)
        var publishedValue: String?

        self.settings
            .publisher(for: \.userId, options: [.new])
            .sink { newValue in
                publishedValue = newValue
                expectation.fulfill()
            }
            .store(in: &self.cancellable)

        self.settings.userId = "test_publisher"
        self.wait(for: [expectation], timeout: timeout)

        XCTAssertEqual(self.settings.userId, publishedValue)
    }

    func test_Integration_KVO() {
        let expectation = self.expectation(description: #function)
        var changedValue: String?

        self.observer = settings.observe(\.userId, options: [.new, .old]) { _, change in
            guard let newValue = change.newValue else {
                return
            }
            changedValue = newValue
            expectation.fulfill()
        }

        self.settings.userId = "test_kvo"
        self.wait(for: [expectation], timeout: timeout)

        XCTAssertEqual(self.settings.userId, changedValue)
    }
}
