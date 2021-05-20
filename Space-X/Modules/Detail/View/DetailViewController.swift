//
//  DetailViewController.swift
//  Space-X
//
//  Created by mohammadSaadat on 2/30/1400 AP.
//  Copyright (c) 1400 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol DetailDisplayLogic: class {}

class DetailViewController: UIViewController {
    // MARK: - Object lifecycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("DetailViewController - Initialization using coder Not Allowed.")
    }
    
    init(factory: DetailFactory) {
        super.init(nibName: DetailViewController.nibName, bundle: nil)
        self.factory = factory
        setup()
        DetailLogger.logInit(owner: String(describing: DetailViewController.self))
    }
    
    // MARK: - Deinit
    deinit {
        DetailLogger.logDeinit(owner: String(describing: DetailViewController.self))
    }
    
    // MARK: - Properties
    
    // MARK: Private
    private var factory: DetailFactory!
    
    // MARK: Public
    var interactor: DetailBusinessLogic?
    var router: (NSObjectProtocol & DetailRoutingLogic & DetailDataPassing)?
    
    // MARK: - Outlets
}

// MARK: - View Controller

// MARK: Life Cycle
extension DetailViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

// MARK: - Methods

// MARK: Private
private extension DetailViewController {
    // Setup
    func setup() {
        guard self.interactor == nil else { return }
        let viewController = self
        let interactor = DetailInteractor()
        let presenter = DetailPresenter()
        let router = DetailRouter()
        let worker = DetailWorker(service: factory.makeDetailService())
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}

// MARK: Public
extension DetailViewController {}

// MARK: - Display Logic
extension DetailViewController: DetailDisplayLogic {}

// MARK: - Appearance
extension DetailViewController: Appearance {
    func setColor() {}
    
    func setFont() {}
}

// MARK: - Actions
extension DetailViewController {}
