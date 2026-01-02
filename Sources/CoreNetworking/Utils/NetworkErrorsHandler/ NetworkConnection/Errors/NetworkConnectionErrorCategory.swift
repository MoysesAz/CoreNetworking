//
//  File.swift
//  NetworkingLayer
//
//  Created by Moyses Azevedo on 07/12/25.
//

import Foundation

public enum NetworkConnectionErrorCategory: Error {
    case noInternet
    case timedOut
    case dnsError
    case cannotConnect
    case connectionLost
    case sslError
    case cancelled
    case badURL
    case badServerResponse
    case unknown
    case cannotConnectToHost
}
