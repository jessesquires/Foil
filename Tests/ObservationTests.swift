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
import Combine
import Foundation
import Testing

@Suite("Observation tests")
struct ObservationTests {

    let settings = TestSettings(suiteName: UUID().uuidString)

    @Test
    func test_Integration_ProjectedValue() async {
        let expectedInitialValue = 42.0
        let expectedValue = 1_000.0

        let task = Task {
            await settings.average
                .projectedValue
                ._values
                .prefix(2)
                .asyncMap { $0 }
        }

        settings.average.wrappedValue = expectedValue

        let emittedValues = await task.value
        #expect(emittedValues == [expectedInitialValue, expectedValue])
    }

    @Test
    func test_Integration_ProjectedValue_ExternalChange() async {
        let expectedInitialValue = 42.0
        let expectedValue = 1_000.0

        let task = Task {
            await settings.average
                .projectedValue
                ._values
                .prefix(2)
                .asyncMap { $0 }
        }

        settings.store.set(expectedValue, forKey: "average")
        let emittedValues = await task.value
        #expect(emittedValues == [expectedInitialValue, expectedValue])
    }

    @Test
    func test_Integration_Publisher() async {
        let publishedValue = "test_publisher"

        let task = Task {
            await settings.publisher(for: \.userId)
                ._values
                .prefix(1)
                .asyncMap { $0 }
        }

        settings.userId = publishedValue
        let emittedValues = await task.value

        #expect(emittedValues == [publishedValue])
    }

    @Test
    func test_Integration_KVO() async {
        let publishedValue = "test_kvo"
        var observation: NSKeyValueObservation?

        let stream = AsyncStream(String?.self) { continuation in
            observation = settings.observe(\.userId, options: [.new, .old]) { _, change in
                guard let newValue = change.newValue else {
                    continuation.finish()
                    return
                }
                continuation.yield(newValue)
                continuation.finish()
            }
        }

        settings.userId = publishedValue
        let emittedValues = await stream.asyncMap { $0 }.first!

        #expect(observation != nil)
        #expect(emittedValues == publishedValue)
    }
}
