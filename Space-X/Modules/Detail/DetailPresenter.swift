//
//  DetailPresenter.swift
//  Space-X
//
//  Created by mohammadSaadat on 2/30/1400 AP.
//  Copyright (c) 1400 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol DetailPresentationLogic {
    //    func presentSomething(response: Detail.Something.Response)
}

class DetailPresenter {
    // MARK: - Object lifecycle
    init() {
        DetailLogger.logInit(owner: String(describing: DetailPresenter.self))
    }
    
    // MARK: - Deinit
    deinit {
        DetailLogger.logDeinit(owner: String(describing: DetailPresenter.self))
    }
    
    // MARK: - Properties
    
    // MARK: Public
    weak var viewController: DetailDisplayLogic?
}

// MARK: - Methods

// MARK: Private
private extension DetailPresenter {}

// MARK: Public
extension DetailPresenter {}

// MARK: - Presentation Logic
extension DetailPresenter: DetailPresentationLogic {}
