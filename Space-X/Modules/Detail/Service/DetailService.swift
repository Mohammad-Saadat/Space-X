//
//  DetailService.swift
//  Space-X
//
//  Created by mohammadSaadat on 2/30/1400 AP.
//  Copyright (c) 1400 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import PromiseKit

final class DetailService {
    // MARK: - Object lifecycle
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
        DetailLogger.logInit(owner: String(describing: DetailService.self))
    }
    
    // MARK: - Deinit
    deinit {
        DetailLogger.logDeinit(owner: String(describing: DetailService.self))
    }
    
    // MARK: - Properties
    
    // MARK: Private
    private let networkManager: NetworkManagerProtocol
}

// MARK: - Methods

// MARK: Public
extension DetailService {}
