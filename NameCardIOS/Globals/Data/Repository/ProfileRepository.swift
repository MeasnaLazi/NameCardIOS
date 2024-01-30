//
//  ProfileRepository.swift
//  NameCardIOS
//
//  Created by Measna on 29/1/24.
//

import Foundation
import Combine

protocol ProfileRepository {
    func getProfiles() -> AnyPublisher<Base<[Profile]>, Error>
}

struct ProfileRepositoryImp : ProfileRepository, BaseRepository {
    
    var requestExecutor: RequestExecutor
    
    init(requestExecute: RequestExecutor) {
        self.requestExecutor = requestExecute
    }
    
    func getProfiles() -> AnyPublisher<Base<[Profile]>, Error> {
        execute(ProfileApi.profiles)
    }
}
