//
//  BaseRepository.swift
//  NameCardIOS
//
//  Created by Measna on 24/11/23.
//

import Foundation
import Combine

private let apiClient = APIClient()

protocol BaseRepository {}

extension BaseRepository where Self : RequestExecutor {
    func execute<T>(_ request: Requestable) -> AnyPublisher<T, Error> where T : Responable {
        return apiClient.execute(request)
    }
}
