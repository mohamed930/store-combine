//
//  loginViewController.swift
//  store
//
//  Created by Mohamed Ali on 22/07/2023.
//

import UIKit

class loginViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var loginviewmodel: loginViewModel!
    let padding: CGFloat = 40
    let color = images.blackColor.color
    var flag = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    func configureUI() {
        userNameTextField.addPadding(amount: padding, PlaceHolder: myStrings.userName, Color: color)
        passwordTextField.addPadding(amount: padding, PlaceHolder: myStrings.password, Color: color)
    }
    
    @IBAction func showPassword(_ sender: Any) {
        flag = !flag
        passwordTextField.isSecureTextEntry = flag ? true : false
    }

}
