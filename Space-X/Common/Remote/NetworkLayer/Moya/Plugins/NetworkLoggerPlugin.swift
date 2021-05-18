//
//  NetworkLoggerPlugin.swift
//  MockFlash
//
//  Created by Ali Motevali on 2/26/20.
//  Copyright © 2020 RoundTableApps. All rights reserved.
//

import Moya

extension NetworkLoggerPlugin {
    static let `default`: NetworkLoggerPlugin = .init(configuration: .init(logOptions: [.requestBody, .formatRequestAscURL]))
}
