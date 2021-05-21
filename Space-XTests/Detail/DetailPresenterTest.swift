//
//  DetailPresenterTest.swift
//  Space-XTests
//
//  Created by mohammadSaadat on 2/31/1400 AP.
//

import XCTest
@testable import Space_X

class DetailPresenterTest: XCTestCase {
    
    var sut: DetailPresenter!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        setupDetailInteractor()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }
    
    func setupDetailInteractor() {
        sut = DetailPresenter()
    }
    
    // MARK: - DisplayLogic
    class DetailDisplayLogicTest: DetailDisplayLogic {
        
        
        // MARK: Method call expectations
        var displayErrorCalled = false
        var displayDataCalled = false
       
        
        // MARK: Display Logics methods
        func displayError(viewModel: Detail.ErrorModel.ViewModel) {
            displayErrorCalled = true
        }
        
        func displayData(viewModel: Detail.Info.ViewModel) {
            displayDataCalled = true
        }
        
        func showLoading() {}
        func hideLoading() {}
    }
    
    // MARK: - Tests
    func testPresentErrorShouldAskViewControllerToDisplayError() {
        // Given
        let detailDisplayLogicTest = DetailDisplayLogicTest()
        sut.viewController = detailDisplayLogicTest
        
        // When
        sut.presentError(response: Detail.ErrorModel.Response(error: NetworkErrors.connectionTimeout))
        
        // Then
        XCTAssert(detailDisplayLogicTest.displayErrorCalled, "Presenting error should ask view controller to display error")
    }
    
    func testPresentErrorShouldAskViewControllerToDisplayData() {
        // Given
        let detailDisplayLogicTest = DetailDisplayLogicTest()
        sut.viewController = detailDisplayLogicTest
        
        // When
        sut.presentData(response: Detail.Info.Response(launchData: LaunchData(id: UUID().uuidString)))
        
        // Then
        XCTAssert(detailDisplayLogicTest.displayDataCalled, "Presenting data should ask view controller to display data")
    }
}
