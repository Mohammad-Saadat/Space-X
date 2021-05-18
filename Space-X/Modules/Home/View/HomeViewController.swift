//
//  HomeViewController.swift
//  Space-X
//
//  Created by mohammad on 5/18/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol HomeDisplayLogic: class {
    func hidePullToRefresh()
    func showLoading()
    func hideLoading()
    func displayData()
    
    func displayNextPage()
    func showPaginationLoading()
    func hidePaginationLoading()
}

class HomeViewController: UIViewController {
    // MARK: - Object lifecycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("HomeViewController - Initialization using coder Not Allowed.")
    }
    
    init(factory: HomeFactory) {
        super.init(nibName: HomeViewController.nibName, bundle: nil)
        self.factory = factory
        factory.setup(viewController: self)
        HomeLogger.logInit(owner: String(describing: HomeViewController.self))
    }
    
    // MARK: - Deinit
    deinit {
        HomeLogger.logDeinit(owner: String(describing: HomeViewController.self))
    }
    
    // MARK: - Properties
    
    // MARK: Private
    private var factory: HomeFactory!
    
    // pull to refresh
    private lazy var pullToRefresh: UIRefreshControl = {
        let pullToRefresh = UIRefreshControl()
        pullToRefresh.tintColor = .black
        pullToRefresh.addTarget(self, action: #selector(refreshPage), for: .valueChanged)
        tableView.alwaysBounceVertical = true
        tableView.refreshControl = pullToRefresh
        return pullToRefresh
    }()
    
    // MARK: Public
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
    
    // MARK: - Outlets
    @IBOutlet private weak var tableView: DefaultTableView!
}

// MARK: - View Controller

// MARK: Life Cycle
extension HomeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        factory.setup(viewController: self)
    }
}

// MARK: - Methods

// MARK: Private
private extension HomeViewController {
    @objc func refreshPage() {
        self.pullToRefresh.beginRefreshing()
//        interactor?.refreshPage()
    }
}

// MARK: Public
extension HomeViewController {}

// MARK: - Display Logic
extension HomeViewController: HomeDisplayLogic {
    func displayData() {
        
    }
    
    func showPaginationLoading() {
        
    }
    
    func hidePaginationLoading() {
        
    }
    
    func displayNextPage() {
        
    }
    
    func showLoading() {
        view.showLoading()
    }
    
    func hideLoading() {
        view.hideLoading()
    }
    
    func hidePullToRefresh() {
        pullToRefresh.endRefreshing()
    }
}

// MARK: - Actions
extension HomeViewController {}

// MARK: - PaginationProtocol
extension HomeViewController: PaginationProtocol {
    func loadNextPage() {
//        self.interactor?.fetchNextPage(request: .init())
    }
}
