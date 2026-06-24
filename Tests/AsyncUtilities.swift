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
//  Copyright © 2025-present Jesse Squires
//

import Combine
import Foundation

/// Extends AsyncSequence with a method to asynchronously map elements to a new array.
/// This allows transformation of AsyncSequence elements with async operations.
extension AsyncSequence where Self.Element: Sendable {
    /// Asynchronously transforms each element of the sequence and collects results into an array.
    ///
    /// - Parameter transform: An async closure that transforms each element to type T.
    /// - Returns: An array containing the transformed elements.
    /// - Throws: Rethrows any errors thrown by the transform function or by the sequence iteration.
    func asyncMap<T: Sendable>(
        _ transform: (Element) async throws -> T
    ) async rethrows -> [T] {
        var values = [T]()

        for try await element in self {
            try await values.append(transform(element))
        }

        return values
    }
}

/// An AsyncSequence adapter for Combine Publishers.
/// Bridges between Combine's publisher pattern and Swift concurrency by wrapping
/// a publisher in an AsyncSequence interface.
struct AsyncPublisher<P> : AsyncSequence where P: Publisher, P.Failure == Never, P.Output: Sendable {
    typealias Element = P.Output
    typealias AsyncIterator = AsyncStream<P.Output>.AsyncIterator

    var upstream : AnyPublisher<P.Output, Never>
    
    /// Creates a new AsyncPublisher that wraps the provided publisher.
    ///
    /// - Parameter upstream: The publisher to adapt to AsyncSequence.
    init(_ upstream: AnyPublisher<P.Output, Never>) {
        self.upstream = upstream
    }

    /// Creates an AsyncIterator that produces elements from the publisher.
    /// Implements backpressure by requesting one value at a time.
    ///
    /// - Returns: An AsyncIterator that yields elements from the publisher.
    func makeAsyncIterator() -> AsyncStream<Element>.AsyncIterator {
        var subscription : Subscription?

        let stream = AsyncStream<Element> { continuation in
            let mySubscriber = AnySubscriber<Element, Never>(
                receiveSubscription: { s in subscription = s; s.request(.max(1)) },
                receiveValue: { continuation.yield($0); return .max(1) },
                receiveCompletion:  { _ in continuation.finish(); subscription?.cancel() })
            
            self.upstream.receive(subscriber: mySubscriber)
        }
        
        return stream.makeAsyncIterator()
    }
}

/// Extends AnyPublisher with a property to access its values as an AsyncSequence.
extension AnyPublisher where Failure == Never, Output: Sendable {
    /// Provides access to publisher values as an AsyncSequence.
    ///
    /// - Note: This is a pre-iOS 15 alternative to the native `.values` property.
    /// - Returns: An AsyncSequence that produces the publisher's values.
    // TODO: Replace usage with `.values` once >= iOS 15 minimum target is adopted
    var _values : AsyncPublisher<Self> {
        AsyncPublisher<Self>(self)
    }
}

/// An AsyncSequence adapter for NSObject.KeyValueObservingPublisher.
/// Bridges between KVO publishers and Swift concurrency by wrapping
/// a KVO publisher in an AsyncSequence interface.
struct AsyncKVOPublisher<Object: NSObject, Value>: AsyncSequence where Value: Sendable {
    typealias Element = Value
    typealias AsyncIterator = AsyncStream<Value>.AsyncIterator

    var upstream: NSObject.KeyValueObservingPublisher<Object, Value>
    
    /// Creates a new AsyncKVOPublisher that wraps the provided KVO publisher.
    ///
    /// - Parameter upstream: The KVO publisher to adapt to AsyncSequence.
    init(upstream: NSObject.KeyValueObservingPublisher<Object, Value>) {
        self.upstream = upstream
    }

    /// Creates an AsyncIterator that produces elements from the KVO publisher.
    ///
    /// - Returns: An AsyncIterator that yields elements from the KVO publisher.
    func makeAsyncIterator() -> AsyncStream<Element>.AsyncIterator {
        var cancellable: AnyCancellable?

        let stream = AsyncStream<Element> { continuation in
            cancellable = self.upstream
                .sink(
                    receiveCompletion: { _ in
                        continuation.finish()
                        cancellable?.cancel()
                    },
                    receiveValue: { value in
                        continuation.yield(value)
                    }
                )
        }
        
        return stream.makeAsyncIterator()
    }
}

/// Extends NSObject.KeyValueObservingPublisher with a property to access its values as an AsyncSequence.
extension NSObject.KeyValueObservingPublisher where Subject: NSObject, Value: Sendable {
    /// Provides access to KVO publisher values as an AsyncSequence.
    ///
    /// - Note: This is a pre-iOS 15 alternative to the native `.values` property.
    /// - Returns: An AsyncSequence that produces the KVO publisher's values.
    // TODO: Replace usage with `.values` once >= iOS 15 minimum target is adopted
    var _values: AsyncKVOPublisher<Subject, Value> {
        AsyncKVOPublisher(upstream: self)
    }
}
