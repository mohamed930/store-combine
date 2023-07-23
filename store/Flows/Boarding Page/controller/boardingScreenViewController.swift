//
//  boardingScreenViewController.swift
//  store
//
//  Created by Mohamed Ali on 22/07/2023.
//

import UIKit

class boardingScreenViewController: UIViewController {
    
    var coordinator: boardingScreenCoordinator!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func goToLoginScreen(_ sender: Any) {
        coordinator.goToLoginScreen()
    }
}
