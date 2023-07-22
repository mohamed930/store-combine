//
//  loginCoordinator.swift
//  store
//
//  Created by Mohamed Ali on 22/07/2023.
//

import UIKit

class loginCoordinator: BaseCoordinator {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        let viewController = loginViewController(nibName: "loginViewController", bundle: nil)
        let viewmodel = loginViewModel()
        viewmodel.coordinator = self
        viewController.loginviewmodel = viewmodel
        navigationController.setViewControllers([viewController], animated: true)
    }
}
