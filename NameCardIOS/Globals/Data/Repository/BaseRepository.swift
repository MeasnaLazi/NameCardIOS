//
//  BaseRepository.swift
//  NameCardIOS
//
//  Created by Measna on 24/11/23.
//

import Foundation
import Combine

private let _apiClient = APIClient()
private let _mockApiClient = MockAPIClient()

protocol BaseRepository {
    var type: RepositoryType { set get }
}

enum RepositoryType {
    case api
    case mock
}

extension BaseRepository where Self : RequestExecutor {
    func execute<T>(_ request: Requestable) -> AnyPublisher<T, Error> where T : Responable {
        switch self.type {
        case .api:
            return _apiClient.execute(request)
        case .mock:
            return _mockApiClient.execute(request)
        }
    }
}
