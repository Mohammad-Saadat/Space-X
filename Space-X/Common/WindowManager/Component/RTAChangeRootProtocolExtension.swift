//
//  RTAChangeRootProtocolExtension.swift
//  RTACore
//
//  Created by Makan Taghizadeh on 11/7/18.
//

import UIKit

public extension RTAChangeRootProtocol where Self: UIViewController {
    var prefersChangeRootAnimated: Bool {
        return true
    }
    var preferredChangeRootTransitionStyle: RTAChangeRootTransitionStyle {
        return .fadeIn
    }
    var preferredChangeRootTransitionDuration: Double {
        return 0.7
    }
}
