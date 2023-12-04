//
//  MockNameCardApi.swift
//  NameCardIOS
//
//  Created by Measna on 3/12/23.
//

import Foundation
import Combine

extension NameCardApi {
    
    var jsonFileName: String?  {
        switch self {
        case .all:
            return "login"
        }
    }
    
    func processLogicMockServer<T>(_ request: Requestable) -> AnyPublisher<T, Error> where T : Responable {
        guard let jsonFileName = request.jsonFileName else {
            return Fail(error: NSError(domain: "", code: 0, userInfo: [:]))
                        .eraseToAnyPublisher()
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
