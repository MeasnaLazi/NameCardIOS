//
//  AuthApi.swift
//  NameCardIOS
//
//  Created by Measna on 24/11/23.
//

import Foundation

enum AuthApi : Requestable {
    var requestURL: URL {
        return URL(string: "\(Const().BASE_URL)/accounts")!
    }
    
    var path: String? {
        switch self {
        case .login:
            return "/login"
        case .loginWithRefreshToken:
            return "/login-refresh-token"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .login:
            return .put
        case .loginWithRefreshToken:
            return .put
        }
    }
    
    var header: [String : String] {
        return ["Content-Type": "application/json"]
    }
    
    var paramater: Paramater? {
        switch self {
        case .login(let data):
            return .body(data)
        case .loginWithRefreshToken(let data):
            return .body(data)
        }
    }
    
    var timeout: TimeInterval? {
        return nil
    }
    
    case login(data: Data)
    case loginWithRefreshToken(data: Data)
    
}
