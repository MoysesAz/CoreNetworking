//
//  PostHttpProtocol.swift
//  NetworkingLayer
//
//  Created by Moyses Azevedo on 30/12/25.
//


import Foundation

public protocol PostHttpProtocol {
    @available(macOS 12.0, *)
    func handle(
        endpoint: String,
        headers: [String: String],
        body: Data?
    ) async throws -> HTTPResponseModel
}
