//
//  LoginView.swift
//  NameCardIOS
//
//  Created by Measna on 24/11/23.
//

import Foundation
import SwiftUI

struct LoginView : View {
    
    @ObservedObject private var _viewModel = VMFactory.shared.loginViewModel
    @AppStorage("token") private var token = ""
    @AppStorage("refreshToken") private var refreshToken = ""
    
    @State private var _username: String = ""
    @State private var _password: String = ""
    @State private var _moveToHomeScreen: Bool = false
    
    private func onLoginClick() {        
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
                    refreshToken = _viewModel.login?.refreshToken ?? ""
                    
                    if !token.isEmpty && !refreshToken.isEmpty {
                        _moveToHomeScreen = true
                    }
                }
            case .fail:
                Text("").onAppear() {
                    token = ""
                    refreshToken = ""
                }
            }
        
            VStack(alignment: .leading) {
                
                Text("Log in")
                    .font(.headline())
                    .padding(.top)
                    
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
            .onAppear() {
                _viewModel.onViewAppear(refreshToken: refreshToken)
            }
            
            HStack {}
                .background(EmptyView())
                .fullScreenCover(isPresented: $_moveToHomeScreen ){ HomeView() }
        }
        .safeAreaPadding(.horizontal, 20)
        .overlay {
            if _viewModel.state == .loading {
                LoadingView()
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
                .accessibilityIdentifier("usernameTextField")
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
                .accessibilityIdentifier("passwordTextField")
            
        }
    }
    
    private var loginButton: some View {
        ZStack {
            Button("LOG IN", action: onLoginClick)
                .buttonStyle(FullWidthButton())
                .disabled(_viewModel.state == .loading)
                .accessibilityIdentifier("loginButton")
            
    
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
