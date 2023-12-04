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
}

struct AuthRepositoryImp : AuthRepository, BaseRepository {
    
    var type: RepositoryType = .api
    
    func onLogin(data: Data) -> AnyPublisher<Base<Login>, Error> {
        execute(AuthApi.login(data: data))
    }
}

extension AuthRepositoryImp : RequestExecutor {}
