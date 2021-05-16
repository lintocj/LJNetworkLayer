//
//  NetworkLayer.swift
//  Linto Jacob
//  Email: lintojacob2009@gmail.com
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



public enum FinalResult {
      case success(NSDictionary)
      case failure(Error)
  }

public enum CompletionHandler {
      case success(UIImageView)
      case failure(Error)
}

let genericError = "Something went wrong. Please try again later"

public let LJImageCacheConfig = ImageCacheFromURL.default

public enum LJ{
    public static func request<T: Decodable>(toURL url: String,
                               method: HTTPMethod = .get,
                               parameters: Parameters = [:],
                               headers: HTTHeader = [:],
                               successHandler: @escaping (T) -> Void,
                               errorHandler: @escaping ErrorHandler) {
        Session.default.request(toURL: url, method: method, parameters: parameters, headers: headers, successHandler: successHandler, errorHandler: errorHandler)
    
   }
  
     
   
   
   
    public static func requestEncode<Result: Decodable, Parameters: Encodable>(toURL url: String,
                                   method: HTTPMethod = .get,
                                   parameters: Parameters? = nil,
                                   headers: HTTHeader = [:],
                                   successHandler: @escaping (Result) -> Void,
                                   errorHandler: @escaping ErrorHandler) {

        Session.default.requestEncode(toURL: url, method: method, parameters: parameters, headers: headers, successHandler: successHandler, errorHandler: errorHandler)
       }
       
    
   
   public static func generalRequest(toURL url: String,
                     method: HTTPMethod = .get,
                     parameters: Parameters = [:],
                     headers: HTTHeader = [:],
                     completion: @escaping (FinalResult) -> Void,errorHandler: @escaping ErrorHandler) {
       
    Session.default.generalRequest(toURL: url, method: method, parameters: parameters, headers: headers, completion: completion, errorHandler: errorHandler)
     
   }
   
   public static func generalRequestEncode<Parameters: Encodable>(toURL url: String,
                     method: HTTPMethod = .get,
                     parameters: Parameters? = nil,
                     headers: HTTHeader = [:],
                     completion: @escaping (FinalResult) -> Void) {
       
    Session.default.generalRequestEncode(toURL: url, method: method, parameters: parameters, headers: headers, completion: completion)
     
   }
   
   
   
   public static func upload(files: [Upload.FileInfo], toURL url: URL, withHttpMethod httpMethod: HTTPMethod, devKey: String,completion: @escaping(_ result: Upload.Results, _ failedFiles: [String]?) -> Void) {
    Upload.default.upload(files: files, toURL: url, withHttpMethod: httpMethod, devKey: devKey, completion: completion)
   }
    
    
    public static func loadImageUsingCache(imageFile : UIImageView,withUrl urlString : String, completion: @escaping (CompletionHandler) -> Void){
        ImageCacheFromURL.default.loadImageUsingCache(imageFile: imageFile, withUrl: urlString, completion: completion)
    }
 
}

