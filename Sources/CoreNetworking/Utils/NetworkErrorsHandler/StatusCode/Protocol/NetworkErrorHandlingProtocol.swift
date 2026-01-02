//
//  NetworkErrorHandlingProtocol.swift
//  NetworkingLayer
//
//  Created by Moyses Azevedo on 07/12/25.
//


import Foundation

public protocol NetworkErrorHandlingProtocol {
    func handle(statusCode: Int) throws
}
