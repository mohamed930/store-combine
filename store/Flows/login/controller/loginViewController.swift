//
//  loginViewController.swift
//  store
//
//  Created by Mohamed Ali on 22/07/2023.
//

import UIKit
import Combine
import ProgressHUD

class loginViewController: UIViewController {
    
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
    
    @IBAction func showPassword(_ sender: Any) {
        flag = !flag
        passwordTextField.isSecureTextEntry = flag ? true : false
    }
    
    @IBAction func loginButtonAction (_ sender: Any) {
        passwordTextField.resignFirstResponder()
        loginviewmodel.loginOperation()
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
    
    func subscribeToEnableButtonOrNot() {
        loginviewmodel.isButtonEnabled.sink(receiveValue: { [weak self] isEnabled in
            guard let self = self else { return }
            
            loginButton.setButtonDisabled(isEnabled)
        }).store(in: &cancallable)
    }
    
    // MARK: - subscribe to isLoading or not.
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
