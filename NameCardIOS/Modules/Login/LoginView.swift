//
//  LoginView.swift
//  NameCardIOS
//
//  Created by Measna on 24/11/23.
//

import Foundation
import SwiftUI

struct LoginView : View {
    
    @ObservedObject private var _viewModel = LoginViewModel()
    
    var body: some View {
        VStack {
            switch _viewModel.state {
            case .initial:
                Text("Init")
            case .loading:
                Text("Loading")
            case .fetched:
                Text("Fetch")
            case .fail:
                Text("Failed")
            }
            Text("hii").onAppear() {
                print("Call here!")
                let body = ["username" : "lazi", "password" : "12345678"]
                let jsonData = try? JSONSerialization.data(withJSONObject: body)
                _viewModel.onLogin(data: jsonData!)
            }
        }
    }
}
