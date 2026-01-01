//
//  DataCoderProtocol.swift
//  NetworkingLayer
//
//  Created by Moyses Azevedo on 07/12/25.
//


import Foundation

public protocol DataCoderProtocol {
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
    func encode<T: Encodable>(_ value: T) throws -> Data
}
