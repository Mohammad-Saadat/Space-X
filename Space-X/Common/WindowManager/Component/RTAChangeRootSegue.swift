//
//  RTAChangeRootSegue.swift
//  RTACore
//
//  Created by Mohammad Ali Jafarian on 3/2/18.
//  Copyright © 2018 Behzad Ardehei. All rights reserved.
//
import UIKit

open class RTAChangeRootSegue: UIStoryboardSegue {
    override open func perform() {
        guard let destination = destination as? (UIViewController & RTAChangeRootProtocol) else {
            fatalError("View controller \(self.destination) does not conform to protocol \"RTAChangeRootProtocol\"")
        }
        UIApplication.shared.keyWindow?.changeRootViewController(to: destination)
    }
}
