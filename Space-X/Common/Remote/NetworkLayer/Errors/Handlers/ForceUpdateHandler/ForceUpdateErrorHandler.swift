//
//  ForceUpdateErrorHandler.swift
//  MockFlash
//
//  Created by Ali Motevali on 2/26/20.
//  Copyright © 2020 RoundTableApps. All rights reserved.
//

import Foundation

class ForceUpdateErrorHandler: ErrorHandlerProtocol {
    let error: GeneralErrors
    
    init(error: GeneralErrors) {
        self.error = error
    }
    
    func handleError() {
        guard case GeneralErrors.forceUpdate(messages: _) = error else { return }
//        AppDelegate.getInstance().callEventManager.forceUpdateErrorOccured()
//        WindowManager.shared.changeRootToForceUpdateViewController()
    }
}
