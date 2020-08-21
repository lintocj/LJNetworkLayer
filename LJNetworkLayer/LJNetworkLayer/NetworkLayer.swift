//
//  NetworkLayer.swift
//  lintoResume
//
//  Created by linto jacob on 14/07/20.
//  Copyright © 2020 linto. All rights reserved.
//

import Foundation
import UIKit

public typealias NetworkCompletionHandler = (Data?, URLResponse?, Error?) -> Void
public typealias ErrorHandler = (Error) -> Void
public typealias ErrorHandlerTest = (Error, Data?) -> Void



public typealias Parameters = [String: Any]
public typealias HTTHeader = [String: String]


public let LJ = NetworkLayer.default



public enum FinalResult {
      case success(Data)
      case failure(Error)
  }

final public class NetworkLayer: NSObject {
    static let genericError = "Something went wrong. Please try again later"
    
   
    public static let `default` = NetworkLayer()
    
    private let session = Session.default
    private let uploadFile = Upload.default
   
    

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
                      completion: @escaping (FinalResult) -> Void) {
        
        session.generalRequest(toURL: url, method: method, parameters: parameters, headers: headers, completion: completion)
      
    }
    
  
    
    
    func upload(files: [Upload.FileInfo], toURL url: URL, withHttpMethod httpMethod: HTTPMethod, completion: @escaping(_ result: Upload.Results, _ failedFiles: [String]?) -> Void) {
        uploadFile.upload(files: files, toURL: url, withHttpMethod: httpMethod, completion: completion)
    }
  
}



//extension NSMutableData {
//    func appendString(string: String) {
//        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
//        append(data!)
//    }
//}
