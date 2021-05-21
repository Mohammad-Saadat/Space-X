//
//  HomeIntercatorTest.swift
//  Space-XTests
//
//  Created by mohammadSaadat on 2/31/1400 AP.
//

import XCTest
import PromiseKit
@testable import Space_X

class HomeIntercatorTest: XCTestCase {
    
    var sut: HomeInteractor!
    
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
        sut = HomeInteractor(networkStateNotifier: NetworkStateNotifier.share)
    }
    
    // MARK: - presenter
    class HomePresentationLogicTest: HomePresentationLogic {
        
        // MARK: Method call expectations
        var presentDataCalled = false
        var presentUpdateCalled = false
        var presentNextPageCalled = false
        var presentErrorCalled = false
        
        // MARK: presenter Logics methods
        func presentError(response: Home.ErrorModel.Response) {
            presentErrorCalled = true
        }
        
        func hidePullToRefresh() {}
        func showLoading() {}
        func hideLoading() {}
        
        func presentData(response: Home.Item.Response) {
            presentDataCalled = true
        }
        
        func presentUpdate(response: Home.Update.Response) {
            presentUpdateCalled = true
        }
        
        func presentNextPage(response: Home.NextPage.Response) {
            presentNextPageCalled = true
        }
        
        func showPaginationLoading() {}
        func hidePaginationLoading() {}
    }
    
    // MARK: - worker
    class HomeWorkerLogicTest: HomeWorkerLogic {
        // MARK: Method call expectations
        var fetchDataCalled = false
        
        // MARK: worker Logics methods
        func getLaunches(params: LaunchParams) -> Promise<PageLaunch> {
            Promise { seal in
                fetchDataCalled = true
                let data = PageLaunch(docs: [LaunchData(id: UUID().uuidString)],
                                      totalDocs: 1,
                                      limit: params.options.limit,
                                      totalPages: 1,
                                      page: 1,
                                      pagingCounter: 1,
                                      hasPrevPage: false,
                                      hasNextPage: false,
                                      prevPage: nil,
                                      nextPage: nil)
                seal.fulfill(data)
            }
        }
    }
    
    // MARK: - Tests
    func testFetchDataShouldAskHomeWorkerToGetLaunchAndPresenterTopresentData() {
        // Given
        let homePresentationLogicTest = HomePresentationLogicTest()
        sut.presenter = homePresentationLogicTest
        let homeWorkerLogicTest = HomeWorkerLogicTest()
        sut.worker = homeWorkerLogicTest
        
        // When
        sut.fetchData()
        
        // Then
        XCTAssert(homeWorkerLogicTest.fetchDataCalled, "fetchData() should ask worker to fetch data Called")
        XCTAssert(homePresentationLogicTest.presentDataCalled, "fetchData() should ask presenter to present data called")
    }
    
    func testRefreshPageShouldAskHomeWorkerToGetLaunchAndPresenterTopresentData() {
        // Given
        let homePresentationLogicTest = HomePresentationLogicTest()
        sut.presenter = homePresentationLogicTest
        let homeWorkerLogicTest = HomeWorkerLogicTest()
        sut.worker = homeWorkerLogicTest
        
        // When
        sut.refreshPage()
        
        // Then
        XCTAssert(homeWorkerLogicTest.fetchDataCalled, "refreshPage() should ask worker to get Launches Called")
        XCTAssert(homePresentationLogicTest.presentDataCalled, "refreshPage() should ask presenter to present data called")
    }
    
    func testFetchNextPageShouldAskHomeWorkerToGetLaunchAndPresenterTopresentData() {
        // Given
        let homePresentationLogicTest = HomePresentationLogicTest()
        sut.presenter = homePresentationLogicTest
        let homeWorkerLogicTest = HomeWorkerLogicTest()
        sut.worker = homeWorkerLogicTest
        
        // When
        sut.fetchNextPage()
        
        // Then
        XCTAssert(homeWorkerLogicTest.fetchDataCalled, "fetchNextPage() should ask worker to get Launches Called")
        XCTAssert(homePresentationLogicTest.presentNextPageCalled, "fetchNextPage() should ask presenter to present Next Page called")
    }
}
