//
//  LoginView.swift
//  NameCardIOS
//
//  Created by Measna on 24/11/23.
//

import Foundation
import SwiftUI

struct LoginView : View {
    
    @ObservedObject private var viewModel = VMFactory.shared.loginViewModel
    @AppStorage("token") private var token = ""
    @AppStorage("refreshToken") private var refreshToken = ""
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var moveToHomeScreen: Bool = false
    
    private func onLoginClick() {        
        viewModel.onLoginClick(username: username.lowercased(), password: password)
    }
    
    var body: some View {
        ZStack {
            switch viewModel.state {
            case .initial:
                Text("")
            case .loading:
                Text("")
            case .fetched:
                Text("").onAppear() {
                    token = viewModel.login?.token ?? ""
                    refreshToken = viewModel.login?.refreshToken ?? ""
                    
                    if !token.isEmpty && !refreshToken.isEmpty {
                        moveToHomeScreen = true
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
                Text(viewModel.errorMessage)
                    .errorStyle()
                loginButton
                    .padding(.top, 8)
        
                Spacer()
            }
            .onAppear() {
                viewModel.onViewAppear(refreshToken: refreshToken)
            }
            
            HStack {}
                .background(EmptyView())
                .fullScreenCover(isPresented: $moveToHomeScreen ){ HomeView() }
        }
        .safeAreaPadding(.horizontal, 20)
        .overlay {
            if viewModel.state == .loading {
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
            
            TextField("Username", text: $username)
                .primaryTextFieldStyle()
                .disabled(viewModel.state == .loading)
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

            SecureField("Password", text: $password)
                .primaryTextFieldStyle()
                .disabled(viewModel.state == .loading)
                .accessibilityIdentifier("passwordTextField")
            
        }
    }
    
    private var loginButton: some View {
        ZStack {
            Button("LOG IN", action: onLoginClick)
                .buttonStyle(FullWidthButton())
                .disabled(viewModel.state == .loading)
                .accessibilityIdentifier("loginButton")
            
    
            HStack {
                Spacer()
                ProgressView()
                    .padding(.trailing, 16)
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .opacity(viewModel.state == .loading ? 1.0 : 0.0)
            }
        }
    }
}

#Preview {
    LoginView()
}
