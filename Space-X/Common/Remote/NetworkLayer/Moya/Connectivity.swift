//
//  Connectivity.swift
//  TRB
//
//  Created by Ali Motevali on 8/2/20.
//  Copyright © 2020 RoundTableApps. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
