//
//  userModel.swift
//  store
//
//  Created by Mohamed Ali on 24/07/2023.
//

import Foundation

struct userResponse: Codable {
    let user: userModel
    let accessToken: String
}

struct userModel: Codable {
    let id: String
    let email: String
    let userType: userType
}

struct userType: Codable {
    let id: String
    let userType: String
}
