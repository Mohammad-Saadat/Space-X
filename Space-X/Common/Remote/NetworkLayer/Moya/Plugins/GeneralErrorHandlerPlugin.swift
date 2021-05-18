//
//  GeneralErrorHandlerPlugin.swift
//  MockFlash
//
//  Created by Ali Motevali on 2/26/20.
//  Copyright © 2020 RoundTableApps. All rights reserved.
//

import Foundation
import Moya
import UIKit

class GeneralErrorHandlerPlugin: PluginType {
    static let `default` = GeneralErrorHandlerPlugin()
    
    func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        handleIfGenericErrorHasBeenHappened(result)
    }
    
    func handleIfGenericErrorHasBeenHappened(_ result: Result<Moya.Response, MoyaError>) {
        guard case Result.failure(let error) = result else { return }
        if let generalError = GeneralErrors.parseError(error) {
            generalError.getHandler().handleError()
        }
    }

}
