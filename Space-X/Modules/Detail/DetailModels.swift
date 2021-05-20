//
//  DetailModels.swift
//  Space-X
//
//  Created by mohammadSaadat on 2/30/1400 AP.
//  Copyright (c) 1400 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum Detail {
    // MARK: Use cases
    
    enum ErrorModel {
        struct Response {
            var error: Error
        }
        struct ViewModel {
            var error: Error
        }
    }
    
    enum Info {
        struct Response {
            var launchData: LaunchData
        }
        struct ViewModel {
            var name: String?
            var detail: String?
            var launchDate: String?
            var failures: String?
            var rocketImage: String?
        }
    }
}
