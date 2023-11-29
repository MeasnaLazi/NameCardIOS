//
//  LoginViewModel.swift
//  NameCardIOS
//
//  Created by Measna on 24/11/23.
//

import Foundation
import Combine

class LoginViewModel : BaseViewModel, ObservableObject {
    
    private let _repository: AuthRepository = AuthRepositoryImp()
    
    @Published private(set) var state: ViewState = .initial
    @Published var errorMessage: String = ""
    
    @Published private(set) var login: Login?
    
    private func onLogin(data: Data) {
        state = .loading
        
        _repository.onLogin(data: data)
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    print("onLogin Finished")
                case .failure(let error):
                    print("error: \(error)")
                    self?.errorMessage = "Invalid Username or Password!"
                    self?.state = .fail
                }
            } receiveValue: { [weak self] response in
                self?.errorMessage = ""
                self?.login = response.data
                self?.state = .fetched
            }
            .store(in: &disposable)
    }
    
    func onLoginClick(username: String, password: String) {
        let jsonData = ["username" : username, "password" : password].toJsonData()
        self.onLogin(data: jsonData)
    }
    
}
