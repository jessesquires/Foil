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

@available(iOS 13.0, watchOS 6.0, tvOS 13.0, macOS 10.15, *)
final class ObservationTests: XCTestCase {

    let settings = TestSettings()

    var cancellable = Set<AnyCancellable>()

    var observer: NSKeyValueObservation?

    func test_Integration_Publisher() {
        let expectation = self.expectation(description: #function)
        var publishedValue: String?

        self.settings.$userId
            .sink { newValue in
                publishedValue = newValue
                if newValue == "test_publisher" {
                    expectation.fulfill()
                }
            }
            .store(in: &self.cancellable)

        self.settings.userId = "test_publisher"
        self.wait(for: [expectation], timeout: 5)

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
        self.wait(for: [expectation], timeout: 5)

        XCTAssertEqual(self.settings.userId, changedValue)
    }
}
