//
//  DetailWorker.swift
//  Space-X
//
//  Created by mohammadSaadat on 2/30/1400 AP.
//  Copyright (c) 1400 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import PromiseKit

protocol DetailWorkerLogic {
    func getLaunche(id: String) -> Promise<LaunchData>
}

class DetailWorker {
    // MARK: - Object lifecycle
    init(service: DetailService) {
        DetailLogger.logInit(owner: String(describing: DetailWorker.self))
        self.service = service
    }
    
    // MARK: - Deinit
    deinit {
        DetailLogger.logDeinit(owner: String(describing: DetailWorker.self))
    }
    
    // MARK: - Properties
    
    // MARK: Private
    private let service: DetailService
}

// MARK: - Methods

// MARK: Private
private extension DetailWorker {}

// MARK: - Worker Logic
extension DetailWorker: DetailWorkerLogic {
    func getLaunche(id: String) -> Promise<LaunchData> {
        service.getLaunche(id: id)
    }
}
