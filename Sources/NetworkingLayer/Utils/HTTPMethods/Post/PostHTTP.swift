//
//  PostHTTP.swift
//  NetworkingLayer
//
//  Created by Moyses Azevedo on 30/12/25.
//



import Foundation

public final class PostHTTP: PostHttpProtocol {

    private let session: URLSession

    public init(session: URLSession = .shared) {
        self.session = session
    }

    @available(macOS 12.0, *)
    public func handle(
        endpoint: String,
        headers: [String : String] = [:],
        body: Data?
    ) async throws -> HTTPResponseModel {

        guard let url = URL(string: endpoint) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = body

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
