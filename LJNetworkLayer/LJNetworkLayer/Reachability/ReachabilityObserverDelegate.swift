//
//  ReachabilityObserverDelegate.swift
//  NetworkLayer
//
//  Created by Linto Jacob on 27/08/20.
//  Copyright © 2020 linto. All rights reserved.
//


import Foundation


//Reachability
//declare this property where it won't go out of scope relative to your listener
fileprivate var reachability: Reachability!

public protocol ReachabilityActionDelegate {
    func reachabilityChanged(_ isReachable: Bool)
}

public protocol ReachabilityObserverDelegate: AnyObject, ReachabilityActionDelegate {
    func addReachabilityObserver() throws
    func removeReachabilityObserver()
}

// Declaring default implementation of adding/removing observer
public extension ReachabilityObserverDelegate {
    
    /** Subscribe on reachability changing */
    func addReachabilityObserver() throws {
        reachability = try Reachability()
        
        reachability.whenReachable = { [weak self] reachability in
            self?.reachabilityChanged(true)
        }
        
        reachability.whenUnreachable = { [weak self] reachability in
            self?.reachabilityChanged(false)
        }
        
        try reachability.startNotifier()
    }
    
    /** Unsubscribe */
    func removeReachabilityObserver() {
        reachability.stopNotifier()
        reachability = nil
    }
}
