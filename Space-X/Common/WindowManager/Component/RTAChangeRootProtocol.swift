//
//  RTAChangeRootProtocol.swift
//  RTACore
//
//  Created by Makan Taghizadeh on 11/7/18.
//

public protocol RTAChangeRootProtocol {
    /// Returns whether or not this view controller prefers animated change root
    var prefersChangeRootAnimated: Bool { get }
    /// Desired transition style for setting this view controller as root view controller
    var preferredChangeRootTransitionStyle: RTAChangeRootTransitionStyle { get }
    /// Desired duration time for setting this view controller as root view controller
    var preferredChangeRootTransitionDuration: Double { get }
}
