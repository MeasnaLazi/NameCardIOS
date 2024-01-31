//
//  AuthRepository.swift
//  NameCardIOS
//
//  Created by Measna on 24/11/23.
//

import Foundation
import Combine

protocol AuthRepository {
    func onLogin(data: Data) -> AnyPublisher<Base<Login>, Error>
    func onLoginRefreshToken(data: Data) -> AnyPublisher<Base<Login>, Error>
}

struct AuthRepositoryImp : AuthRepository, BaseRepository {
    
    var requestExecutor: RequestExecutor
    
    init(requestExecute: RequestExecutor) {
        self.requestExecutor = requestExecute
    }
    
    func onLogin(data: Data) -> AnyPublisher<Base<Login>, Error> {
        execute(AuthApi.login(data: data))
    }
    
    func onLoginRefreshToken(data: Data) -> AnyPublisher<Base<Login>, Error> {
        execute(AuthApi.loginWithRefreshToken(data: data))
    }
}
