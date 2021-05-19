//
//  HomeInteractor.swift
//  Space-X
//
//  Created by mohammad on 5/18/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol HomeBusinessLogic {
    func fetchData()
    func refreshPage()
    func fetchNextPage()
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
    
    // MARK: Private
    private var page: Int = 1
    private var launchDatas = [LaunchDate]()
    
    // MARK: Public
    var presenter: HomePresentationLogic?
    var worker: HomeWorkerLogic?
    
    
}

// MARK: - Methods

// MARK: Private
private extension HomeInteractor {
    func presentError(_ error: Error) {
        self.presenter?.presentError(response: .init(error: error))
    }
    
    func hideLoadings() {
        self.presenter?.hideLoading()
        self.presenter?.hidePullToRefresh()
        self.presenter?.hidePaginationLoading()
    }
}

// MARK: Public
extension HomeInteractor {}

// MARK: - Business Logics
extension HomeInteractor: HomeBusinessLogic {
    func fetchData() {
        let option = Options(page: self.page)
        self.presenter?.showLoading()
        worker?.getLaunches(params: option).done { [weak self] response in
            guard let `self` = self else { return }
            if let page = response.page {
                self.page = page
            }
            self.launchDatas += response.docs ?? []
            self.presenter?.presentData(response: .init(launchDatas: response.docs))
        }
        .catch(presentError)
        .finally(hideLoadings)
    }
    
    func refreshPage() {
        let firstPage = 1
        let option = Options(page: firstPage)
        worker?.getLaunches(params: option).done { [weak self] response in
            guard let `self` = self else { return }
            if let page = response.page {
                self.page = page
            }
            self.launchDatas = response.docs ?? []
            self.presenter?.presentData(response: .init(launchDatas: response.docs))
        }
        .catch(presentError)
        .finally(hideLoadings)
    }
    
    func fetchNextPage() {
        let option = Options(page: self.page + 1)
        self.presenter?.showPaginationLoading()
        worker?.getLaunches(params: option).done { [weak self] response in
            guard let `self` = self else { return }
            if let page = response.page {
                self.page = page
            }
            self.launchDatas += response.docs ?? []
            self.presenter?.presentNextPage(response: .init(launchDatas: response.docs))
        }
        .catch(presentError)
        .finally(hideLoadings)
    }
}
