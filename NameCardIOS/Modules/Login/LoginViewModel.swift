//
//  LoginViewModel.swift
//  NameCardIOS
//
//  Created by Measna on 24/11/23.
//

import Foundation
import Combine

class LoginViewModel : BaseViewModel, ObservableObject {
    
    private let _repository: AuthRepository
    
    @Published private(set) var state: ViewState = .initial
    @Published var errorMessage: String = ""
    @Published private(set) var login: Login?
    
    override init() {
        self._repository = AuthRepositoryImp(requestExecute: APIClient())
    }
    
    init(requestExecute: RequestExecutor) {
        self._repository = AuthRepositoryImp(requestExecute: requestExecute)
    }
    
    func onViewAppear(refreshToken: String) {
       _autoLogin(refreshToken)
    }
    
    func onLoginClick(username: String, password: String) {
        
        guard !username.isEmpty else {
            errorMessage = "Username required!"
            return
        }
        guard !password.isEmpty else {
            errorMessage = "Password required!"
            return
        }
        guard password.count > 5 else {
            errorMessage = "Invalid Username or Password!"
            return
        }
        
        let jsonData = ["username" : username, "password" : password].toJsonData()
        self._onLogin(data: jsonData)
    }
    
    private func _autoLogin(_ refreshToken: String) {
        if !refreshToken.isEmpty {
            let jsonData = ["refresh_token" : refreshToken].toJsonData()
            self._onLoginWithRefreshToken(data: jsonData)
        }
    }
    
    private func _onLogin(data: Data) {
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
    
    private func _onLoginWithRefreshToken(data: Data) {
        state = .loading
        
        _repository.onLoginRefreshToken(data: data)
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
}


