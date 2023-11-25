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
    
    @State private var username: String = ""
    @State private var password: String = ""
    
    private func onLoginClick() {
        let body = ["username" : "lazi", "password" : "12345678"]
        _viewModel.onLogin(data: body.toJsonData())
    }
    
    var body: some View {
        ZStack {
            switch _viewModel.state {
            case .initial:
                Text("")
            case .loading:
                Text("")
            case .fetched:
                Text("")
            case .fail:
                Text("")
            }
        
            VStack {
                usernameTextField
                passwordTextField
                    .padding(.top, 8)
                    .padding(.bottom, 8)
                loginButton
                Spacer()
            }
        }
        .safeAreaPadding()
    }
    
    private var usernameTextField: some View {
        VStack {
            HStack {
                Text("Username")
                    .font(.primary(.regular))
                Spacer()
            }
            
            TextField("Username", text: $username)
                .padding()
                .foregroundColor(Color.text)
                .background(RoundedRectangle(cornerRadius: 5.0).fill(Color.backgroundTextField))
                .font(.primary(.regular))
        }
    }
    
    private var passwordTextField: some View {
        VStack {
            HStack {
                Text("Password")
                    .font(.primary(.regular))
                Spacer()
            }

            SecureField("Password", text: $password)
                .padding()
                .foregroundColor(Color.text)
                .background(RoundedRectangle(cornerRadius: 5.0).fill(Color.backgroundTextField))
                .font(.primary(.regular))
        }
    }
    
    private var loginButton: some View {
        ZStack {
            Button("Login", action: onLoginClick)
                .buttonStyle(FullWidthButton())
                .font(.primary(.regular))
            
            HStack {
                Spacer()
                ProgressView()
                    .padding(.trailing, 16)
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .opacity(_viewModel.state == .loading ? 1.0 : 0.0)
            }
        }
    }
}
