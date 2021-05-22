//
//  DetailViewControllerTest.swift
//  Space-XTests
//
//  Created by mohammadSaadat on 2/31/1400 AP.
//

import XCTest
@testable import Space_X

class DetailViewControllerTest: XCTestCase {

    var sut: DetailViewController!
    var window: UIWindow!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        window = UIWindow()
        setupHomeViewController()
    }
    
    override func tearDownWithError() throws {
        window = nil
        sut = nil
        super.tearDown()
    }
    
    func setupHomeViewController() {
        let detailDependencyContainer = DetailDependencyContainer()
        sut = detailDependencyContainer.makeDetailViewController(launchId: "")
    }
    
    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK: - interactor
    class DetailInteractorTest: DetailBusinessLogic {
        // MARK: Method call expectations
        
        var fetchLaunchCalled = false
        
        // MARK: Business Logics methods
        
        func fetchLaunchInfo() {
            fetchLaunchCalled = true
        }
    }
    
    // MARK: - Tests
    func testShouldFetchLaunchInfoWhenViewDidAppear() {
        // Given
        let detailInteractorTest = DetailInteractorTest()
        sut.interactor = detailInteractorTest
        loadView()
        
        // When
        sut.viewDidAppear(true)
        
        // Then
        XCTAssert(detailInteractorTest.fetchLaunchCalled, "Should fetch launch Info right after the view appears")
    }
    
    func testDisplayDataFunction() {
        // Given
        let detailInteractorTest = DetailInteractorTest()
        sut.interactor = detailInteractorTest
        loadView()
        
        // When
        let viewModel = Detail.Info.ViewModel(name: "Test rocket",
                                              detail: "test detail",
                                              launchDate: "launch date: 2006-03-25",
                                              failures: "number of failures: 33 times",
                                              rocketImage: nil)
        sut.displayData(viewModel: viewModel)
        
        // Then
        XCTAssertEqual(sut.nameLabel.text, "Test rocket", "A properly configured nameLabel should display the launch name")
        XCTAssertEqual(sut.detailsLabel.text, "test detail", "A properly configured detailsLabel should display the detail name")
        XCTAssertEqual(sut.launchDateLabel.text, "launch date: 2006-03-25", "A properly configured launchDateLabel should display the launch date")
        XCTAssertEqual(sut.failuresLabel.text, "number of failures: 33 times", "A properly configured failuresLabel should display the failures")
    }

}
