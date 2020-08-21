//
//  Session.swift
//  NetworkLayer
//
//  Created by linto jacob on 26/07/20.
//  Copyright © 2020 linto. All rights reserved.
//

import Foundation



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
                  errorHandler(ResponseSerializationFailureReason.jsonSerializationFailed(error: error))
                 
                  return
              }
        
              if self.isSuccessCode(urlResponse) {
                  guard let data = data else {
                      print("Unable to parse the response in given type \(T.self)")
                      return errorHandler(CustomError.genericError)
                  }
                  if let responseObject = try? JSONDecoder().decode(T.self, from: data) {
                       successHandler(responseObject)
                      return
                  }
              }
              errorHandler(CustomError.genericError)
          }
        
          guard let url = URL(string: url) else {
              return errorHandler(GeneralFailure.invalidURL)
          }

          guard let request = try? request.prepareRequest(toURL: url, parameters: parameters, httpMethod: method, headers: headers, timeoutInterval: 90) else {
              return errorHandler(GeneralFailure.failedToCreateHttpBody)
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
                errorHandler(ResponseSerializationFailureReason.jsonSerializationFailed(error: error))
                return
            }
      
            if self.isSuccessCode(urlResponse) {
                guard let data = data else {
                    print("Unable to parse the response in given type \(Result.self)")
                    return errorHandler(CustomError.genericError)
                }
                if let responseObject = try? JSONDecoder().decode(Result.self, from: data) {
                    successHandler(responseObject)
                    return
                }
            }
            errorHandler(CustomError.genericError)
        }

        guard let url = URL(string: url) else {
            return errorHandler(GeneralFailure.invalidURL)
        }

        var request = URLRequest(url: url)
            request.timeoutInterval = 90
            request.httpMethod = method.rawValue
            request.allHTTPHeaderFields = headers
            request.allHTTPHeaderFields?["Content-Type"] = "application/json"
        
      
    if parameters != nil{
         guard let data = try? JSONEncoder().encode(parameters) else {
             return errorHandler(GeneralFailure.failedToCreateHttpBody)
         }
         request.httpBody = data
    }
    
        URLSession.shared.dataTask(with: request, completionHandler: completionHandler).resume()
    }
    
    
    
    public func generalRequest(toURL url: String,
                        method: HTTPMethod = .get,
                        parameters: Parameters = [:],
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
                  
                  completion(.success(data))
                }
              
              completion(.failure(ResponseSerializationFailureReason.invalidEmptyResponse(type: "Response Failed")))
            }
          guard let url = URL(string: url) else {
              return completion(.failure(GeneralFailure.invalidURL))
          }
          
          guard let request = try? request.prepareRequest(toURL: url, parameters: parameters, httpMethod: method, headers: headers, timeoutInterval: 90) else {
              return completion(.failure(GeneralFailure.failedToCreateHttpBody))
          }
          
          URLSession.shared.dataTask(with: request, completionHandler: completionHandler).resume()
       
        
      }
      
    

}


extension Session{
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
