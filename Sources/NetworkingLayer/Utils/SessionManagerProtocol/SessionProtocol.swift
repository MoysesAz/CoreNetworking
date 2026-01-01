//
//  SessionProtocol.swift
//  Truman
//
//  Created by Moyses Azevedo on 29/12/25.
//


public protocol SessionManagerProtocol {
    var headers: [String: String] { get }
    func update(from responseHeaders: [AnyHashable: Any])
}
