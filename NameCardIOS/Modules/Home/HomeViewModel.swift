//
//  HomeViewModel.swift
//  NameCardIOS
//
//  Created by Measna on 28/11/23.
//

import Foundation
import Combine


class HomeViewModel : BaseViewModel, ObservableObject {
    
    private let _nameCardRepository: NameCardRepository
    
    @Published private(set) var state: ViewState = .initial
    @Published private(set) var cards: [Card] = []
    @Published private(set) var firstLoadCards: [Card] = []
    @Published private(set) var totalPage: Int = 0
    @Published private(set) var count: Int = 0
    
    override init() {
        self._nameCardRepository = NameCardRepositoryImp(requestExecute: APIClient())
    }
    
    init(requestExecutor: RequestExecutor) {
        self._nameCardRepository = NameCardRepositoryImp(requestExecute: requestExecutor)
    }
    
    func onViewAppear() {
        _getAllNameCard(search: "", page: 1)
    }
    
    func onSearch(search: String, page: Int) {
        _getAllNameCard(search: search, page: page)
    }
    
    func onSearchClose() {
        self.cards = self.firstLoadCards
    }
    
    private func _getAllNameCard(search: String, page: Int) {
        
        if search.isEmpty && page == 1 && !self.firstLoadCards.isEmpty {
            self.cards = self.firstLoadCards
            return
        }
        
        state = .loading
        
        _nameCardRepository.getNameCards(search: search, page: page)
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                switch (completion) {
                case .finished:
                    print("getAllNameCard fetcted!")
                case .failure(let err):
                    self?.state = .fail
                    print("getAllNameCard: \(err)")
            
            }
        } receiveValue: {[weak self] response in
            self?.cards = response.data ?? []
            self?.totalPage = response.totalPage
            self?.count = response.count
            self?.state = .fetched
            
            if self?.firstLoadCards.isEmpty ?? true {
                self?.firstLoadCards = self!.cards
            }
        }
        .store(in: &disposable)
    }
}
