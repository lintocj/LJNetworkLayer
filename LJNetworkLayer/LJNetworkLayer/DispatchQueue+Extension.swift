//
//  DispatchQueue+Extension.swift
//  NetworkLayer
//
//  Created by linto jacob on 24/08/20.
//  Copyright © 2020 linto. All rights reserved.
//

import Dispatch
import Foundation

extension DispatchQueue {
    /// Execute the provided closure after a `TimeInterval`.
    ///
    /// - Parameters:
    ///   - delay:   `TimeInterval` to delay execution.
    ///   - closure: Closure to execute.
    func after(_ delay: TimeInterval, execute closure: @escaping () -> Void) {
        asyncAfter(deadline: .now() + delay, execute: closure)
    }
}
