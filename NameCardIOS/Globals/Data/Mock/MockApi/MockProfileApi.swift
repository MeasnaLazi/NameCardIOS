//
//  MockProfileApi.swift
//  NameCardIOS
//
//  Created by Measna on 29/1/24.
//

import Foundation
import Combine

extension ProfileApi {
    var jsonFileName: String?  {
        switch self {
        case .profiles:
            return "profiles"
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
