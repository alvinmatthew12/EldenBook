//
//  JSONReader.swift
//  EldenBook
//
//  Created by Alvin Matthew Pratama on 22/03/25.
//

import Foundation

public struct JSONReader {
    public static func load<T: Decodable>(
        _ filename: String,
        as type: T.Type = T.self
    ) -> Result<T, NetworkError> {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            return .failure(.notFound)
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder.instance
            decoder.keyDecodingStrategy = .useDefaultKeys
            let decoded = try decoder.decode(T.self, from: data)
            return .success(decoded)
        } catch let error as DecodingError {
            return .failure(.decodeError)
        } catch {
            return .failure(.serverError)
        }
    }
}

