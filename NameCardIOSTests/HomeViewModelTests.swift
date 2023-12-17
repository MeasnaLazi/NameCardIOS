//
//  HomeViewModelTests.swift
//  NameCardIOSTests
//
//  Created by Measna on 16/12/23.
//

import XCTest
import Combine
@testable import NameCardIOS

final class HomeViewModelTests: XCTestCase {
    
    private var _disposables = Set<AnyCancellable>()
    private var _homeViewModel: HomeViewModel!

    override func setUp() {
        super.setUp()
        _homeViewModel = HomeViewModel(requestExecutor: MockAPIClient())
    }
    
    override func tearDown() {
        super.tearDown()
        _homeViewModel = nil
        _disposables.removeAll()
    }
    
    func testOnFirstAppearAndRetrieveDataSuccessful() {
        
        let expectation = XCTestExpectation(description: "Get name card first page which is 15 items,  totalPage is 2 and count is 19")
        
        _homeViewModel.onViewAppear()
        _homeViewModel.$state.sink { [weak self] value in
            if value == .fetched {
                XCTAssertEqual(self?._homeViewModel.cards.count, 15)
                XCTAssertEqual(self?._homeViewModel.totalPage, 2)
                XCTAssertEqual(self?._homeViewModel.count, 19)
                expectation.fulfill()
            }
        }
        .store(in: &_disposables)
        wait(for: [expectation], timeout: 1.0)
        
    }
}
