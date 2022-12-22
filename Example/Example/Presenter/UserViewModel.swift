//
//  Presenter.swift
//  NetworkLayer
//
//  Created by linto jacob on 15/07/20.
//  Copyright © 2020 linto. All rights reserved.
//

import Foundation
import LJNetworkLayer

class UserViewModel {
    
    var view: ViewProtocol?
    
    init(dataSource: ViewProtocol) {
        self.view = dataSource
        
    }
    
    func getExample() {
        let successHandler: (Users) -> Void = { (users) in
            print(users)
            self.view?.displayUsers(output: users)
        }

        let errorHandler: (Error?, [String: Any]?) -> Void = { (error, errorData)  in
            self.view?.displayError(error: error)
        }

        LJ.request(toURL: "https://reqres.in/api/unknown",
                   successHandler: successHandler,
                   errorHandler: errorHandler)
    }
    
    func postExample() {
        let errorHandler: (Error?, [String: Any]?) -> Void = { (error, errorData)  in
            self.view?.displayError(error: error)
        }

        let successHandler: (UserCreate) -> Void = { (users) in
            print(users)
            self.view?.displayUsers(output: users)
        }
        
        let para: Parameters = ["email": "peter@klaven"]
        let header: HTTHeader = [
            "Content-Type": "application/json",
        ]

        LJ.request(toURL: "https://reqres.in/api/login",
                   method: .post,
                   parameters: para,
                   headers: header,
                   successHandler: successHandler,
                   errorHandler: errorHandler)
    }
    
    
    func postExampleWithEncode() {
        let errorHandler: (Error?, [String: Any]?) -> Void = { (error, errorData)  in
            self.view?.displayError(error: error)
        }

        let successHandler: (UserUpdate) -> Void = { (users) in
            print(users)
            self.view?.displayUsers(output: users)
        }
        
        let emp1 = User(name: "morpheus", job: "zion resident")
        
        LJ.requestEncode(toURL: "https://reqres.in/api/users/2",
                         method: .put,
                         parameters: emp1,
                         successHandler: successHandler,
                         errorHandler: errorHandler)
    }
}
