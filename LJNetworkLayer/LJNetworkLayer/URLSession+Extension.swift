//
//  URLSession+Extension.swift
//  NetworkLayer
//
//  Created by linto jacob on 24/08/20.
//  Copyright © 2020 linto. All rights reserved.
//

import Foundation

extension URLSession {
    func dataTask(with url: URL, result: @escaping (Result<(URLResponse, Data), Error>) -> Void) -> URLSessionDataTask {
    return dataTask(with: url) { (data, response, error) in
        if let error = error {
            result(.failure(error))
            return
        }
        guard let response = response, let data = data else {
            let error = NSError(domain: "error", code: 0, userInfo: nil)
            result(.failure(error))
            return
        }
        result(.success((response, data)))
    }
}
    
    ///Use
    /*
    URLSession.shared.dataTask(with: url) { (result) in
        switch result {
            case .success(let response, let data):
                // Handle Data and Response
                break
            case .failure(let error):
                // Handle Error
                break
         }
    }
    
    */
}

