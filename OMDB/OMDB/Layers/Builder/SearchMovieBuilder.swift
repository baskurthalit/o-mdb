//
//  SearchMovieBuilder.swift
//  OMDB
//
//  Created by Halit Baskurt on 22.07.2023.
//

import UIKit


protocol SearchMovieBuilder {
    func build(coordinatorDelegate: CoordinatorDelegate?) -> UIViewController
}

struct SearchMovieBuilderImpl: SearchMovieBuilder {
    func build(coordinatorDelegate: CoordinatorDelegate?) -> UIViewController {
        let viewController = SearchMovieVC(nibName: SearchMovieVC.className, bundle: nil)
        viewController.coordinator = coordinatorDelegate
        let searchMovieUseCase: SearchMovieUseCase = SearchMovieUseCaseImpl()
        let searchMovieViewModel: SearchMovieVM = SearchMovieVMImpl(useCase: searchMovieUseCase)
        let searchMovieProvider: SearchMovieProvider = SearchMovieProviderImpl()
        viewController.inject(viewModel: searchMovieViewModel,provider: searchMovieProvider)
        return viewController
    }
}
