//
//  NetworkErrorHandler.swift
//  NetworkingLayer
//
//  Created by Moyses Azevedo on 07/12/25.
//


import Foundation

public final class NetworkErrorHandler: NetworkErrorHandlingProtocol {
    public init() {}
    
    public func handle(statusCode: Int) throws {
        guard let error: HTTPErrorCategoryErrors =  statusCategory(for: statusCode) else {
            return
        }
        throw error
    }

    private func statusCategory(for code: Int) -> HTTPErrorCategoryErrors? {
        switch code {
        case 100..<200: return .informational
        case 200..<300: return nil
        case 300..<400: return .redirection
        case 401: return .unauthorized
        case 403: return .forbidden
        case 400..<500: return .clientError
        case 500..<600: return .serverError
        default: return .unknown
        }
    }
}
