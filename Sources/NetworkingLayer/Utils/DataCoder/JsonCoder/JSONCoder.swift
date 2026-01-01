//
//  JSONCoder.swift
//  NetworkingLayer
//
//  Created by Moyses Azevedo on 07/12/25.
//

import Foundation

public final class JSONCoder: DataCoderProtocol {
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder

    public init(useSnakeCase: Bool = true) {
        self.decoder = JSONDecoder()
        self.encoder = JSONEncoder()

        if useSnakeCase {
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            encoder.keyEncodingStrategy = .convertToSnakeCase
        }
    }

    public func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        do {
            let resut = try decoder.decode(T.self, from: data)
            return resut
        } catch {
            throw JsonCoderCategory.decoderFailure
        }
    }

    public func encode<T: Encodable>(_ value: T) throws -> Data {
        do {
            let resut = try encoder.encode(value)
            return resut
        } catch {
            throw JsonCoderCategory.encoderFailure
        }
    }
}


