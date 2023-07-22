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
        self.navigationController?.navigationBar.isHidden = true
        viewModel?.start()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.coordinator?.navigate(to: .movie(.searchMovie))
        }
        
        animationView.play()
    }
    
    func inject(viewModel: SplashVM) {
        self.viewModel = viewModel
    }
}
