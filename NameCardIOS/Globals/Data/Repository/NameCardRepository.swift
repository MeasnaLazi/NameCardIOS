//
//  NameCardRepository.swift
//  NameCardIOS
//
//  Created by Measna on 28/11/23.
//

import Foundation
import Combine

protocol NameCardRepository {
    func getAll(token: String) -> AnyPublisher<Base<[Card]>, Error>
}

struct NameCardRepositoryImp : NameCardRepository, BaseRepository {
    func getAll(token: String) -> AnyPublisher<Base<[Card]>, Error> {
        execute(NameCardApi.all(token: token))
    }
}

extension NameCardRepositoryImp : RequestExecutor {}
