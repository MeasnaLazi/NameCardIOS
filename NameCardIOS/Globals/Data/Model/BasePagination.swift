//
//  BasePagination.swift
//  NameCardIOS
//
//  Created by Measna on 8/12/23.
//

import Foundation

struct BasePagination<T : Decodable> : Decodable, Responable {
    let error: Int
    let message: String
    let data: T?
    let count: Int
    let totalPage: Int
    
    enum CodingKeys : String, CodingKey {
        case error = "error"
        case message = "message"
        case data = "data"
        case count = "count"
        case totalPage = "total_page"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        error = try container.decode(Int.self, forKey: .error)
        message = try container.decode(String.self, forKey: .message)
        data = try container.decodeIfPresent(T.self, forKey: .data)
        count = try container.decode(Int.self, forKey: .count)
        totalPage = try container.decode(Int.self, forKey: .totalPage)
        
    }
}
