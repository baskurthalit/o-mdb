//
//  SplashVC.swift
//  OMDB
//
//  Created by Halit Baskurt on 21.07.2023.
//

import UIKit
import Lottie

class SplashVC: BaseViewController {
    
    private var viewModel: SplashVM!

    @IBOutlet weak var animationView: LottieAnimationView! {
        didSet { animationView.loopMode = .loop }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.start()
        coordinator?.navigate(to: .movie(movieFlow: .searchMovie))
        animationView.play()
    }
    
    func inject(viewModel: SplashVM) {
        self.viewModel = viewModel
    }
}
