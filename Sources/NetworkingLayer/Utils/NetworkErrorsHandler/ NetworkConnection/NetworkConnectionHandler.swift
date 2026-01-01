//
//  File.swift
//  NetworkingLayer
//
//  Created by Moyses Azevedo on 07/12/25.
//

import Foundation


public final class NetworkConnectionHandler {
    public init() {}
    
    public func handle(urlError: URLError) -> NetworkConnectionErrorCategory {
        return statusCategory(urlError)
    }

    private func statusCategory(_ urlError: URLError) -> NetworkConnectionErrorCategory {
        switch urlError.code {
        case .notConnectedToInternet:
            return .noInternet
        case .timedOut:
            return .timedOut
        case .cannotFindHost:
            return .dnsError
        case .cannotConnectToHost:
            return .cannotConnectToHost
        case .networkConnectionLost:
            return .connectionLost
        case .secureConnectionFailed,
             .serverCertificateUntrusted,
             .serverCertificateNotYetValid,
             .serverCertificateHasBadDate,
             .serverCertificateHasUnknownRoot:
            return .sslError
        case .badServerResponse:
            return .badServerResponse
        case .cancelled:
            return .cancelled
        default:
            return .unknown
        }
    }
}
