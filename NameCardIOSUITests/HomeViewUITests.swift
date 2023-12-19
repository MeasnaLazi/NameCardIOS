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
    
    func testAutomation() {
        
        _loginViewUITests.testLoginSuccessful()
        
        XCTAssert(_searchField.waitForExistence(timeout: 1))
        _searchField.tap()
        
        _app.keys["M"].tap()
        _app.keys["e"].tap()
        _app.keys["a"].tap()
        _app.keys["s"].tap()
        _app.keys["n"].tap()
        _app.keys["a"].tap()
        
        _app.keyboards.buttons["Search"].tap()
        
        let firstItemButton = _app.buttons["656932740ee92ba99e2e0886"]
        XCTAssert(firstItemButton.waitForExistence(timeout: 1))
        firstItemButton.tap()
        
        let firstItemDetailImage = _app.images["656932740ee92ba99e2e0886"]
        XCTAssert(firstItemDetailImage.waitForExistence(timeout: 1))
        firstItemDetailImage.swipeDown()
        
        _app.buttons["Clear text"].tap()
        
        let secondItemButton = _app.buttons["656932740ee92ba99e2e0887"]
        XCTAssert(secondItemButton.waitForExistence(timeout: 1.5))
        
        firstItemButton.swipeUp()
        
        let nextItemButton = _app.buttons["156932740ee92ba99e2e0887"]
        nextItemButton.tap()
        
        let nextItemDetailImage = _app.images["156932740ee92ba99e2e0887"]
        XCTAssert(nextItemDetailImage.waitForExistence(timeout: 1.5))
        nextItemDetailImage.swipeDown()
        
        
        XCTAssert(firstItemButton.waitForExistence(timeout: 1))
        _app.buttons["Cancel"].tap()
       
        XCTAssert(_app.buttons["createButton"].waitForExistence(timeout: 5.0))
                
    }
    
}
