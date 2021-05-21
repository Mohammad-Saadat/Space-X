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
    func presentUpdate(response: Home.Update.Response)
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
private extension HomePresenter {
    func guaranteeMainThread(_ work: @escaping (() -> Void)) {
        if Thread.isMainThread {
            work()
        } else {
            DispatchQueue.main.async(execute: work)
        }
    }
}

// MARK: Public
extension HomePresenter {}

// MARK: - Presentation Logic
extension HomePresenter: HomePresentationLogic {
    func presentUpdate(response: Home.Update.Response) {
        let viewModels = response.launchDatas.compactMap { ItemCellViewModel(launchData: $0) }
        let section = DefaultSection(cells: viewModels)
        guaranteeMainThread {
            self.viewController?.displayUpdateData(viewModel: .init(sections: [section],
                                                                    indexpaths: response.indexpaths))
        }
    }
    
    func presentError(response: Home.ErrorModel.Response) {
        guaranteeMainThread {
            self.viewController?.displayError(viewModel: .init(error: response.error))
        }
    }
    
    func hidePullToRefresh() {
        guaranteeMainThread {
            self.viewController?.hidePullToRefresh()
        }
    }
    
    func showLoading() {
        guaranteeMainThread {
            self.viewController?.showLoading()
        }
    }
    
    func hideLoading() {
        guaranteeMainThread {
            self.viewController?.hideLoading()
        }
    }
    
    func presentData(response: Home.Item.Response) {
        let viewModels = response.launchDatas?.compactMap { ItemCellViewModel(launchData: $0) } ?? []
        let section = DefaultSection(cells: viewModels)
        guaranteeMainThread {
            self.viewController?.displayData(viewModel: .init(sections: [section]))
        }
    }
    
    func presentNextPage(response: Home.NextPage.Response) {
        let viewModels = response.launchDatas?.compactMap { ItemCellViewModel(launchData: $0) } ?? []
        guaranteeMainThread {
            self.viewController?.displayNextPage(viewModel: .init(cells: viewModels))
        }
    }
    
    func showPaginationLoading() {
        guaranteeMainThread {
            self.viewController?.showPaginationLoading()
        }
    }
    
    func hidePaginationLoading() {
        guaranteeMainThread {
            self.viewController?.hidePaginationLoading()
        }
    }
    
}
