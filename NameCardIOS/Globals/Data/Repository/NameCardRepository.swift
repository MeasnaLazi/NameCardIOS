//
//  NameCardRepository.swift
//  NameCardIOS
//
//  Created by Measna on 28/11/23.
//

import Foundation
import Combine

protocol NameCardRepository {
    func getAll() -> AnyPublisher<Base<[Card]>, Error>
}

struct NameCardRepositoryImp : NameCardRepository, BaseRepository {
    
    var type: RepositoryType = .api
    
    func getAll() -> AnyPublisher<Base<[Card]>, Error> {
        execute(NameCardApi.all)
    }
}

extension NameCardRepositoryImp : RequestExecutor {}
