//
//  Responable.swift
//  NameCardIOS
//
//  Created by Measna on 24/11/23.
//

import Foundation

public protocol Responable {
    static func decode(_ data: Data) throws -> Self
}

extension Responable where Self: Decodable {
    static func decode(_ data: Data) throws -> Self {
        return try _decoder.decode(Self.self, from: data)
    }
}

private let _decoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    return decoder
}()
