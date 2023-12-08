//
//  HomeViewModel.swift
//  NameCardIOS
//
//  Created by Measna on 28/11/23.
//

import Foundation

class HomeViewModel : BaseViewModel, ObservableObject {
    
    private let _nameCardRepository = NameCardRepositoryImp(type: .mock)
    
    @Published private(set) var state: ViewState = .initial
    @Published private(set) var cards: [Card] = []
    @Published private(set) var searchCards: [Card] = []
    
    func onViewAppear() {
        getAllNameCard()
    }
    
    private func getAllNameCard() {
        state = .loading
        _nameCardRepository.getNameCards()
//            .debounce(for: 2, scheduler: RunLoop.main) // for search
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
            self?.state = .fetched
        }
        .store(in: &disposable)

    }
    
}
