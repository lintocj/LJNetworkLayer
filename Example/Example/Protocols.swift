//
//  Protocols.swift
//  NetworkLayer
//
//  Created by linto jacob on 15/07/20.
//  Copyright © 2020 linto. All rights reserved.
//

import Foundation

protocol ViewProtocol: AnyObject {
    func displayUsers<T>(output: T)
    func displayError<T>(error: T)
}
