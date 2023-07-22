//
//  SearchMovieVC.swift
//  OMDB
//
//  Created by Halit Baskurt on 21.07.2023.
//

import UIKit

class SearchMovieVC: BaseViewController {
    
    private var viewModel: SearchMovieVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.searchMovie(for: "dunkirk")
    }
    
    func inject(viewModel: SearchMovieVM) {
        self.viewModel = viewModel
    }

}
