//
//  Session.swift
//  NetworkLayer
//  Linto Jacob
//  Email: lintojacob2009@gmail.com
//  Created by linto jacob on 24/08/20.
//  Copyright © 2020 linto. All rights reserved.
//

import UIKit

let apiTimeOutInterval = 20
let fileOperationTimeOutInterval = 60

open class Session {
    public static let `default` = Session()
    
    let request = Request()
    
    public func request<T: Decodable>(toURL url: String,
                                      method: HTTPMethod = .get,
                                      parameters: Parameters = [:],
                                      headers: HTTHeader = [:],
                                      successHandler: @escaping (T) -> Void,
                                      errorHandler: @escaping ErrorHandler) {
        let completionHandler: NetworkCompletionHandler = { (data, urlResponse, error) in
            if let error = error {
                print(error.localizedDescription)
                errorHandler(ResponseSerializationFailureReason.jsonSerializationFailed(error: error),nil)
                
                return
            }
            
            if self.isSuccessCode(urlResponse) {
                guard let data = data else {
                    print("Unable to parse the response in given type \(T.self)")
                    return errorHandler(CustomError.genericError,nil)
                }
                if let responseObject = try? JSONDecoder().decode(T.self, from: data) {
                    successHandler(responseObject)
                    return
                }
            }else{
                do{
                    guard let data = data else {
                        print("Unable to parse the response in given type \(T.self)")
                        return errorHandler(CustomError.genericError,[:])
                    }
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    return errorHandler(nil,json)
                }
                catch{
                    return errorHandler(error,nil)
                }
                
            }
            errorHandler(CustomError.genericError,nil)
        }
        
        guard let url = URL(string: url) else {
            return errorHandler(GeneralFailure.invalidURL,nil)
        }
        
        guard let request = try? request.prepareRequest(toURL: url, parameters: parameters, httpMethod: method, headers: headers, timeoutInterval: TimeInterval(apiTimeOutInterval)) else {
            return errorHandler(GeneralFailure.failedToCreateHttpBody,nil)
        }
        
        
        URLSession.shared.dataTask(with: request, completionHandler: completionHandler).resume()
        
        
    }
    
    public func requestWithFormData<T: Decodable>(toURL url: String,
                                                  method: HTTPMethod = .get,
                                                  parameters: Parameters = [:],
                                                  headers: HTTHeader = [:],
                                                  successHandler: @escaping (T) -> Void,
                                                  errorHandler: @escaping ErrorHandler) {
        let completionHandler: NetworkCompletionHandler = { (data, urlResponse, error) in
            if let error = error {
                print(error.localizedDescription)
                errorHandler(ResponseSerializationFailureReason.jsonSerializationFailed(error: error),nil)
                
                return
            }
            
            if self.isSuccessCode(urlResponse) {
                guard let data = data else {
                    print("Unable to parse the response in given type \(T.self)")
                    return errorHandler(CustomError.genericError,nil)
                }
                if let responseObject = try? JSONDecoder().decode(T.self, from: data) {
                    successHandler(responseObject)
                    return
                }
            }else{
                do{
                    guard let data = data else {
                        print("Unable to parse the response in given type \(T.self)")
                        return errorHandler(CustomError.genericError,[:])
                    }
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    return errorHandler(nil,json)
                }
                catch{
                    return errorHandler(error,nil)
                }
                
            }
            errorHandler(CustomError.genericError,nil)
        }
        
        guard let url = URL(string: url) else {
            return errorHandler(GeneralFailure.invalidURL,nil)
        }
        
        guard let request = try? request.prepareRequestFormData(toURL: url, parameters: parameters, httpMethod: method, headers: headers, timeoutInterval: TimeInterval(apiTimeOutInterval)) else {
            return errorHandler(GeneralFailure.failedToCreateHttpBody,nil)
        }
        
        
        URLSession.shared.dataTask(with: request, completionHandler: completionHandler).resume()
        
        
    }
    
    
    
    
    public func requestEncode<Result: Decodable, Parameters: Encodable>(toURL url: String,
                                                                        method: HTTPMethod = .get,
                                                                        parameters: Parameters? = nil,
                                                                        headers: HTTHeader = [:],
                                                                        successHandler: @escaping (Result) -> Void,
                                                                        errorHandler: @escaping ErrorHandler) {
        
        let completionHandler: NetworkCompletionHandler = { (data, urlResponse, error) in
            if let error = error {
                print(error.localizedDescription)
                errorHandler(ResponseSerializationFailureReason.jsonSerializationFailed(error: error),nil)
                return
            }
            
            if self.isSuccessCode(urlResponse) {
                guard let data = data else {
                    print("Unable to parse the response in given type \(Result.self)")
                    return errorHandler(CustomError.genericError,nil)
                }
                if let responseObject = try? JSONDecoder().decode(Result.self, from: data) {
                    successHandler(responseObject)
                    return
                }
                
            }else{
                do{
                    guard let data = data else {
                        return errorHandler(CustomError.genericError,nil)
                    }
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    errorHandler(nil,json)
                }catch{
                    errorHandler(error,nil)
                }
            }
        }
        
        guard let url = URL(string: url) else {
            return errorHandler(GeneralFailure.invalidURL,nil)
        }
        
        var request = URLRequest(url: url)
        request.timeoutInterval = TimeInterval(apiTimeOutInterval)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.allHTTPHeaderFields?["Content-Type"] = "application/json"
        
        if parameters != nil{
            guard let data = try? JSONEncoder().encode(parameters) else {
                return errorHandler(GeneralFailure.failedToCreateHttpBody,nil)
            }
            request.httpBody = data
        }
        
        URLSession.shared.dataTask(with: request, completionHandler: completionHandler).resume()
    }
    

    
    public func generalRequest(toURL url: String,
                               method: HTTPMethod = .get,
                               parameters: Parameters = [:],
                               headers: HTTHeader = [:],
                               completion: @escaping (FinalResult) -> Void, errorHandler: @escaping ErrorHandler) {
        
        let completionHandler: NetworkCompletionHandler = { (data, urlResponse, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(ResponseSerializationFailureReason.decodingFailed(error: error)))
                return
            }
            
            if self.isSuccessCode(urlResponse) {
                guard let data = data else {
                    print("Unable to parse the response in given type")
                    return errorHandler(CustomError.genericError,nil)
                }
                let str = String(decoding: data, as: UTF8.self)
                
                var dictonary:NSDictionary?
                
                if let data = str.data(using: String.Encoding.utf8) {
                    
                    do {
                        dictonary = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
                        
                        if let myDictionary = dictonary
                        {
                            // print(" First name is: \(myDictionary["first_name"]!)")
                            print("RESPONSE STRING",myDictionary)
                            completion(.success(myDictionary))
                            //completion(.success(myDictionary))
                            
                        }
                    } catch let error as NSError {
                        print(error)
                        errorHandler(error,nil)
                    }
                }
                
            }else{
                errorHandler(CustomError.genericError,nil)
            }
            
            
        }
        guard let url = URL(string: url) else {
            return completion(.failure(GeneralFailure.invalidURL))
        }
        
