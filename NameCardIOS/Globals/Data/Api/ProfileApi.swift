//
//  ProfileApi.swift
//  NameCardIOS
//
//  Created by Measna on 29/1/24.
//

import Foundation

enum ProfileApi : Requestable {
    var requestURL: URL {
        return URL(string: "\(Const().BASE_URL)/profiles")!
    }
    
    var path: String? {
        return nil
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .profiles:
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
        return nil
    }
    
    var timeout: TimeInterval? {
        return nil
    }
        
    case profiles
}

