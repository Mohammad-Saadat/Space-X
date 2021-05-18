//
//  AppDelegate.swift
//  Space-X
//
//  Created by mohammad on 5/18/21.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    lazy var networkManager = NetworkManagerFactory().createNetworkManager()
//    lazy var webSocketManager: WebSocketManager = WebSocketManager(userManager: userManager)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

}

// ===============
// MARK: - Methods
// ===============
extension AppDelegate {
    class func getInstance() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate // swiftlint:disable:this force_cast
    }
}
