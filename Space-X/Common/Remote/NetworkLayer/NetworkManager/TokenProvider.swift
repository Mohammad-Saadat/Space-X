//
//  TokenProvider.swift
//  SHFTHeroV2
//
//  Created by Mahsa on 5/20/20.
//  Copyright © 2020 RoundTableApps. All rights reserved.
//

import Foundation
import PromiseKit

protocol TokenProviderProtocol {
    func fetchToken() -> String
}
