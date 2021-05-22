//
//  DetailDependencyContainer.swift
//  Space-X
//
//  Created by mohammadSaadat on 2/30/1400 AP.
//  Copyright (c) 1400 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

class DetailDependencyContainer: DependencyContainer {
    // MARK: - Object lifecycle
    override init() {
        DetailLogger.logInit(owner: String(describing: DetailDependencyContainer.self))
    }
    
    // MARK: - Deinit
    deinit {
        DetailLogger.logDeinit(owner: String(describing: DetailDependencyContainer.self))
    }
}

// MARK: - Factory
extension DetailDependencyContainer: DetailFactory {
    func makeDetailViewController(launchId: String) -> DetailViewController {
        let vc = DetailViewController(factory: self)
        vc.router?.dataStore?.launchId = launchId
        return vc
    }
    
    func setup(viewController: DetailViewController) {
        guard viewController.interactor == nil else { return }
        let interactor = DetailInteractor()
        let presenter = DetailPresenter()
        let router = DetailRouter()
        let worker = DetailWorker(service: makeDetailService())
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    func makeDetailService() -> DetailService {
        return DetailService(networkManager: networkManager)
    }
}
