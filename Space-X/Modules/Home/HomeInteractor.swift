//
//  HomeInteractor.swift
//  Space-X
//
//  Created by mohammad on 5/18/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol HomeBusinessLogic {
    //    func doSomething(request: Home.Something.Request)
}

protocol HomeDataStore {}

class HomeInteractor: HomeDataStore {
    // MARK: - Object lifecycle
    init() {
        HomeLogger.logInit(owner: String(describing: HomeInteractor.self))
    }
    
    // MARK: - Deinit
    deinit {
        HomeLogger.logDeinit(owner: String(describing: HomeInteractor.self))
    }
    
    // MARK: - Properties
    
    // MARK: Public
    var presenter: HomePresentationLogic?
    var worker: HomeWorkerLogic?
}

// MARK: - Methods

// MARK: Private
private extension HomeInteractor {}

// MARK: Public
extension HomeInteractor {}

// MARK: - Business Logics
extension HomeInteractor: HomeBusinessLogic {}
