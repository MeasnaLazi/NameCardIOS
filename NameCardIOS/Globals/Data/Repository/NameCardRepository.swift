//
//  NameCardRepository.swift
//  NameCardIOS
//
//  Created by Measna on 28/11/23.
//

import Foundation
import Combine

protocol NameCardRepository {
    func getNameCards(search: String, page: Int) -> AnyPublisher<BasePagination<[Card]>, Error>
}

struct NameCardRepositoryImp : NameCardRepository, BaseRepository {
    
    var requestExecutor: RequestExecutor
    
    init(requestExecute: RequestExecutor) {
        self.requestExecutor = requestExecute
    }
    
    func getNameCards(search: String, page: Int) -> AnyPublisher<BasePagination<[Card]>, Error> {
        execute(NameCardApi.name_cards(search: search, page: page))
    }
}
