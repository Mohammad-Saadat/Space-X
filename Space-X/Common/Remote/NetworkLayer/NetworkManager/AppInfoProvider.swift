//
//  AppInfoProvider.swift
//  SHFTHeroV2
//
//  Created by Mahsa on 5/20/20.
//  Copyright © 2020 RoundTableApps. All rights reserved.
//

import Foundation

protocol AppInfoProviderProtocol {
    var apiKey: String? {get}
    var appVersion: String? {get}
}
