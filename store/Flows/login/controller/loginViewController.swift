//
//  loginViewController.swift
//  store
//
//  Created by Mohamed Ali on 22/07/2023.
//

import UIKit
import Combine
import ProgressHUD
import CoreLocation

class loginViewController: UIViewController {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userNameLine:UIView!
    @IBOutlet weak var userNameErrorMessageLabel:UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var loginviewmodel: loginViewModel!
    let padding: CGFloat = 40
    let color = images.blackColor.color
    var flag = true
    var cancallable = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureLocation()
        bindToTextField()
        bindToUserNameHasEndedType()
        subscribeToEnableButtonOrNot()
        subscribeToIsLoadingBehvaiour()
        subscribeToEmailVerification()
        subscribeToLoginResponse()
    }
    
    func configureUI() {
        userNameTextField.addPadding(amount: padding, PlaceHolder: myStrings.userName, Color: color)
        passwordTextField.addPadding(amount: padding, PlaceHolder: myStrings.password, Color: color)
    }
    
    func configureLocation() {
        loginviewmodel.configureCoreLocation(ob: self)
        
        let authorizationStatus = CLLocationManager.authorizationStatus()
        
        if authorizationStatus == .denied || authorizationStatus == .notDetermined {
            showAlert()
        }
    }
    
    // MARK: - Actions Buttons.
    @IBAction func showPassword(_ sender: Any) {
        flag = !flag
        passwordTextField.isSecureTextEntry = flag ? true : false
    }
    
    @IBAction func loginButtonAction (_ sender: Any) {
        passwordTextField.resignFirstResponder()
        loginviewmodel.loginOperation()
    }
    
    @IBAction func signupButtonAction(_ sender: Any) {
        loginviewmodel.goToSignupScreenOperation()
    }
    
    
    // MARK: - bind to CombineVariable.
    func bindToTextField() {
        userNameTextField.textPublisher().sink(receiveValue: { [weak self] userName in
            guard let self = self else { return }
            
            loginviewmodel.userNameSubject.send(userName)
        }).store(in: &cancallable)
        
        passwordTextField.textPublisher().sink(receiveValue: { [weak self] pass in
            guard let self = self else { return }
            
            loginviewmodel.passwordSubject.send(pass)
        }).store(in: &cancallable)
    }
    
    func bindToUserNameHasEndedType() {
        NotificationCenter.default.publisher(for: UITextField.textDidEndEditingNotification, object: userNameTextField)
           .sink { [weak self] _ in
               guard let self = self else { return }
               
               loginviewmodel.checkEmailValidation()
           }
           .store(in: &cancallable)
    }
    
    
    
    // MARK: - subscribe to isLoading or not.
    func subscribeToEnableButtonOrNot() {
        loginviewmodel.isButtonEnabled.sink(receiveValue: { [weak self] isEnabled in
            guard let self = self else { return }
            
            loginButton.setButtonDisabled(isEnabled)
        }).store(in: &cancallable)
    }
    
    func subscribeToIsLoadingBehvaiour() {
        loginviewmodel.isloadingBehaviour.sink { [weak self] isloading in
            guard let self = self else { return }
            
            if isloading {
                showLoading()
            }
            else {
                dismissLoading()
            }
            
        }.store(in: &cancallable)
    }
    
    func subscribeToEmailVerification() {
        loginviewmodel.emailVerififcation.sink(receiveValue: { [weak self] isValied in
            guard let self = self else { return }
            
            guard let isValied = isValied else { return }
            
            if isValied {
                userNameLine.backgroundColor = images.greenColor.color
                userNameErrorMessageLabel.visibility = .gone
            }
            else {
                userNameLine.backgroundColor = images.errorMessages.color
                userNameErrorMessageLabel.visibility = .visible
                userNameErrorMessageLabel.text = myStrings.emailVerificationError
            }
            
        }).store(in: &cancallable)
    }
    
    func subscribeToLoginResponse() {
        loginviewmodel.responseBehaviour.sink(receiveValue: { [weak self] isSuccess in
            guard let self = self else { return }
            
            if isSuccess {
                print("Sucess")
            }
            else {
                ProgressHUD.showError(myStrings.loginFailed)
                passwordTextField.text = ""
                passwordTextField.becomeFirstResponder()
            }
            
        }).store(in: &cancallable)
    }
    
    
    private func showAlert() {
        let alertController = UIAlertController (title: myStrings.errorTitle, message: myStrings.locationMessageAlert, preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: myStrings.settings, style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl)
            }
        })
        
        alertController.addAction(UIAlertAction(title: myStrings.cancel, style: .default, handler: nil))

        present(alertController, animated: true, completion: nil)
    }
}

extension loginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTextField {
            passwordTextField.becomeFirstResponder()
        }
        else {
            passwordTextField.resignFirstResponder()
            loginviewmodel.loginOperation()
        }
        
        return true
    }
}


extension loginViewController: CLLocationManagerDelegate {
    
    // MARK: - Write the didUpdateLocations method here:
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let l = locations[locations.count - 1]
        if l.horizontalAccuracy > 0 {
            
            print("Long = \(l.coordinate.longitude) latitude = \(l.coordinate.latitude)")
            
            // geo-refrence the location to address.
            l.placemark { [weak self] placemark, error in
                guard let self = self else { return }
                
                guard let placemark = placemark else {
                    print("Error:", error?.localizedDescription ?? "nil")
                    return
                }
                
                locationLabel.text = "\(placemark.streetNumber ?? "")\(placemark.streetName ?? ""),\(placemark.neighborhood ?? ""),\(placemark.county ?? "")"
                loginviewmodel.locationTitleBehaviour.send(locationLabel.text ?? myStrings.locationError)
            }
            
            loginviewmodel.locationManager.stopUpdatingLocation()
            loginviewmodel.locationManager.delegate = nil
        }
    }
        
    // MARK: - Write the didFailWithError method here:
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("F \(#line): \(error.localizedDescription)")
        locationLabel.text = myStrings.locationError
        showAlert()
       
    }
}
