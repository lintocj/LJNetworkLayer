//
//  Request.swift
//  NetworkLayer
//
//  Created by linto jacob on 26/07/20.
//  Copyright © 2020 linto. All rights reserved.
//

import Foundation

public class Request {

    
    
    func prepareRequest(toURL url: URL,
                                   parameters: Parameters = [:],
                                   httpMethod: HTTPMethod = .get,
                                   headers: HTTHeader = [:],
                                   timeoutInterval: TimeInterval = 90) throws -> URLRequest?{
           
           var request = URLRequest(url: url)
           request.httpMethod = httpMethod.rawValue
           request.timeoutInterval = timeoutInterval
           request.allHTTPHeaderFields = headers
          
            if parameters.count > 0{
           guard let data = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
               
               throw CustomError.failedToCreateHttpBody
           }
            request.httpBody = data
          }
           return request
       }
    
}
