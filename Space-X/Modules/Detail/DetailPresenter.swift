//
//  DetailPresenter.swift
//  Space-X
//
//  Created by mohammadSaadat on 2/30/1400 AP.
//  Copyright (c) 1400 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol DetailPresentationLogic {
    func presentError(response: Detail.ErrorModel.Response)
    func showLoading()
    func hideLoading()
    func presentData(response: Detail.Info.Response)
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
private extension DetailPresenter {
    func guaranteeMainThread(_ work: @escaping (() -> Void)) {
        if Thread.isMainThread {
            work()
        } else {
            DispatchQueue.main.async(execute: work)
        }
    }
}

// MARK: Public
extension DetailPresenter {}

// MARK: - Presentation Logic
extension DetailPresenter: DetailPresentationLogic {
    func presentError(response: Detail.ErrorModel.Response) {
        guaranteeMainThread {
            self.viewController?.displayError(viewModel: .init(error: response.error))
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
    
    func presentData(response: Detail.Info.Response) {
        let launchData = response.launchData
        let launchDate = launchData.dateLocal?.toDate(withFormat: "yyyy-MM-dd'T'HH:mm:ssZ").toString(withFormat: "yyyy-MM-dd")
        let viewModel = Detail.Info.ViewModel(name: launchData.name,
                                              detail: launchData.details,
                                              launchDate: "launch date: \(launchDate ?? "")",
                                              failures: "number of failures: \(launchData.failures?.first?.time ?? 0) times",
                                              rocketImage: launchData.links?.patch?.large)
        guaranteeMainThread {
            self.viewController?.displayData(viewModel: viewModel)
        }
    }
}
