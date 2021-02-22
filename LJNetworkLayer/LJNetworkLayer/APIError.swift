//
//  APIError.swift
//  TouchnetOne
//
//  Created by Robin Johnson on 09/12/20.
//  Copyright © 2020 Robin JR. All rights reserved.
//

import Foundation

enum ResponseStatusCode : String{
    case sessionExpired = "-2102"
    case success = "200"
}
let defaultStatus = "OK"
let defaultErrorMessage = AlertMessages.Something_went_wrong
struct APIError {
    var status : String
    var errorCode  :String
    var errorMessage : String
    init(status:String?,errorMessage:String?,errorCode:String?) {
        self.status = status ?? "OK"
        self.errorMessage = errorMessage ?? defaultErrorMessage
        self.errorCode = errorCode ?? ResponseStatusCode.success.rawValue
    }
    init(dicData:[String:Any]) {
        self.status = dicData["Status"] as? String ?? defaultStatus
        let responseStatus = dicData["ResponseStatus"] as? [String:Any]
        self.errorCode = responseStatus?["ErrorCode"] as? String ?? ResponseStatusCode.success.rawValue
        self.errorMessage = responseStatus?["Message"] as? String ?? defaultErrorMessage
    }
    func isSessionExpired()->Bool{
        return status != "OK" && errorCode == ResponseStatusCode.sessionExpired.rawValue
    }
}
