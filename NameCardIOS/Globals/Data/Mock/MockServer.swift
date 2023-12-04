//
//  MockServer.swift
//  NameCardIOS
//
//  Created by Measna on 3/12/23.
//

import Foundation
import Combine

public protocol MockServer {
    var jsonFileName: String? { get }
    func processLogicMockServer<T>(_ request: Requestable) -> AnyPublisher<T, Error> where T : Responable
}

extension MockServer {
    func readJSONMockData(fileName: String) -> AnyPublisher<Data, Error> {
        return Bundle.main.url(forResource: fileName, withExtension: "json")
            .publisher
            .tryMap{ string in
                
                guard let data = try? Data(contentsOf: string) else {
                    fatalError("Failed to load \(fileName) from bundle.")
                }
                return data
            }
            .mapError { error in
                print("APIClientMock error : \(error)")
                return error
            }
            .eraseToAnyPublisher()
    }
}
