//
//  FailableDecodable.swift
//  EldenBook
//
//  Created by Alvin Matthew Pratama on 22/03/25.
//


import Foundation

/**
 Property Wrapper to reduce boiler plate code to decode `Optional<URL>`

 ## Example
 ```
 struct Data: Decodable {
    var logo: URL? -> fail, then throw error
 }
 ```
 when logo json string is empty, it will fail to decode, because it's translate as non-valid string.
 using this property wrapper, we can avoid that.

 outside of that case, this can be useful for other failable nil decode value.

 ## Solution
 ```
 struct Data: Decodable {
    @FailableDecodable
    var logo: URL? -> if fail, then nil
 }
 ```

 This also can be used for case where child decoder have failable condition and it will be optional on parent

 ```
 struct Child: Decodable {
    let name: String

    init(from decoder: Decoder) throws {
        let container = try decoder...
        let name = try container.decode...

        if name.isEmpty {
            throw Error...
        } else {
            self.name = name
        }
    }
 }

 struct Parent: Decodable {
    @FailableDecodable
    var child: Child?
 }
 ```

 with this, you can automatically set child as optional if decode is failed.
 */
@propertyWrapper
public struct FailableDecodable<Value> {
    public var wrappedValue: Value?

    public init(wrappedValue: Value?) {
        self.wrappedValue = wrappedValue
    }
}

extension FailableDecodable: Decodable where Value: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        wrappedValue = try? container.decode(Value.self)
    }
}

extension FailableDecodable: Equatable where Value: Equatable {}
extension FailableDecodable: Hashable where Value: Hashable {}

/**
 This will overload synthesized implementation for type `FailableDecodable<T>` and will handle no coding key like optional type
 */
extension KeyedDecodingContainer {
    public func decode<T>(
        _ type: FailableDecodable<T>.Type,
        forKey key: Self.Key
    ) throws -> FailableDecodable<T> where T: Decodable {
        return try decodeIfPresent(type, forKey: key) ?? FailableDecodable<T>(wrappedValue: nil)
    }
}
