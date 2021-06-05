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

#if canImport(Combine)
import Combine
#endif

@testable import Foil
import XCTest

@available(iOS 13.0, watchOS 6.0, tvOS 13.0, macOS 10.15, *)
final class ObservationTests: XCTestCase {

    let settings = TestSettings()
    var cancellable = Set<AnyCancellable>()

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
