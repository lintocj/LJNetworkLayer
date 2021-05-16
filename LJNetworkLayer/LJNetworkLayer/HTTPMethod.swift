//
//  HTTPHeader.swift
//  NetworkLayer
//  Linto Jacob
//  Email: lintojacob2009@gmail.com
//  Created by linto jacob on 25/08/20..
//  Copyright © 2020 linto. All rights reserved.
//

import Foundation

/// An order-preserving and case-insensitive representation of HTTP headers.
public struct HTTPMethod: RawRepresentable, Equatable, Hashable {
    /// `CONNECT` method.
    public static let connect = HTTPMethod(rawValue: "CONNECT")
    /// `DELETE` method.
    public static let delete = HTTPMethod(rawValue: "DELETE")
    /// `GET` method.
    public static let get = HTTPMethod(rawValue: "GET")
    /// `HEAD` method.
    public static let head = HTTPMethod(rawValue: "HEAD")
    /// `OPTIONS` method.
    public static let options = HTTPMethod(rawValue: "OPTIONS")
    /// `PATCH` method.
    public static let patch = HTTPMethod(rawValue: "PATCH")
    /// `POST` method.
    public static let post = HTTPMethod(rawValue: "POST")
    /// `PUT` method.
    public static let put = HTTPMethod(rawValue: "PUT")
    /// `TRACE` method.
    public static let trace = HTTPMethod(rawValue: "TRACE")
    /// `UPDATE` method.
    public static let update = HTTPMethod(rawValue: "UPDATE")

    public let rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}
