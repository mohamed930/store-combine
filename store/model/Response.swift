//
//  Response.swift
//  store
//
//  Created by Mohamed Ali on 24/07/2023.
//

import Foundation

struct Response<T: Codable>: Codable {
    let data: T?
    let error: String?
    let isSuccess: Bool
    let statsCode: statusCodeModel
}


struct statusCodeModel: Codable {
    let description: String
    let value: Int
}
