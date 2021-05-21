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
private extension HomePresenter {}

// MARK: Public
extension HomePresenter {}

// MARK: - Presentation Logic
extension HomePresenter: HomePresentationLogic {
    func presentUpdate(response: Home.Update.Response) {
        let viewModels = response.launchDatas.compactMap { ItemCellViewModel(launchData: $0) }
        let section = DefaultSection(cells: viewModels)
        DispatchQueue.main.async {
            self.viewController?.displayUpdateData(viewModel: .init(sections: [section],
                                                                    indexpaths: response.indexpaths))
        }
    }
    
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
        let viewModels = response.launchDatas?.compactMap { ItemCellViewModel(launchData: $0) } ?? []
        let section = DefaultSection(cells: viewModels)
        DispatchQueue.main.async {
            self.viewController?.displayData(viewModel: .init(sections: [section]))
        }
    }
    
    func presentNextPage(response: Home.NextPage.Response) {
        let viewModels = response.launchDatas?.compactMap { ItemCellViewModel(launchData: $0) } ?? []
        DispatchQueue.main.async {
            self.viewController?.displayNextPage(viewModel: .init(cells: viewModels))
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
