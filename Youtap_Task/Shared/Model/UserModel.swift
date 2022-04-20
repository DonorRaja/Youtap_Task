//
//  UserModel.swift
//  Youtap_Task
//
//  Created by DonorRaja on 20/04/22.
//

import Foundation


struct User: Codable, Identifiable {
    var id: Int
    var name: String
    var email: String
    var phone: String
    var username: String
    var website: String
    var address: Address
    var company: Company
    
    
}

struct Address: Codable {
    var street: String
    var suite: String
    var city: String
    var zipcode: String
    var geo: Geo
    
}


struct Company: Codable {
    var name: String
    var catchPhrase: String
    var bs: String
    
}

struct Geo: Codable {
    var lat: String
    var lng: String
}

