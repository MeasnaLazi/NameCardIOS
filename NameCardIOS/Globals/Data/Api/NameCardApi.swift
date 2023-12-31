//
//  NameCardApi.swift
//  NameCardIOS
//
//  Created by Measna on 28/11/23.
//

import Foundation

enum NameCardApi : Requestable {
    var requestURL: URL {
        return URL(string: "\(Const().BASE_URL)/name-cards")!
    }
    
    var path: String? {
        return nil
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .name_cards:
            return .get
        }
    }
    
    var header: [String : String] {
        let token: String? = UserDefaults.standard.value(forKey: "token") as? String
        var headers = ["Content-Type": "application/json"]
        
        if let token = token {
            headers["Authorization"] = "Bearer \(token)"
        }
        
        return headers
    }
    
    var paramater: Paramater? {
        switch self {
        case.name_cards(let search, let page):
            return .query(["search" : search, "page": String(page)])
        }
    }
    
    var timeout: TimeInterval? {
        return nil
    }
        
    case name_cards(search: String, page: Int)
    
}
