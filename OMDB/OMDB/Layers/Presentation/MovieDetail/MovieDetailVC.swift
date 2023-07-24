//
//  MovieDetailVC.swift
//  OMDB
//
//  Created by Halit Baskurt on 24.07.2023.
//

import UIKit

class MovieDetailVC: BaseViewController {
    
    private var viewModel: MovieDetailVM!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func inject(viewModel: MovieDetailVM) {
        self.viewModel = viewModel
    }

}
