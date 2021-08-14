//
//  DependencyContainer.swift
//  Space-X
//
//  Created by mohammad on 5/18/21.
//

import Foundation

public class DependencyContainer {
    lazy var networkManager: NetworkManagerProtocol = AppDelegate.getInstance().networkManager
    lazy var networkStateNotifier = AppDelegate.getInstance().networkStateNotifier
}

extension DependencyContainer { }
