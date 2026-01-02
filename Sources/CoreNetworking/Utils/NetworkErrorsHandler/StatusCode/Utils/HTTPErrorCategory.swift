//
//  HTTPErrorCategory.swift
//  NetworkingLayer
//
//  Created by Moyses Azevedo on 07/12/25.
//


import Foundation 

public enum HTTPErrorCategoryErrors: Error {
    case informational  // 100–199
    case unauthorized
    case forbidden
    case redirection    // 300–399
    case clientError    // 400–499
    case serverError    // 500–599
    case unknown
}
