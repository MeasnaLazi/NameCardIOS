//
//  HomeViewModel.swift
//  NameCardIOS
//
//  Created by Measna on 28/11/23.
//

import Foundation

class HomeViewModel : BaseViewModel, ObservableObject {
    
    private let _nameCardRepository: NameCardRepository
    
    @Published private(set) var state: ViewState = .initial
    @Published private(set) var cards: [Card] = []
    @Published private(set) var searchCards: [Card] = []
    
    override init() {
        self._nameCardRepository = NameCardRepositoryImp(requestExecute: APIClient())
    }
    
    init(requestExecutor: RequestExecutor) {
        self._nameCardRepository = NameCardRepositoryImp(requestExecute: requestExecutor)
    }
    
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
