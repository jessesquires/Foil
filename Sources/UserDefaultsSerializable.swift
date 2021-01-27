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

import Foundation

public protocol UserDefaultsSerializable {
    associatedtype StoredValue

    var storedValue: StoredValue { get }

    init(storedValue: StoredValue)
}

extension Array: UserDefaultsSerializable where Element: UserDefaultsSerializable {
    public var storedValue: [Element.StoredValue] {
        self.map { $0.storedValue }
    }

    public init(storedValue: [Element.StoredValue]) {
        self = storedValue.map { Element(storedValue: $0) }
    }
}

extension Dictionary: UserDefaultsSerializable where Key == String, Value: UserDefaultsSerializable {
    public var storedValue: [String: Value.StoredValue] {
        self.mapValues { $0.storedValue }
    }

    public init(storedValue: [String: Value.StoredValue]) {
        self = storedValue.mapValues { Value(storedValue: $0) }
    }
}

extension Data: UserDefaultsSerializable {
    public var storedValue: Self { self }

    public init(storedValue: Self) {
        self = storedValue
    }
}

extension Bool: UserDefaultsSerializable {
    public var storedValue: Self { self }

    public init(storedValue: Self) {
        self = storedValue
    }
}

extension Int: UserDefaultsSerializable {
    public var storedValue: Self { self }

    public init(storedValue: Self) {
        self = storedValue
    }
}

extension Float: UserDefaultsSerializable {
    public var storedValue: Self { self }

    public init(storedValue: Self) {
        self = storedValue
    }
}

extension Double: UserDefaultsSerializable {
    public var storedValue: Self { self }

    public init(storedValue: Self) {
        self = storedValue
    }
}

extension String: UserDefaultsSerializable {
    public var storedValue: Self { self }

    public init(storedValue: Self) {
        self = storedValue
    }
}

extension URL: UserDefaultsSerializable {
    public var storedValue: Self { self }

    public init(storedValue: Self) {
        self = storedValue
    }
}

extension UserDefaultsSerializable where Self: RawRepresentable {
    public var storedValue: RawValue { self.rawValue }

    public init(storedValue: RawValue) {
        self = Self(rawValue: storedValue)!
    }
}
