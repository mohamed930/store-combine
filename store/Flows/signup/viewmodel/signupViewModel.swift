//
//  signupViewModel.swift
//  store
//
//  Created by Mohamed Ali on 28/07/2023.
//

import Foundation
import Combine

class signupViewModel {
    var coordinator: signupCoordinator!
    
    var locationString: String!
    
    func moveToLoginScreenOperation() {
        coordinator.goToLoginScreen()
    }
}
