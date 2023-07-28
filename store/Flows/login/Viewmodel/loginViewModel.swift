//
//  loginViewModel.swift
//  store
//
//  Created by Mohamed Ali on 22/07/2023.
//

import Foundation
import Combine
import CoreLocation

class loginViewModel {
    var coordinator: loginCoordinator!
    
    // MARK: - Publishers variables.
    var userNameSubject = CurrentValueSubject<String,Never>("")
    var passwordSubject =  CurrentValueSubject<String,Never>("")
    var isloadingBehaviour = CurrentValueSubject<Bool,Never>(false)
    var emailVerififcation = CurrentValueSubject<Bool?,Never>(nil)
    
    var responseBehaviour = PassthroughSubject<Bool,Never>()
    
    let userapi = usersAPI()
    var locationManager: CLLocationManager!
    
    var cancallable = Set<AnyCancellable>()
    
    // MARK: - validation.
    var userNameObservalbe: AnyPublisher<Bool,Never> {
        return userNameSubject.map { userName -> Bool in
            if userName.trimmingCharacters(in: .whitespaces).isEmpty {
                return true
            }
            else {
                return !userName.isValidEmail()
            }
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
    
    func checkEmailValidation() {
        emailVerififcation.send(userNameSubject.value.isValidEmail())
    }
    
    
    func loginOperation() {
        isloadingBehaviour.send(true)
        
        let response = userapi.login(email: userNameSubject.value, password: passwordSubject.value, userPriviliage: .admin)
        
        response.sink(receiveCompletion: { [weak self] error in
            guard let self = self else { return }
            
            switch error {
            case .finished: break
            case .failure(let err):
                let e = err.userInfo[NSLocalizedDescriptionKey] as? String ?? ""
                print(e)
                responseBehaviour.send(false)
            }
        }, receiveValue: { [weak self] response in
            guard let self = self else { return }
            
            if response.isSuccess {
                isloadingBehaviour.send(false)
                guard let data = response.data else { return }
                
                responseBehaviour.send(true)
            }
            else {
                print(response.error ?? "")
                responseBehaviour.send(false)
            }
        }).store(in: &cancallable)
    }
    
    func configureCoreLocation(ob: CLLocationManagerDelegate) {
        locationManager = CLLocationManager()
        locationManager.delegate = ob
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
}
