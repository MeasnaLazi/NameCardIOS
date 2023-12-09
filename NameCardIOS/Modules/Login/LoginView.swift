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
    @AppStorage("token") private var token = ""
    
    @State private var _username: String = ""
    @State private var _password: String = ""
    @State private var _moveToHomeScreen: Bool = false
    
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
                Text("").onAppear() {
                    token = _viewModel.login?.token ?? ""
                    if !token.isEmpty {
                        _moveToHomeScreen = true
                    }
                }
            case .fail:
                Text("")
            }
        
            VStack {
                logoImageView
                usernameTextField
                    .padding(.top, 32)
                passwordTextField
                    .padding(.top, 8)
                    .padding(.bottom, 8)
                Text(_viewModel.errorMessage)
                    .errorStyle()
                loginButton
                    .padding(.top, 8)
        
                Spacer()
            }
            
            HStack {}
                .background(EmptyView())
                .fullScreenCover(isPresented: $_moveToHomeScreen, content: { HomeView() })
        }
        .safeAreaPadding(.horizontal, 20)
    }
    
    private var logoImageView: some View {
        HStack {
            VStack {
                Image(systemName: "creditcard.viewfinder")
                    .foregroundColor(.primary)
                    .font(.system(size: 40))
                    .padding(.top, 12)
                Text("BC Wallet")
                    .font(.primary(.bold, size: 20))
                    .foregroundColor(.text)
                    .padding(.top, 10)
            }
        }
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
                .disabled(_viewModel.state == .loading)
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
                .disabled(_viewModel.state == .loading)
        }
    }
    
    private var loginButton: some View {
        ZStack {
            Button("Login", action: onLoginClick)
                .buttonStyle(FullWidthButton())
                .disabled(_viewModel.state == .loading)
    
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

#Preview {
    LoginView()
}
