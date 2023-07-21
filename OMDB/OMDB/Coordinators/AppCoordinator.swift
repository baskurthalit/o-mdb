//
//  AppCoordinator.swift
//  OMDB
//
//  Created by Halit Baskurt on 21.07.2023.
//

import UIKit

class AppCoordinator: Coordinator {
    private(set) var coordinatorType: CoordinatorType = .app
    
    var parentCoordinator: Coordinator?
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: BaseNavigationController
    
    func start() {
        let builder: SplashScreenBuilder = SplashScreenBuilderImpl()
        let vc = builder.build(coordinatorDelegate: self)
        self.navigationController.pushViewController(vc, animated: false)
    }
    
    init(parentCoordinator: Coordinator? = nil,
         navigationController: BaseNavigationController) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
    }
}

extension AppCoordinator: CoordinatorDelegate {
    func navigate() {
        let vc: SearchMovieVC = .init(nibName: SearchMovieVC.className, bundle: nil)
        vc.view.backgroundColor = .cyan
        vc.coordinator = self
        self.navigationController.pushViewController(vc, animated: true)
    }
    
}
