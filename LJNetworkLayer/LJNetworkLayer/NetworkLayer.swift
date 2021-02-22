//
//  NetworkLayer.swift
//  lintoResume
//
//  Created by linto jacob on 24/08/20.
//  Copyright © 2020 linto. All rights reserved.
//

import Foundation
import UIKit

public typealias NetworkCompletionHandler = (Data?, URLResponse?, Error?) -> Void
public typealias ErrorHandler = (Error?, [String: Any]?) -> Void




public typealias Parameters = [String: Any]
public typealias HTTHeader = [String: String]


public let NL = NetworkLayer.default


public enum FinalResult {
      case success(NSDictionary)
      case failure(Error)
  }

final public class NetworkLayer: NSObject {
    static let genericError = "Something went wrong. Please try again later"
    
   
    public static let `default` = NetworkLayer()
    
    private let session = Session.default
    public let uploadFile = Upload.default
   
    

    private var backgroundSession: URLSession!


     public func request<T: Decodable>(toURL url: String,
                                method: HTTPMethod = .get,
                                parameters: Parameters = [:],
                                headers: HTTHeader = [:],
                                successHandler: @escaping (T) -> Void,
                                errorHandler: @escaping ErrorHandler) {
        session.request(toURL: url, method: method, parameters: parameters, headers: headers, successHandler: successHandler, errorHandler: errorHandler)
     
    }
   
      
    
    
    
     public func requestEncode<Result: Decodable, Parameters: Encodable>(toURL url: String,
                                    method: HTTPMethod = .get,
                                    parameters: Parameters? = nil,
                                    headers: HTTHeader = [:],
                                    successHandler: @escaping (Result) -> Void,
                                    errorHandler: @escaping ErrorHandler) {

        session.requestEncode(toURL: url, method: method, parameters: parameters, headers: headers, successHandler: successHandler, errorHandler: errorHandler)
        }
        
     
    
    public func generalRequest(toURL url: String,
                      method: HTTPMethod = .get,
                      parameters: Parameters = [:],
                      headers: HTTHeader = [:],
                      completion: @escaping (FinalResult) -> Void,errorHandler: @escaping ErrorHandler) {
        
        session.generalRequest(toURL: url, method: method, parameters: parameters, headers: headers, completion: completion, errorHandler: errorHandler)
      
    }
    
    public func generalRequestEncode<Parameters: Encodable>(toURL url: String,
                      method: HTTPMethod = .get,
                      parameters: Parameters? = nil,
                      headers: HTTHeader = [:],
                      completion: @escaping (FinalResult) -> Void) {
        
        session.generalRequestEncode(toURL: url, method: method, parameters: parameters, headers: headers, completion: completion)
      
    }
    
    
    
    public func upload(files: [Upload.FileInfo], toURL url: URL, withHttpMethod httpMethod: HTTPMethod, devKey: String,completion: @escaping(_ result: Upload.Results, _ failedFiles: [String]?) -> Void) {
        uploadFile.upload(files: files, toURL: url, withHttpMethod: httpMethod, devKey: devKey, completion: completion)
    }
  
}



//extension NSMutableData {
//    func appendString(string: String) {
//        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
//        append(data!)
//    }
//}
