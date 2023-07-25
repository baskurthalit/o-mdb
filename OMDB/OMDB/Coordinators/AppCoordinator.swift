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
    var window: UIWindow
    var childCoordinators: [Coordinator] = []
    
    var navigationController: BaseNavigationController
    
    func start(completion: @escaping () -> Void = { }) {
        let builder: SplashScreenBuilder = SplashScreenBuilderImpl()
        let vc = builder.build()
        self.navigationController.pushViewController(vc, animated: false)
    }
    
    init(parentCoordinator: Coordinator? = nil,
         navigationController: BaseNavigationController, window: UIWindow) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
        self.window = window
    }
}

extension AppCoordinator {
    func openMovieFlow() {
        let movieCoordinator = MovieCoordinator(parentCoordinator: self)
        self.addChild(coordinator: movieCoordinator)
        movieCoordinator.start() { self.navigationController.viewControllers.removeAll() }
    }
}
