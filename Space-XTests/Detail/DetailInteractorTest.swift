//
//  DetailInteractorTest.swift
//  Space-XTests
//
//  Created by mohammadSaadat on 2/31/1400 AP.
//

import XCTest
import PromiseKit
@testable import Space_X

class DetailInteractorTest: XCTestCase {

    var sut: DetailInteractor!
    
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
        sut = DetailInteractor()
    }
    
    // MARK: - presenter
    class DetailPresentationLogicTest: DetailPresentationLogic {
        // MARK: Method call expectations
        var presentErrorCalled = false
        var presentDataCalled = false
        
        // MARK: presenter Logics methods
        func presentError(response: Detail.ErrorModel.Response) {
            presentErrorCalled = true
        }
        
        func presentData(response: Detail.Info.Response) {
            presentDataCalled = true
        }
        
        func showLoading() {}
        func hideLoading() {}
    }
    
    // MARK: - worker
    class DetailWorkerLogicTest: DetailWorkerLogic {
        // MARK: Method call expectations
        var getLauncheCalled = false
        
        // MARK: worker Logics methods
        func getLaunche(id: String) -> Promise<LaunchData> {
            Promise { seal in
                getLauncheCalled = true
                seal.fulfill(LaunchData(id: UUID().uuidString))
            }
        }
    }
    
    // MARK: - Tests
    func testFetchLaunchInfoShouldAskDetailWorkerToGetLaunchAndPresenterTopresentData() {
        // Given
        let detailPresentationLogicTest = DetailPresentationLogicTest()
        sut.launchId = UUID().uuidString
        sut.presenter = detailPresentationLogicTest
        let detailWorkerLogicTest = DetailWorkerLogicTest()
        sut.worker = detailWorkerLogicTest
        
        // When
        sut.fetchLaunchInfo()
        
        // Then
        XCTAssert(detailWorkerLogicTest.getLauncheCalled, "fetchLaunchInfo() should ask worker to fetch data Called")
    }
}
