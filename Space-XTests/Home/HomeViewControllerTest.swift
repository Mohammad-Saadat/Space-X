//
//  HomeViewControllerTest.swift
//  Space-XTests
//
//  Created by mohammadSaadat on 2/31/1400 AP.
//

import XCTest
@testable import Space_X

class HomeViewControllerTest: XCTestCase {
    
    var sut: HomeViewController!
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
    
    // MARK: - Test setup
    
    func setupHomeViewController() {
        let homeDpendencyContainer = HomeDependencyContainer()
        sut = homeDpendencyContainer.makeHomeViewController()
    }
    
    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK: - interactor
    class HomeInteractorTest: HomeBusinessLogic {
        
        
        private var launchDatas = [LaunchData]()
        
        // MARK: Method call expectations
        
        var fetchLaunchDataCalled = false
        var startTimerCalled = false
        var fetchNextPageCalled = false
        var refreshPageCalled = false
        
        // MARK: Business Logics methods
        
        func fetchData() {
            fetchLaunchDataCalled = true
        }
        
        func refreshPage() {
            refreshPageCalled = true
        }
        
        func fetchNextPage() {
            fetchNextPageCalled = true
        }
        
        func startTimer() {
            startTimerCalled = true
        }
        
    }
    
    // MARK: - tableView
    class HomeTableView: DefaultTableView {
        // MARK: Method call expectations
        
        var reloadDataCalled = false
        
        // MARK: reloadData method
        
        override func reloadData() {
            reloadDataCalled = true
        }
    }
    
    // MARK: - Tests
    func testShouldFetchLaunchDataWhenViewDidAppear() {
        // Given
        let homeInteractorTest = HomeInteractorTest()
        sut.interactor = homeInteractorTest
        loadView()
        
        // When
        sut.viewDidAppear(true)
        
        // Then
        XCTAssert(homeInteractorTest.fetchLaunchDataCalled, "Should fetch launch right after the view appears")
        XCTAssert(homeInteractorTest.startTimerCalled, "Should called start Timer right after the view appears")
        XCTAssert(!homeInteractorTest.fetchNextPageCalled, "Should not called fetch next page right after the view appears")
        XCTAssert(!homeInteractorTest.refreshPageCalled, "Should not called refresh page right after the view appears")
    }
    
    func testShouldDisplayFetchedOrders() {
        // Given
        let homeTableView = HomeTableView(frame: CGRect(origin: .zero, size: .zero))
        sut.tableView = homeTableView
        
        // When
        let displayedLaunch = [LaunchData(id: UUID().uuidString)]
        let viewModelsCells = displayedLaunch.compactMap { ItemCellViewModel(launchData: $0) }
        let section = DefaultSection(cells: viewModelsCells)
        let viewModel = Home.Item.ViewModel(sections: [section])
        sut.displayData(viewModel: viewModel)
        
        // Then
        XCTAssert(homeTableView.reloadDataCalled, "displayData should reload the table view")
    }
    
    func testNumberOfRowsInAnySectionShouldEqaulNumberOfLaunchToDisplay() {
        // Given
        let homeTableView = HomeTableView(frame: CGRect(origin: .zero, size: .zero))
        sut.tableView = homeTableView
        
        let displayedLaunch = [LaunchData(id: UUID().uuidString)]
        let viewModelsCells = displayedLaunch.compactMap { ItemCellViewModel(launchData: $0) }
        let section = DefaultSection(cells: viewModelsCells)
        let viewModel = Home.Item.ViewModel(sections: [section])
        sut.displayData(viewModel: viewModel)
        
        // When
        let numberOfRows = sut.tableView.numberOfRows(inSection: 0)
        
        // Then
        XCTAssertEqual(numberOfRows, displayedLaunch.count, "The number of table view rows should equal the number of LaunchData")
    }
    
    func testShouldConfigureTableViewCellToDisplayLaunchData() {
        // Given
        let homeTableView = HomeTableView(frame: CGRect(origin: .zero, size: .zero))
        sut.tableView = homeTableView
        
        let displayedLaunch = [LaunchData(id: UUID().uuidString, name: "Test rocket", localDate: "2006-03-25T10:30:00+12:00")]
        let viewModelsCells = displayedLaunch.compactMap { ItemCellViewModel(launchData: $0) }
        let section = DefaultSection(cells: viewModelsCells)
        let viewModel = Home.Item.ViewModel(sections: [section])
        sut.displayData(viewModel: viewModel)
        
        // When
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: indexPath) as! ItemTableViewCell
        
        // Then
        XCTAssertEqual(cell.nameLabel.text, "Test rocket", "A properly configured table view cell should display the launch name")
        XCTAssertEqual(cell.launchDateLabel.text, "launch date: 2006-03-25", "A properly configured table view cell should display the launch date")
    }
    
}
