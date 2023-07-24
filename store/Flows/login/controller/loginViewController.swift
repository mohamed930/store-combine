//
//  loginViewController.swift
//  store
//
//  Created by Mohamed Ali on 22/07/2023.
//

import UIKit
import Combine

class loginViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
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
        subscribeToEnableButtonOrNot()
        subscribeToIsLoadingBehvaiour()
    }
    
    func configureUI() {
        userNameTextField.addPadding(amount: padding, PlaceHolder: myStrings.userName, Color: color)
        passwordTextField.addPadding(amount: padding, PlaceHolder: myStrings.password, Color: color)
    }
    
    @IBAction func showPassword(_ sender: Any) {
        flag = !flag
        passwordTextField.isSecureTextEntry = flag ? true : false
    }
    
    
    // MARK: - bind to CombineVariable.
    func bindToTextField() {
        loginviewmodel.userNameSubject  = userNameTextField.textPublisher()
        loginviewmodel.passwordSubject  = passwordTextField.textPublisher()
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
}
