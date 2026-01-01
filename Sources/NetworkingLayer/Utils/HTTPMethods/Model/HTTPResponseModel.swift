//
//  HTTPResponse.swift
//  NetworkingLayer
//
//  Created by Moyses Azevedo on 06/12/25.
//

import Foundation

public struct HTTPResponseModel {
    public let data: Data
    public let headers: [AnyHashable: Any]
    public let statusCode: Int
}
