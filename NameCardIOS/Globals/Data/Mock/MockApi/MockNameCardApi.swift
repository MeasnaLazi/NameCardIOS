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
        case .name_cards:
            return "name_cards"
        }
    }
    
    func processLogicMockServer<T>(_ request: Requestable) -> AnyPublisher<T, Error> where T : Responable {
        guard var jsonFileName = request.jsonFileName else {
            return Fail(error: NSError(domain: "", code: 0, userInfo: [:]))
                        .eraseToAnyPublisher()
        }
        
        var keyword = ""
        
        switch self {
        case.name_cards(let search, _):
            keyword = search
        }
        
        if !keyword.isEmpty {
            jsonFileName = "name_cards_search"
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
