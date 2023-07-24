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
    var userNameSubject: CurrentValueSubject<String, Never>!
    var passwordSubject: CurrentValueSubject<String, Never>!
    var isloadingBehaviour = CurrentValueSubject<Bool,Never>(false)
    
    // MARK: - validation.
    var userNameObservalbe: AnyPublisher<Bool,Never> {
        return userNameSubject.map { userName -> Bool in
            let isEmpty = userName.trimmingCharacters(in: .whitespaces).isEmpty
            return isEmpty
        }
        .eraseToAnyPublisher()
    }

    var passwordObservalbe: AnyPublisher<Bool,Never> {
        return passwordSubject.map { password -> Bool in
            let isEmpty = password.trimmingCharacters(in: .whitespaces).isEmpty

            return isEmpty
        }
        .eraseToAnyPublisher()
    }

    var isButtonEnabled: AnyPublisher<Bool,Never> {
        return Publishers.CombineLatest(userNameObservalbe, passwordObservalbe).map { email,password in
            let buttonEnabled = !email && !password

            return buttonEnabled
        }
        .eraseToAnyPublisher()
    }
    
    func startRequest() {
        isloadingBehaviour.send(true)
    }
    
}
