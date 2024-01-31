//
//  AuthApi.swift
//  NameCardIOS
//
//  Created by Measna on 3/12/23.
//

import Foundation
import Combine

extension AuthApi {
    
    var jsonFileName: String?  {
        switch self {
        case .login:
            return "login"
        case .loginWithRefreshToken:
            return "login"
        }
    }
    
    func processLogicMockServer<T>(_ request: Requestable) -> AnyPublisher<T, Error> where T : Responable {
        
        let failError: AnyPublisher<T, Error> = Fail(error: NSError(domain: "", code: 0, userInfo: [:])).eraseToAnyPublisher()
        
        guard let jsonFileName = request.jsonFileName else {
            return failError
        }
        
        switch self {
        case .login(let data):
            guard let json = data.toDictionary() else {
                return failError
            }
            guard let username = json["username"], let password = json["password"] else {
                return failError
            }
            
            if (username != "lazi" || password != "12345678") {
                return failError
            }
        case .loginWithRefreshToken(let data): break
        }
        
        return readJSONMockData(fileName: jsonFileName)
            .tryMap {
                return try T.decode($0)
            }
            .mapError { error in
                return error
            }
            .eraseToAnyPublisher()
    }
}
