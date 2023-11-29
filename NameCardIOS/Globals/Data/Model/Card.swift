//
//  Card.swift
//  NameCardIOS
//
//  Created by Measna on 26/11/23.
//

import Foundation

struct Card : Identifiable {
    var id: String
    var firstname: String
    var lastname: String?
    var position: String
    var phone: String
    var email: String
    var address: String?
    var website: String?
    var image: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case firstname = "firstname"
        case lastname = "lastname"
        case position = "position"
        case phone = "phone"
        case email = "email"
        case address = "address"
        case website  = "website"
        case image = "image"
    }
 
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        firstname = try container.decode(String.self, forKey: .firstname)
        lastname = try container.decodeIfPresent(String.self, forKey: .lastname)
        position = try container.decode(String.self, forKey: .position)
        phone = try container.decode(String.self, forKey: .phone)
        email = try container.decode(String.self, forKey: .email)
        address = try container.decodeIfPresent(String.self, forKey: .address)
        website = try container.decodeIfPresent(String.self, forKey: .website)
        image = try container.decode(String.self, forKey: .image)
    }
}

extension Card: Decodable, Responable {}
