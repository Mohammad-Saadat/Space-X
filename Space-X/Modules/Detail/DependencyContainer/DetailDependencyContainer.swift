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
    func makeDetailViewController() -> DetailViewController {
        return DetailViewController(factory: self)
    }
    
    func makeDetailService() -> DetailService {
        return DetailService(networkManager: networkManager)
    }
}
