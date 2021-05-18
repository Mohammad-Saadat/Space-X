//
//  HomePresenter.swift
//  Space-X
//
//  Created by mohammad on 5/18/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol HomePresentationLogic {
    //    func presentSomething(response: Home.Something.Response)
}

class HomePresenter {
    // MARK: - Object lifecycle
    init() {
        HomeLogger.logInit(owner: String(describing: HomePresenter.self))
    }
    
    // MARK: - Deinit
    deinit {
        HomeLogger.logDeinit(owner: String(describing: HomePresenter.self))
    }
    
    // MARK: - Properties
    
    // MARK: Public
    weak var viewController: HomeDisplayLogic?
}

// MARK: - Methods

// MARK: Private
private extension HomePresenter {}

// MARK: Public
extension HomePresenter {}

// MARK: - Presentation Logic
extension HomePresenter: HomePresentationLogic {}
