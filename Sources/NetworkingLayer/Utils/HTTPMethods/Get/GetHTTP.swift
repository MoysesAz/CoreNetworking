//
//  GetHTTP.swift
//  NetworkingLayer
//
//  Created by Moyses Azevedo on 06/12/25.
//

import Foundation

public final class GetHTTP: GetHttpProtocol {
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    @available(macOS 12.0, *)
    public func handle(endpoint: String,
                       headers: [String: String] = [:],
                       parameters: [String: Any]? = nil) async throws -> HTTPResponseModel {
        
        guard var components = URLComponents(string: endpoint) else {
            throw URLError(.badURL)
        }

        if let params = parameters, !params.isEmpty {
            var items = components.queryItems ?? []
            
            for (key, value) in params {
                let stringValue = String(describing: value)
                items.append(URLQueryItem(name: key, value: stringValue))
            }

            components.queryItems = items
        }

        guard let url = components.url else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        headers.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }

        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        return HTTPResponseModel(
            data: data,
            headers: httpResponse.allHeaderFields,
            statusCode: httpResponse.statusCode
        )
    }
}
