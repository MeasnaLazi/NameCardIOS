//
//  LoginViewModelTest.swift
//  NameCardIOSTests
//
//  Created by Measna on 25/11/23.
//

import Combine
import XCTest
@testable import NameCardIOS

final class LoginViewModelTest: XCTestCase {
    
    private var _disposables = Set<AnyCancellable>()
    private var _loginViewModel:LoginViewModel!
    
    
    override func setUp() {
        super.setUp()
        _loginViewModel = LoginViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        _loginViewModel = nil
        _disposables.removeAll()
    }
    
    func testOnLoginClickWhenLoginSuccessful() {
        let username = "lazi"
        let password = "12345678"
        let expectation = XCTestExpectation(description: "Variable errMessage is empty and login is not nil")
        
        _loginViewModel.onLoginClick(username: username, password: password)
        _loginViewModel.$state.sink { [weak self] value in
            if value == .fetched {
                XCTAssertTrue(self?._loginViewModel.errorMessage.isEmpty ?? false)
                XCTAssertNotNil(self?._loginViewModel.login)
                expectation.fulfill()
            }
        }
        .store(in: &_disposables)
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testOnLoginClickWhenLoginFail() {
        let username = "lazii"
        let password = "123456789"
        let expectation = XCTestExpectation(description: "Variable errMessage has value and login is nil")
        
        _loginViewModel.onLoginClick(username: username, password: password)
        _loginViewModel.$state.sink { [weak self] value in
            if value == .fail {
                XCTAssertTrue(self?._loginViewModel.errorMessage.isEmpty == false)
                XCTAssertNil(self?._loginViewModel.login)
                expectation.fulfill()
            }
        }
        .store(in: &_disposables)
        wait(for: [expectation], timeout: 3.0)
    }
}
