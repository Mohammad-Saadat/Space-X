//
//  DetailFactory.swift
//  Space-X
//
//  Created by mohammadSaadat on 2/30/1400 AP.
//  Copyright (c) 1400 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

typealias DetailFactory = DetailViewControllerFactory & DetailServiceFactory

protocol DetailViewControllerFactory {
    func makeDetailViewController(launchId: String) -> DetailViewController
    func setup(viewController: DetailViewController)
}

protocol DetailServiceFactory {
    func makeDetailService() -> DetailService
}
