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
    func startTimer()
}

protocol HomeDataStore {}

class HomeInteractor: HomeDataStore {
    // MARK: - Object lifecycle
    init(networkStateNotifier: NetworkStateNotifier) {
        HomeLogger.logInit(owner: String(describing: HomeInteractor.self))
        self.networkStateNotifier = networkStateNotifier
    }
    
    // MARK: - Deinit
    deinit {
        HomeLogger.logDeinit(owner: String(describing: HomeInteractor.self))
        timer?.invalidate()
        timer = nil
    }
    
    // MARK: - Properties
    
    // MARK: Private
    private let networkStateNotifier: NetworkStateNotifier
    private let refreshDataTime: TimeInterval = 30
    
    private var page: Int = 1
    private var launchDatas = [LaunchData]()
    private var timer: Timer?
    
    // MARK: Public
    var presenter: HomePresentationLogic?
    var worker: HomeWorkerLogic?
    
    
}

// MARK: - Methods

// MARK: Private
private extension HomeInteractor {
    func fetchData(pageLaunch: PageLaunch) {
        if let page = pageLaunch.page {
            self.page = page
        }
        self.launchDatas += pageLaunch.docs ?? []
        self.presenter?.presentData(response: .init(launchDatas: pageLaunch.docs))
    }
    
    func refreshPage(pageLaunch: PageLaunch) {
        if let page = pageLaunch.page {
            self.page = page
        }
        self.launchDatas = pageLaunch.docs ?? []
        self.presenter?.presentData(response: .init(launchDatas: pageLaunch.docs))
    }
    
    func fetchNextPage(pageLaunch: PageLaunch) {
        if let page = pageLaunch.page {
            self.page = page
        }
        self.launchDatas += pageLaunch.docs ?? []
        self.presenter?.presentNextPage(response: .init(launchDatas: pageLaunch.docs))
    }
    
    @objc private func timerAction() {
        HomeLogger.log(text: "timerAction called")
        if !networkStateNotifier.isConnected { return }
        let firstPage = 1
        let limit = Options.defaultLimit * self.page
        let option = Options(page: firstPage, limit: limit)
        let launchParams = LaunchParams(options: option)
        worker?.getLaunches(params: launchParams)
            .done(updateDataSource)
    }
    
    func updateDataSource(pageLaunch: PageLaunch) {
        var updateIndexPath = [IndexPath]()
        var hasUpdate = false
        for (index, launchData) in launchDatas.enumerated() {
            if let updateData = pageLaunch.docs?.first(where: { $0.id == launchData.id }), updateData != launchData {
                hasUpdate = true
                launchDatas[index] = updateData
                updateIndexPath.append(.init(item: index, section: 0))
                HomeLogger.log(text: "launchDatas updated")
            }
        }
        if hasUpdate { presenter?.presentUpdate(response: .init(launchDatas: launchDatas,
                                                                indexpaths: updateIndexPath)) }
    }
    
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
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: refreshDataTime,
                                     target: self,
                                     selector: #selector(timerAction),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    func fetchData() {
        let option = Options(page: self.page, limit: nil)
        let launchParams = LaunchParams(options: option)
        self.presenter?.showLoading()
        worker?.getLaunches(params: launchParams)
            .done(fetchData)
            .catch(presentError)
            .finally(hideLoadings)
    }
    
    func refreshPage() {
        let firstPage = 1
        let option = Options(page: firstPage, limit: nil)
        let launchParams = LaunchParams(options: option)
        worker?.getLaunches(params: launchParams)
            .done(refreshPage)
            .catch(presentError)
            .finally(hideLoadings)
    }
    
    func fetchNextPage() {
        let option = Options(page: self.page + 1, limit: nil)
        let launchParams = LaunchParams(options: option)
        self.presenter?.showPaginationLoading()
        worker?.getLaunches(params: launchParams)
            .done(fetchNextPage)
            .catch(presentError)
            .finally(hideLoadings)
    }
}
