//
//  Employee.swift
//  NetworkLayer
//
//  Created by linto jacob on 15/07/20.
//  Copyright © 2020 linto. All rights reserved.
//


import Foundation


struct User: Codable {
    let name: String
    let job: String
   
}


struct UserUpdate: Decodable {
    let name: String
    let job: String
    let updatedAt: String?
}

struct UserCreate: Decodable {
    let name: String?
    let job: String?
    let id: String?
    let createdAt: String?
}

struct Users: Decodable {
    let page : Int
    let per_page: Int
    let total: Int
    let total_pages: Int
    let data: [Userdetails]
    let ad : adDetails
}
struct Userdetails: Decodable {
    let id: Int
    let year: Int32
    let name: String
    let color: String
    let pantone_value: String
    
    
}

struct adDetails: Decodable {
    let company: String
    let url: String
    let text: String
}
