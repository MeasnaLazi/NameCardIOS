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
    
    @State private var _username: String = ""
    @State private var _password: String = ""
    
    private func onLoginClick() {
        guard !_username.isEmpty else {
            _viewModel.errorMessage = "Username required!"
            return
        }
        guard !_password.isEmpty else {
            _viewModel.errorMessage = "Password required!"
            return
        }
        guard _password.count > 5 else {
            _viewModel.errorMessage = "Invalid Username or Password!"
            return
        }

        _viewModel.onLoginClick(username: _username.lowercased(), password: _password)
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
                Text(_viewModel.errorMessage)
                    .errorStyle()
                    .padding(.top, 12)
                Spacer()
            }
        }
        .safeAreaPadding()
    }
    
    private var usernameTextField: some View {
        VStack {
            HStack {
                Text("Username")
                    .textFieldLabelStyle()
                Spacer()
            }
            
            TextField("Username", text: $_username)
                .primaryTextFieldStyle()
        }
    }
    
    private var passwordTextField: some View {
        VStack {
            HStack {
                Text("Password")
                    .textFieldLabelStyle()
                Spacer()
            }

            SecureField("Password", text: $_password)
                .primaryTextFieldStyle()
        }
    }
    
    private var loginButton: some View {
        ZStack {
            Button("Login", action: onLoginClick)
                .buttonStyle(FullWidthButton())
    
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
