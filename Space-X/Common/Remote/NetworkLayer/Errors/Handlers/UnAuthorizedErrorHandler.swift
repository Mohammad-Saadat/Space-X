//
//  UnAuthorizedErrorHandler.swift
//  MockFlash
//
//  Created by Ali Motevali on 2/26/20.
//  Copyright © 2020 RoundTableApps. All rights reserved.
//

import Foundation

class UnAuthorizedErrorHandler: ErrorHandlerProtocol {
    let error: GeneralErrors
    
    init(error: GeneralErrors) {
        self.error = error
    }
    
    func handleError() {
        guard case GeneralErrors.unAuthorized(messages: _) = error else { return }
        removeLocalCredentials()
        WindowManager.shared.changeRootToSplash()
    }
    
    func removeLocalCredentials() {
        self.resetUserDefaults()
    }
    
    func resetUserDefaults() {}

}
