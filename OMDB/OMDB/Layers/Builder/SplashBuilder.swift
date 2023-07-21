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
        let vc = SplashVC(nibName: SplashVC.className, bundle: nil)
        vc.coordinator = coordinatorDelegate
        return vc
    }
}
