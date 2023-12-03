//
//  BaseRepositoryMock.swift
//  NameCardIOS
//
//  Created by Measna on 2/12/23.
//

import Foundation
import Combine

private let _apiClient = APIClientMock()

protocol BaseRepositoryMock {}

extension BaseRepositoryMock where Self : RequestExecutor {
    func execute<T>(_ request: Requestable) -> AnyPublisher<T, Error> where T : Responable {
        return _apiClient.execute(request)
    }
}
