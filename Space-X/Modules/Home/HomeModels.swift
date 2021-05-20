//
//  HomeModels.swift
//  Space-X
//
//  Created by mohammad on 5/18/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum Home {
    // MARK: Use cases
    
    enum Item {
        struct Response {
            var launchDatas: [LaunchData]?
        }
        struct ViewModel {
            var sections: [SectionViewModel]
        }
    }
    
    enum NextPage {
        struct Response {
            var launchDatas: [LaunchData]?
        }
        struct ViewModel {
            var cells: [CellViewModel]
        }
    }
    
    enum ErrorModel {
        struct Response {
            var error: Error
        }
        struct ViewModel {
            var error: Error
        }
    }
}
