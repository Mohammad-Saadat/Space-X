//
//  DetailInteractor.swift
//  Space-X
//
//  Created by mohammadSaadat on 2/30/1400 AP.
//  Copyright (c) 1400 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol DetailBusinessLogic {
    //    func doSomething(request: Detail.Something.Request)
}

protocol DetailDataStore {}

class DetailInteractor: DetailDataStore {
    // MARK: - Object lifecycle
    init() {
        DetailLogger.logInit(owner: String(describing: DetailInteractor.self))
    }
    
    // MARK: - Deinit
    deinit {
        DetailLogger.logDeinit(owner: String(describing: DetailInteractor.self))
    }
    
    // MARK: - Properties
    
    // MARK: Public
    var presenter: DetailPresentationLogic?
    var worker: DetailWorkerLogic?
}

// MARK: - Methods

// MARK: Private
private extension DetailInteractor {}

// MARK: Public
extension DetailInteractor {}

// MARK: - Business Logics
extension DetailInteractor: DetailBusinessLogic {}
