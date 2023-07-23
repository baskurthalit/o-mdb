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

    @IBOutlet weak var splashTitle: UILabel!
    @IBOutlet weak var animationView: LottieAnimationView! {
        didSet { animationView.loopMode = .loop }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        addViewModelObservation()
        viewModel?.start()
        animationView.play()
    }
    
    func inject(viewModel: SplashVM) {
        self.viewModel = viewModel
    }
    
    deinit { print("DEINIT \(self)") }
    
    private func addViewModelObservation() {
        viewModel.stateClosure = { [weak self] viewModelState in
            switch viewModelState{
            case .updateUI(let data): self?.viewModelObservationHandler(data)
            case .error(let error): break
            }
        }
    }
    private func viewModelObservationHandler(_ state: SplashVMImpl.Event?) {
        switch state {
        case .shouldContinueMainScreen:
            self.dismiss(animated: true) { [weak self] in
                self?.coordinator?.navigate(to: .movie(.movieDetail))
            }
            
        case .updateSplashTitle(let title): self.splashTitle.text = title
        default: break
        }
    }
}
