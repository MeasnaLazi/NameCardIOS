//
//  HomeViewModel.swift
//  NameCardIOS
//
//  Created by Measna on 28/11/23.
//

import Foundation

class HomeViewModel : BaseViewModel, ObservableObject {
    
    private let _nameCardRepository = NameCardRepositoryImp()
    
    @Published private(set) var state: ViewState = .initial
    @Published private(set) var cards: [Card] = []
    
    func onViewAppear(token: String) {
        getAllNameCard(token: token)
    }
    
    private func getAllNameCard(token: String) {
        state = .loading
        _nameCardRepository.getAll(token: token)
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
