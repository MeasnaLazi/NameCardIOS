//
//  Server.swift
//  NameCardIOS
//
//  Created by Measna on 2/12/23.
//

import Foundation
import Combine

import Foundation
import Combine

struct APIClientMock {
    
    func readJSONMockData(file: String) -> AnyPublisher<Data, Error> {
        return Bundle.main.url(forResource: file, withExtension: "json")
            .publisher
            .tryMap{ string in
                
                guard let data = try? Data(contentsOf: string) else {
                    fatalError("Failed to load \(file) from bundle.")
                }
                return data
            }
            .mapError { error in
                print("APIClientMock error : \(error)")
                return error
            }
            .eraseToAnyPublisher()
    }
    
    func execute<T>(_ request: Requestable) -> AnyPublisher<T, Error> where T : Responable {
        guard let mockDataFileName = request.mockDataFileName else {
            return Fail(error: NSError(domain: "", code: 0, userInfo: [:]))
                        .eraseToAnyPublisher()
        }
        
        return readJSONMockData(file: mockDataFileName)
            .tryMap {
                return try T.decode($0)
            }
            .mapError { error in
                return error
            }
            .eraseToAnyPublisher()
    }
}


