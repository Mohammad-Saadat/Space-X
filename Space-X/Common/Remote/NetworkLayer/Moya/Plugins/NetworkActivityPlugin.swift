//
//  NetworkActivityPlugin.swift
//  MockFlash
//
//  Created by Ali Motevali on 2/26/20.
//  Copyright © 2020 RoundTableApps. All rights reserved.
//

import Moya

extension NetworkActivityPlugin {
    static let `default`: NetworkActivityPlugin = .init { (networkActivityChangeType, _) in
        DispatchQueue.main.async {
            switch networkActivityChangeType {
            case .began:
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            case .ended:
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }
}
