//
//  AuthApi.swift
//  NameCardIOS
//
//  Created by Measna on 24/11/23.
//

import Foundation

enum AuthApi : Requestable {
    var requestURL: URL {
        return URL(string: "\(Const().BASE_URL)/account")!
    }
    
    var path: String? {
        switch self {
        case .login:
            return "/login"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .login:
            return .put
        }
    }
    
    var header: [String : String] {
        return ["Content-Type": "application/json"]
    }
    
    var paramater: Paramater? {
        switch self {
        case.login(let data):
            return .body(data)
        }
    }
    
    var timeout: TimeInterval? {
        return nil
    }
    
    case login(data: Data)
    
}
