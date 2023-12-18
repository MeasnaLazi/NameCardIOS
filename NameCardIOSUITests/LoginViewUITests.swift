//
//  LoginViewUITests.swift
//  NameCardIOSUITests
//
//  Created by Measna on 30/11/23.
//

import XCTest

private let _app = XCUIApplication()

final class LoginViewUITests : XCTestCase {
        
    private let _usernameTextField = _app.textFields["usernameTextField"]
    private let _passwordTextField = _app.secureTextFields["passwordTextField"]
    private let _loginButton = _app.buttons["loginButton"]
    
    override func setUp() {
        continueAfterFailure = false
        _app.launchArguments.append(Config().testArgument)
        _app.launch()
    }
    
    override func tearDown() {

    }
    
    func testCheckComponentsExist() {
        XCTAssert(_usernameTextField.exists)
        XCTAssert(_passwordTextField.exists)
        XCTAssert(_loginButton.exists)
    }
    
    func testValidation() {
        
        _loginButton.tap()
        
        XCTAssert(_app.staticTexts["Username required!"].exists)
        
        _usernameTextField.tap()
        _usernameTextField.typeText("test")
        _loginButton.tap()
        
        XCTAssert(!_app.staticTexts["Username required!"].exists)
  
        _loginButton.tap()
        
        XCTAssert(_app.staticTexts["Password required!"].exists)
        
        _passwordTextField.tap()
        _passwordTextField.typeText("11111111")
        _loginButton.tap()
        
        XCTAssert(!_app.staticTexts["Password required!"].exists)
        
    }
    
    func testWrongUsername() {

        _usernameTextField.tap()
        _usernameTextField.press(forDuration: 1.2)
        _app.menuItems["Select All"].tap()
        _usernameTextField.typeText("hii")

        let username = _usernameTextField.value as! String

        XCTAssertNotEqual(username, "")
    }
    
    func testCorrectUsername() {
        _usernameTextField.tap()
        _app.keys["L"].tap()
        _app.keys["a"].tap()
        _app.keys["z"].tap()
        _app.keys["i"].tap()

        let username = _usernameTextField.value as! String

        XCTAssertNotEqual(username, "")
    }
    
    func testWrongPassword() {
        
        _passwordTextField.tap()
        _passwordTextField.press(forDuration: 1.2)
        _app.menuItems["Select All"].tap()
        _passwordTextField.typeText("1111111")
        
        let passwordValue = _passwordTextField.value as! String
        
        XCTAssertNotEqual(passwordValue, "")
    }
    
    func testCorrectPassword() {
        
        _passwordTextField.tap()
        
        _app.keys["more"].tap()
        _app.keys["1"].tap()
        _app.keys["2"].tap()
        _app.keys["3"].tap()
        _app.keys["4"].tap()
        _app.keys["5"].tap()
        _app.keys["6"].tap()
        _app.keys["7"].tap()
        _app.keys["8"].tap()
        _app.keyboards.buttons["Return"].tap()
        
        let passwordValue = _passwordTextField.value as! String
        
        XCTAssertNotEqual(passwordValue, "")
    }
    
    // Integration Test
    func testLoginFail() {
        testCheckComponentsExist()
        testValidation()
        testWrongUsername()
        testWrongPassword()
        
        _loginButton.tap()
        
        XCTAssert(_app.staticTexts["Invalid Username or Password!"].exists)
    }
    
    func testLoginSuccessful() {
        testCheckComponentsExist()
        testCorrectUsername()
        testCorrectPassword()
        
        _loginButton.tap()
        
        XCTAssert(_app.staticTexts["Wallet"].waitForExistence(timeout: 1.0))
        
    }
}
