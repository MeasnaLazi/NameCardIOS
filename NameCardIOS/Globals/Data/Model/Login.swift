//
//  Login.swift
//  NameCardIOS
//
//  Created by Measna on 24/11/23.
//

import Foundation

struct Login {
    let token: String
    let refreshToken: String
    
    enum CodingKeys : String, CodingKey {
        case token = "token"
        case refreshToken = "refresh_token"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        token = try container.decode(String.self, forKey: .token)
        refreshToken = try container.decode(String.self, forKey: .refreshToken)
    }
}

extension Login : Decodable, Responable {}
