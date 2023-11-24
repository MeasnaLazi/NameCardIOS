//
//  BaseViewModel.swift
//  NameCardIOS
//
//  Created by Measna on 24/11/23.
//

import Foundation
import Combine

class BaseViewModel {
    var disposable = Set<AnyCancellable>()
    
    deinit {
        disposable.removeAll()
    }
}

