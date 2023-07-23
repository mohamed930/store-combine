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
        guard let viewController: boardingScreenViewController = declareViewController(screen: .boardingScreenViewController) else { return }
        viewController.coordinator = self
        navigationController.setViewControllers([viewController], animated: true)
    }
    
    func goToLoginScreen() {
        let coordinator = loginCoordinator(navigationController: navigationController)
        add(coordinator: coordinator)
        coordinator.start()
    }
}