        guard let request = try? request.prepareRequest(toURL: url, parameters: parameters, httpMethod: method, headers: headers, timeoutInterval: TimeInterval(apiTimeOutInterval)) else {
            return completion(.failure(GeneralFailure.failedToCreateHttpBody))
        }
        
        URLSession.shared.dataTask(with: request, completionHandler: completionHandler).resume()
        
        
    }
    
    public func generalRequestWithFormData(toURL url: String,
                                           method: HTTPMethod = .get,
                                           parameters: Parameters = [:],
                                           headers: HTTHeader = [:],
                                           completion: @escaping (FinalResult) -> Void, errorHandler: @escaping ErrorHandler) {
        
        let completionHandler: NetworkCompletionHandler = { (data, urlResponse, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(ResponseSerializationFailureReason.decodingFailed(error: error)))
                return
            }
            
            if self.isSuccessCode(urlResponse) {
                guard let data = data else {
                    print("Unable to parse the response in given type")
                    return errorHandler(CustomError.genericError,nil)
                }
                let str = String(decoding: data, as: UTF8.self)
                
                var dictonary:NSDictionary?
                
                if let data = str.data(using: String.Encoding.utf8) {
                    
                    do {
                        dictonary = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
                        
                        if let myDictionary = dictonary
                        {
                            // print(" First name is: \(myDictionary["first_name"]!)")
                            print("RESPONSE STRING",myDictionary)
                            completion(.success(myDictionary))
                            //completion(.success(myDictionary))
                            
                        }
                    } catch let error as NSError {
                        print(error)
                        errorHandler(error,nil)
                    }
                }
                
            }else{
                errorHandler(CustomError.genericError,nil)
            }
            
            
        }
        guard let url = URL(string: url) else {
            return completion(.failure(GeneralFailure.invalidURL))
        }
        
        guard let request = try? request.prepareRequestFormData(toURL: url, parameters: parameters, httpMethod: method, headers: headers, timeoutInterval: TimeInterval(apiTimeOutInterval)) else {
            return completion(.failure(GeneralFailure.failedToCreateHttpBody))
        }
        
        URLSession.shared.dataTask(with: request, completionHandler: completionHandler).resume()
        
        
    }
    
    public func generalRequestEncode<Parameters: Encodable>(toURL url: String,
                                                            method: HTTPMethod = .get,
                                                            parameters: Parameters? = nil,
                                                            headers: HTTHeader = [:],
                                                            completion: @escaping (FinalResult) -> Void) {
        
        let completionHandler: NetworkCompletionHandler = { (data, urlResponse, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(ResponseSerializationFailureReason.decodingFailed(error: error)))
                return
            }
            
            if self.isSuccessCode(urlResponse) {
                guard let data = data else {
                    print("Unable to parse the response in given type")
                    return completion(.failure(ResponseSerializationFailureReason.inputDataNilOrZeroLength))
                }
                
                let str = String(decoding: data, as: UTF8.self)
                
                var dictonary:NSDictionary?
                
                if let data = str.data(using: String.Encoding.utf8) {
                    
                    do {
                        dictonary = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
                        
                        if let myDictionary = dictonary
                        {
                            // print(" First name is: \(myDictionary["first_name"]!)")
                            // print("RESPONSE STRING",myDictionary)
                            completion(.success(myDictionary))
                            
                            
                        }
                    } catch let error as NSError {
                        print(error)
                    }
                }
                
                
            }
            
            completion(.failure(ResponseSerializationFailureReason.invalidEmptyResponse(type: "Response Failed")))
        }
        guard let url = URL(string: url) else {
            return completion(.failure(GeneralFailure.invalidURL))
        }
        
        guard let request = try? request.prepareRequestEncode(toURL: url, parameters: parameters, httpMethod: method, headers: headers, timeoutInterval: TimeInterval(apiTimeOutInterval)) else {
            return completion(.failure(GeneralFailure.failedToCreateHttpBody))
        }
        
        URLSession.shared.dataTask(with: request, completionHandler: completionHandler).resume()
        
        
    }
}


extension Session {
    private func isSuccessCode(_ statusCode: Int) -> Bool {
        return statusCode >= 200 && statusCode < 300
    }
    
    private func isSuccessCode(_ response: URLResponse?) -> Bool {
        guard let urlResponse = response as? HTTPURLResponse else {
            return false
        }
        return isSuccessCode(urlResponse.statusCode)
    }
}
