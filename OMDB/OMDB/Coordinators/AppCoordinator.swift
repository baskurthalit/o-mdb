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
    func navigate(to flowType: AppFlow) {
        switch flowType{
        case .movie(let movieFlow):
            handleMovieFlows(movieFlow)
        }
    }
    
    private func handleMovieFlows(_ movieFlow: MovieFlow) {
        
        switch movieFlow {
        case .searchMovie:
            let builder: SearchMovieBuilder = SearchMovieBuilderImpl()
            let vc = builder.build(coordinatorDelegate: self)
            self.navigationController.pushViewController(vc, animated: true)
        case .movieDetail: break
        }
    }
}
