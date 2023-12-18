//
//  ViewModelFacetory.swift
//  NameCardIOS
//
//  Created by Measna on 17/12/23.
//

import Foundation

class VMFactory {
    
    static let shared = VMFactory()
    
    var isUITesting = ProcessInfo.processInfo.arguments.contains("-isUITesting")
    var loginViewModel: LoginViewModel {
        isUITesting ? LoginViewModel(requestExecute: MockAPIClient()) : LoginViewModel()
    }
    var homeViewModel: HomeViewModel {
        isUITesting ? HomeViewModel(requestExecutor: MockAPIClient()) : HomeViewModel()
    }
    
    private init() {}
}
