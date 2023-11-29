//
//  NameCardApi.swift
//  NameCardIOS
//
//  Created by Measna on 28/11/23.
//

import Foundation

enum NameCardApi : Requestable {
    var requestURL: URL {
        return URL(string: "\(Const().BASE_URL)/name-card")!
    }
    
    var path: String? {
        return nil
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .all:
            return .get
        }
    }
    
    var header: [String : String] {
        var headers = ["Content-Type": "application/json"]
        var token: String = ""
        
        switch self {
        case.all(let receiveToken):
           token = receiveToken
        }
        
        if !token.isEmpty {
            headers["Authorization"] = "Bearer \(token)"
        }
        
        return headers
    }
    
    var paramater: Paramater? {
        return nil
    }
    
    var timeout: TimeInterval? {
        return nil
    }
    
    case all(token: String)
    
}
