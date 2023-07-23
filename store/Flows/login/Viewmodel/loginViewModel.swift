//
//  loginViewModel.swift
//  store
//
//  Created by Mohamed Ali on 22/07/2023.
//

import Foundation
import Combine

class loginViewModel {
    var coordinator: loginCoordinator!
    
    // MARK: - Publishers variables.
    var userNameBehaviour = CurrentValueSubject<String,Never>("")
    var isloadingBehaviour = CurrentValueSubject<Bool,Never>(false)
    
    func startRequest() {
        isloadingBehaviour.send(true)
    }
    
    
}
