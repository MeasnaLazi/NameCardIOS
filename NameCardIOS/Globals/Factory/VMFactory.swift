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
    var nameCardViewModel: NameCardViewModel {
        isUITesting ? NameCardViewModel(requestExecutor: MockAPIClient()) : NameCardViewModel()
    }
    var myQRCodeViewModel: MyQRCodeViewModel {
        isUITesting ? MyQRCodeViewModel(requestExecute: MockAPIClient()) : MyQRCodeViewModel()
    }
    
    private init() {
        print("isUITesting: \(isUITesting)")
    }
}
