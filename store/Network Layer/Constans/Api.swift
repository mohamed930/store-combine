//
//  urls.swift
//  store
//
//  Created by Mohamed Ali on 24/07/2023.
//

import Foundation

enum userPriviliage: String {
    case user
    case admin
    case seller
}

enum Api: String {
    case baseUrl = "https://free.bluethunder.site/"
    case login = "user/login"
}
