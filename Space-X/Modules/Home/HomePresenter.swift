//
//  HomePresenter.swift
//  Space-X
//
//  Created by mohammad on 5/18/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol HomePresentationLogic {
    func presentError(response: Home.ErrorModel.Response)
    func hidePullToRefresh()
    func showLoading()
    func hideLoading()
    func presentData(response: Home.Item.Response)
    func presentNextPage(response: Home.NextPage.Response)
    func showPaginationLoading()
    func hidePaginationLoading()
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
extension HomePresenter: HomePresentationLogic {
    func presentError(response: Home.ErrorModel.Response) {
        DispatchQueue.main.async {
            self.viewController?.displayError(viewModel: .init(error: response.error))
        }
    }
    
    func hidePullToRefresh() {
        DispatchQueue.main.async {
            self.viewController?.hidePullToRefresh()
        }
    }
    
    func showLoading() {
        DispatchQueue.main.async {
            self.viewController?.showLoading()
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.viewController?.hideLoading()
        }
    }
    
    func presentData(response: Home.Item.Response) {
        DispatchQueue.main.async {
            
        }
    }
    
    func presentNextPage(response: Home.NextPage.Response) {
        DispatchQueue.main.async {
            
        }
    }
    
    func showPaginationLoading() {
        DispatchQueue.main.async {
            self.viewController?.showPaginationLoading()
        }
    }
    
    func hidePaginationLoading() {
        DispatchQueue.main.async {
            self.viewController?.hidePaginationLoading()
        }
    }
    
}
