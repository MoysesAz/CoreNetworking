//
//  GetHttpProtocol.swift
//  NetworkingLayer
//
//  Created by Moyses Azevedo on 06/12/25.
//

import Foundation

public protocol GetHttpProtocol {
    func handle(endpoint: String,
                headers: [String: String],
                parameters: [String: Any]?) async throws -> HTTPResponseModel
}
