//
//  NetworkResponseModel.swift
//  Truman
//
//  Created by Moyses Azevedo on 06/12/25.
//

import Foundation

public struct NetworkResponseModel<T: Codable> {
    public let result: T
    public let error: HTTPErrorCategoryErrors
}
