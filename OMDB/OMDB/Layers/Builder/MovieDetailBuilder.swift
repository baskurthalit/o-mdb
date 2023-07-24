//
//  MovieDetailBuilder.swift
//  OMDB
//
//  Created by Halit Baskurt on 24.07.2023.
//

import UIKit


protocol MovieDetailBuilder {
    func build(coordinatorDelegate: CoordinatorDelegate?, movieItem: MovieItem) -> UIViewController
}

struct MovieDetailBuilderImpl: MovieDetailBuilder {
    func build(coordinatorDelegate: CoordinatorDelegate?, movieItem: MovieItem) -> UIViewController {
        let viewController = MovieDetailVC(nibName: MovieDetailVC.className, bundle: nil)
        viewController.coordinator = coordinatorDelegate
        let movieDetailUseCase: MovieDetailUseCase = MovieDetailUseCaseImpl()
        let movieDetailViewModel: MovieDetailVM = MovieDetailVMImpl(useCase: movieDetailUseCase, movieItem: movieItem)
        let movieDetailProvider: MovieDetailProvider = MovieDetailProviderImpl()
        viewController.inject(viewModel: movieDetailViewModel, provider: movieDetailProvider)
        return viewController
    }
}
