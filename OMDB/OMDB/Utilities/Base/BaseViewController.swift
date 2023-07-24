//
//  BaseViewController.swift
//  OMDB
//
//  Created by Halit Baskurt on 20.07.2023.
//

import UIKit
import Lottie

class BaseViewController: UIViewController {
    weak var coordinator: CoordinatorDelegate?
    var loadingAnimation: UIView?
    
    func setNavigationTitle(_ title : String, _ color : UIColor = .black) {
        self.title = title
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20),
                                                                        NSAttributedString.Key.foregroundColor: color]
    }
    
    func startLoading() {
        guard loadingAnimation == nil else { return }
        
        let loadingAnimationView: LottieAnimationView = .init(name: "animation_lkfrf250")
        let animationSize: CGFloat = 150
        let centerX = (UIScreen.main.bounds.width / 2) - animationSize / 2
        let centerY = (UIScreen.main.bounds.height / 2) - animationSize / 2
        
        loadingAnimationView.frame = CGRect(x: centerX, y: centerY,
                                            width: animationSize,
                                            height: animationSize)
        
        loadingAnimationView.contentMode = .scaleToFill
        loadingAnimationView.loopMode = .loop
        
        loadingAnimation = .init(frame: view.frame)
        
        guard let loadingAnimation else { return }
        loadingAnimation.addSubview(loadingAnimationView)
        loadingAnimation.backgroundColor = .white.withAlphaComponent(0.8)
        loadingAnimationView.play()
        view.addSubview(loadingAnimation)
        view.bringSubviewToFront(loadingAnimation)
    }
    
    func stopLoading() {
        DispatchQueue.main.async { self.removeLoadingAnimation() }
    }
    
    private func removeLoadingAnimation() {
        self.loadingAnimation?.removeFromSuperview()
        self.loadingAnimation = nil
    }
    
    func setNavigationBackButton() {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(didTapBackButtonOnNavigationController))

        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func didTapBackButtonOnNavigationController() {
        if self.navigationController?.viewControllers.count == 1 {
            self.dismiss(animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}

extension BaseViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
