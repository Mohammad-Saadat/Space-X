//
//  DetailInteractor.swift
//  Space-X
//
//  Created by mohammadSaadat on 2/30/1400 AP.
//  Copyright (c) 1400 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol DetailBusinessLogic {
    func fetchLaunchInfo()
}

protocol DetailDataStore {
    var launchId: String? { get set }
    var articleLink: String? { get set }
}

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
    
    // MARK: Private
    internal var launchId: String?
    internal var articleLink: String?
    
    // MARK: Public
    var presenter: DetailPresentationLogic?
    var worker: DetailWorkerLogic?
}

// MARK: - Methods

// MARK: Private
private extension DetailInteractor {
    func presentError(_ error: Error) {
        self.presenter?.presentError(response: .init(error: error))
    }
    
    func hideLoadings() {
        self.presenter?.hideLoading()
    }
}

// MARK: Public
extension DetailInteractor {}

// MARK: - Business Logics
extension DetailInteractor: DetailBusinessLogic {
    func fetchLaunchInfo() {
        guard let launchId = self.launchId else { return }
        self.presenter?.showLoading()
        worker?.getLaunche(id: launchId).done { [weak self] response in
            guard let `self` = self else { return }
            self.articleLink = response.links?.article
            self.presenter?.presentData(response: .init(launchData: response))
        }
        .catch(presentError)
        .finally(hideLoadings)
    }
}
