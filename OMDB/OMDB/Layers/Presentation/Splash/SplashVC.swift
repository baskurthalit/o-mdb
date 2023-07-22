//
//  SplashVC.swift
//  OMDB
//
//  Created by Halit Baskurt on 21.07.2023.
//

import UIKit

class SplashVC: BaseViewController {
    
    private var viewModel: SplashVM!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel?.start()
        
    }
    
    func inject(viewModel: SplashVM) {
        self.viewModel = viewModel
    }
}
