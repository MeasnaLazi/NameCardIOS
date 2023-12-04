//
//  HomeViewModel.swift
//  NameCardIOS
//
//  Created by Measna on 28/11/23.
//

import Foundation

class HomeViewModel : BaseViewModel, ObservableObject {
    
    private let _nameCardRepository = NameCardRepositoryImp(type: .api)
    
    @Published private(set) var state: ViewState = .initial
    @Published private(set) var cards: [Card] = []
    
    func onViewAppear() {
        getAllNameCard()
    }
    
    private func getAllNameCard() {
        state = .loading
        _nameCardRepository.getAll()
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
        }
        .store(in: &disposable)

    }
    
}
