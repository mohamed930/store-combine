//
//  signupViewController.swift
//  store
//
//  Created by Mohamed Ali on 28/07/2023.
//

import UIKit
import Combine

class signupViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var checkBoxButton: UIButton!
    
    var signupviewmodel: signupViewModel!
    let padding: CGFloat = 40

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    func configureUI() {
        locationLabel.text = signupviewmodel.locationString
        
        emailTextField.addPadding(amount: padding, PlaceHolder: myStrings.userName, Color: images.blackColor.color)
        passwordTextField.addPadding(amount: padding, PlaceHolder: myStrings.password, Color: images.blackColor.color)
        confirmPasswordTextField.addPadding(amount: padding, PlaceHolder: myStrings.confirmPassword, Color: images.blackColor.color)
    }
    
    // MARK: - button Actions functions.
    @IBAction func seePassword(_ sender: UIButton) {
        
    }
    
    @IBAction func checkBoxButtonAction(_ sender: Any) {
        
    }
    
    @IBAction func signupButtonAction(_ sender: Any) {
        
    }
    
    @IBAction func signInButtonAction (_ sender: Any) {
        signupviewmodel.moveToLoginScreenOperation()
    }

}
