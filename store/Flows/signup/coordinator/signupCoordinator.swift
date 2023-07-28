//
//  signupCoordinator.swift
//  store
//
//  Created by Mohamed Ali on 28/07/2023.
//

import UIKit


class signupCoordinator: BaseCoordinator {
    let navigationController: UINavigationController
    var locationAddress: String
    
    init(navigationController: UINavigationController,locationAddress: String) {
        self.navigationController = navigationController
        self.locationAddress = locationAddress
    }
    
    override func start() {
        guard let viewController: signupViewController = declareViewController(screen: .signupViewController) else { return }
        let viewmodel = signupViewModel()
        viewmodel.coordinator = self
        viewmodel.locationString = locationAddress
        viewController.signupviewmodel = viewmodel
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToLoginScreen() {
        navigationController.popViewController(animated: true)
    }
}
