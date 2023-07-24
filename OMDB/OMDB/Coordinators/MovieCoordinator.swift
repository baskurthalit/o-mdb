//
//  MovieCoordinator.swift
//  OMDB
//
//  Created by Halit Baskurt on 22.07.2023.
//

import Foundation

class MovieCoordinator: Coordinator, CoordinatorDelegate {

    var coordinatorType: CoordinatorType = .movie
    
    var parentCoordinator: Coordinator?
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: BaseNavigationController
    
    init(parentCoordinator: Coordinator?) {
        self.navigationController = BaseNavigationController()
        self.parentCoordinator = parentCoordinator
    }
    
    func start(completion: @escaping () -> Void = {}) {
        self.navigationController.modalPresentationStyle = .fullScreen
        let builder: SearchMovieBuilder = SearchMovieBuilderImpl()
        let vc = builder.build(coordinatorDelegate: self)
        parentCoordinator?.navigationController.present(navigationController, animated: false,completion: completion)
        self.navigationController.pushViewController(vc, animated: false)
    }
}

extension MovieCoordinator {
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
        case .movieDetail(let moviewItem):
            let builder: MovieDetailBuilder = MovieDetailBuilderImpl()
            let vc = builder.build(coordinatorDelegate: self, movieItem: moviewItem)
            self.navigationController.pushViewController(vc, animated: true)
        }
    }
}
