//
//  LoginViewModel.swift
//  NameCardIOS
//
//  Created by Measna on 24/11/23.
//

import Foundation
import Combine

class LoginViewModel : BaseViewModel, ObservableObject {
    let _repository: AuthRepository = AuthRepositoryImp()
    
    enum State {
        case initial
        case loading
        case fetched
        case fail
    }
    
    @Published private(set) var state: State = .initial
    
    func onLogin(data: Data) {
        print("onLogin here!")
        state = .loading
        
        _repository.onLogin(data: data)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("onLogin Finished")
                case .failure(let error):
                    print("error: \(error)")
                    self.state = .fail
                }
            } receiveValue: { response in
                print("response: \(response)")
                self.state = .fetched
            }
            .store(in: &disposable)
    }
    
}
