//
//  usersNetworking.swift
//  store
//
//  Created by Mohamed Ali on 24/07/2023.
//

import Foundation
import Alamofire

enum usersNetworking {
    case login(email: String,password: String,userType: userPriviliage)
}

extension usersNetworking: TargetType {
    var baseURL: Api {
        return .baseUrl
    }
    
    var path: Api {
        switch self {
        case .login:
            return .login
        }
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    var task: Task {
        switch self {
            
        case .login(let email,let password,let userType):
            return .requestParameters(parameters: ["email": email,"password":password,"userType": userType.rawValue], encoding: JSONEncoding.prettyPrinted)
        }
    }
    
    var headers: [String : String]? {
        return [:]
    }
    
    
}
