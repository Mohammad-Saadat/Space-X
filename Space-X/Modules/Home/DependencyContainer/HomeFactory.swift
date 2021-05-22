//
//  HomeFactory.swift
//  Space-X
//
//  Created by mohammad on 5/18/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

typealias HomeFactory = HomeViewControllerFactory & HomeServiceFactory

protocol HomeViewControllerFactory {
    func makeHomeViewController() -> HomeViewController
    func setup(viewController: HomeViewController)
}

protocol HomeServiceFactory {
    func makeHomeService() -> HomeService
    func getNetworkStatusListerner() -> NetworkStateNotifier
}
