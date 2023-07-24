//
//  usersAPI.swift
//  store
//
//  Created by Mohamed Ali on 24/07/2023.
//

import Foundation
import Combine

class usersAPI: BaseAPI<usersNetworking> {
    
    func login(email: String,password: String,userPriviliage: userPriviliage) -> Future<Response<userResponse>,NSError> {
        self.requestPublisher(Target: .login(email: email, password: password, userType: userPriviliage), ClassName: Response<userResponse>.self)
    }
}
