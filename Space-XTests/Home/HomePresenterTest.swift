//
//  HomePresenterTest.swift
//  Space-XTests
//
//  Created by mohammadSaadat on 2/31/1400 AP.
//

import XCTest
@testable import Space_X

class HomePresenterTest: XCTestCase {
    
    var sut: HomePresenter!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        setupHomeInteractor()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }
    
    func setupHomeInteractor() {
        sut = HomePresenter()
    }
    
    // MARK: - DisplayLogic
    class HomeDisplayLogicTest: HomeDisplayLogic {
        // MARK: Method call expectations
        
        var displayErrorCalled = false
        var displayDataCalled = false
        var displayUpdateDataCalled = false
        var displayNextPageCalled = false
        
        // MARK: Display Logics methods
        func displayError(viewModel: Home.ErrorModel.ViewModel) {
            displayErrorCalled = true
        }
        
        func hidePullToRefresh() {}
        func showLoading() {}
        func hideLoading() {}
        
        func displayData(viewModel: Home.Item.ViewModel) {
            displayDataCalled = true
        }
        
        func displayUpdateData(viewModel: Home.Update.ViewModel) {
            displayUpdateDataCalled = true
        }
        
        func displayNextPage(viewModel: Home.NextPage.ViewModel) {
            displayNextPageCalled = true
        }
        
        func showPaginationLoading() {}
        func hidePaginationLoading() {}
    }
    
    // MARK: - Tests
    func testPresentErrorShouldAskViewControllerToDisplayError() {
        // Given
        let homeDisplayLogicTest = HomeDisplayLogicTest()
        sut.viewController = homeDisplayLogicTest
        
        // When
        sut.presentError(response: Home.ErrorModel.Response(error: NetworkErrors.connectionTimeout))
        
        // Then
        XCTAssert(homeDisplayLogicTest.displayErrorCalled, "Presenting error should ask view controller to display error")
    }
    
    func testPresentErrorShouldAskViewControllerToDisplayData() {
        // Given
        let homeDisplayLogicTest = HomeDisplayLogicTest()
        sut.viewController = homeDisplayLogicTest
        
        // When
        sut.presentData(response: Home.Item.Response(launchDatas: [LaunchData(id: UUID().uuidString)]))
        
        // Then
        XCTAssert(homeDisplayLogicTest.displayDataCalled, "Presenting data should ask view controller to display data")
    }
    
    func testPresentUpdateShouldAskViewControllerToDisplayUpdate() {
        // Given
        let homeDisplayLogicTest = HomeDisplayLogicTest()
        sut.viewController = homeDisplayLogicTest
        
        // When
        sut.presentUpdate(response: Home.Update.Response(launchDatas: [LaunchData(id: UUID().uuidString)],
                                                         indexpaths: [IndexPath(item: 0, section: 0)]))
        
        // Then
        XCTAssert(homeDisplayLogicTest.displayUpdateDataCalled, "Presenting data should ask view controller to display update")
    }
    
    func testPresentNextPageShouldAskViewControllerToDisplayNextPage() {
        // Given
        let homeDisplayLogicTest = HomeDisplayLogicTest()
        sut.viewController = homeDisplayLogicTest
        
        // When
        sut.presentNextPage(response: Home.NextPage.Response(launchDatas: [LaunchData(id: UUID().uuidString)]))
        
        // Then
        XCTAssert(homeDisplayLogicTest.displayNextPageCalled, "Presenting next page should ask view controller to display next page")
    }
    
}
