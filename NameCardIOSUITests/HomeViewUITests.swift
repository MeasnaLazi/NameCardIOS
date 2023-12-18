//
//  HomeViewUITests.swift
//  NameCardIOSUITests
//
//  Created by Measna on 17/12/23.
//

import XCTest

private let _app = XCUIApplication()

final class HomeViewUITests: XCTestCase {
    
    private let _loginViewUITests = LoginViewUITests()
    private let _searchField = _app.searchFields["Search"]
    
    override func setUp() {
        continueAfterFailure = false
        _app.launchArguments.append(Config().testArgument)
        _app.launch()
    }
    
    override func tearDown() {
        
    }
    
    func testAfterSearchClickItem() {
        _searchField.tap()
        
        _app.keys["M"].tap()
        _app.keys["e"].tap()
        _app.keys["a"].tap()
        _app.keys["s"].tap()
        _app.keys["n"].tap()
        _app.keys["a"].tap()
        
        _app.keyboards.buttons["Search"].tap()
        
        XCTAssert(_app.buttons["656932740ee92ba99e2e0886"].waitForExistence(timeout: 1.0))
        
    }
    
}
