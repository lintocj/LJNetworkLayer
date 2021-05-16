//
//  Request.swift
//  NetworkLayer
//  Linto Jacob
//  Email: lintojacob2009@gmail.com
//  Created by linto jacob on 25/08/20.
//  Copyright © 2020 linto. All rights reserved.
//

import Foundation

public class Request {
    
    
    
    func prepareRequest(toURL url: URL,
                        parameters: Parameters = [:],
                        httpMethod: HTTPMethod = .get,
                        headers: HTTHeader = [:],
                        timeoutInterval: TimeInterval = TimeInterval(apiTimeOutInterval)) throws -> URLRequest?{
        
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
    func prepareRequestEncode<Parameters: Encodable>(toURL url: URL,
                                                     parameters: Parameters? = nil,
                                                     httpMethod: HTTPMethod = .get,
                                                     headers: HTTHeader = [:],
                                                     timeoutInterval: TimeInterval = TimeInterval(apiTimeOutInterval)) throws -> URLRequest?{
        
        var request = URLRequest(url: url)
        request.timeoutInterval = TimeInterval(apiTimeOutInterval)
        request.httpMethod = httpMethod.rawValue
        request.allHTTPHeaderFields = headers
        request.allHTTPHeaderFields?["Content-Type"] = "application/json"
        
        
        if parameters != nil{
            guard let data = try? JSONEncoder().encode(parameters) else {
                throw CustomError.failedToCreateHttpBody
            }
            request.httpBody = data
        }
        return request
    }
    
    func getPostString(params:[String:Any]) -> String
    {
        var data = [String]()
        for(key, value) in params
        {
            data.append(key + "=\(value)")
        }
        return data.map { String($0) }.joined(separator: "&")
    }
    
    func prepareRequestFormData(toURL url: URL,
                                parameters: Parameters = [:],
                                httpMethod: HTTPMethod = .get,
                                headers: HTTHeader = [:],
                                timeoutInterval: TimeInterval = TimeInterval(apiTimeOutInterval)) throws -> URLRequest?{
        
        var request = URLRequest(url: url)
        
        
        request.httpMethod = httpMethod.rawValue
        request.timeoutInterval = timeoutInterval
        request.allHTTPHeaderFields = headers
        
        if parameters.count > 0{
            let postString = self.getPostString(params: parameters)
            request.httpBody = postString.data(using: .utf8)
        }
        return request
    }
    
}






