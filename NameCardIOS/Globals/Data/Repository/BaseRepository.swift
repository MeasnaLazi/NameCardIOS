//
//  BaseRepository.swift
//  NameCardIOS
//
//  Created by Measna on 24/11/23.
//

import Foundation
import Combine

protocol BaseRepository {
    var requestExecutor: RequestExecutor { get set }
    init(requestExecute: RequestExecutor)
}

extension BaseRepository {
    func execute<T>(_ request: Requestable) -> AnyPublisher<T, Error> where T : Responable {
        self.requestExecutor.execute(request)
    }
}
