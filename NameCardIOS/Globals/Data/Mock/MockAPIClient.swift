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

struct MockAPIClient : RequestExecutor {
    func execute<T>(_ request: Requestable) -> AnyPublisher<T, Error> where T : Responable {        
        return request.processLogicMockServer(request)
    }
}


