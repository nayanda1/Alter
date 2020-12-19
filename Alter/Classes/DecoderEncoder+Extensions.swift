//
//  Decoder+Extensions.swift
//  Alter
//
//  Created by Nayanda Haberty on 24/11/20.
//

import Foundation

public extension KeyedDecodingContainer where Key == AlterCodingKey {
    /// Method to decode keyed value
    /// - Parameter key: enum with rawValue type of String
    /// - Throws: Error occurs when decode. If the error is from Alter, it will be `AlterError`
    /// - Returns: Decoded keyed value
    func decode<Result: Decodable, Key: RawRepresentable>(forKey key: Key) throws -> Result where Key.RawValue == String {
        try decode(forKey: key.rawValue)
    }
    
    /// Method to decode keyed value
    /// - Parameter key: key with type String
    /// - Throws: Error occurs when decode. If the error is from Alter, it will be `AlterError`
    /// - Returns: Decoded keyed value
    func decode<Result: Decodable>(forKey key: String) throws -> Result {
        guard let codingKey = allKeys.first(where: { $0.stringValue == key }) else {
            throw AlterError.whenDecode(
                type: Result.self,
                reason: "key \(key) did not exist in container"
            )
        }
        return try decode(Result.self, forKey: codingKey)
    }
}

public extension KeyedEncodingContainer where Key == AlterCodingKey {
    /// Method to encode keyed value
    /// - Parameters:
    ///   - value: keyed value to be encoded
    ///   - key: enum with rawValue type of String
    /// - Throws: Error occurs when encode.
    mutating func encode<Value: Encodable, Key: RawRepresentable>(value: Value, forKey key: Key) throws where Key.RawValue == String {
        try encode(value: value, forKey: key.rawValue)
    }
    
    /// Method to encode keyed value
    /// - Parameters:
    ///   - value: keyed value to be encoded
    ///   - key: key with type String
    /// - Throws: Error occurs when encode.
    mutating func encode<Value: Encodable>(value: Value, forKey key: String) throws {
        try encode(value, forKey: AlterCodingKey(stringValue: key))
    }
}
