//
//  SplashBuilder.swift
//  OMDB
//
//  Created by Halit Baskurt on 20.07.2023.
//

import UIKit


protocol SplashScreenBuilder {
    func build(coordinatorDelegate: CoordinatorDelegate?) -> UIViewController
}

struct SplashScreenBuilderImpl: SplashScreenBuilder {
    func build(coordinatorDelegate: CoordinatorDelegate?) -> UIViewController {
        let viewController = SplashVC(nibName: SplashVC.className, bundle: nil)
        viewController.coordinator = coordinatorDelegate
        let splashUseCase: SplashUseCase = SplashUseCaseImpl()
        let splashViewModel: SplashVM = SplashVMImpl(useCase: splashUseCase)
        viewController.inject(viewModel: splashViewModel)
        return viewController
    }
}
