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
        addViewModelObservation()
        
    }
    
    private func addViewModelObservation() {
        viewModel.stateClosure = { [weak self] viewModelState in
            switch viewModelState{
            case .updateUI(let data): self?.viewModelObservationHandler(data)
            case .error(let error): break
            }
        }
    }
    
    private func viewModelObservationHandler(_ state: MovieDetailVMImpl.Event?) {
        switch state {
        case .updateUI: break
        default: break
        }
    }
    

    
    func inject(viewModel: MovieDetailVM) {
        self.viewModel = viewModel
    }

}
