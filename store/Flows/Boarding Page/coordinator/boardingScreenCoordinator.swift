//
//  boardingScreenCoordinator.swift
//  store
//
//  Created by Mohamed Ali on 22/07/2023.
//

import UIKit

class boardingScreenCoordinator: BaseCoordinator {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        let viewController = boardingScreenViewController(nibName: "boardingScreenViewController", bundle: nil)
        viewController.coordinator = self
        navigationController.setViewControllers([viewController], animated: true)
    }
}
