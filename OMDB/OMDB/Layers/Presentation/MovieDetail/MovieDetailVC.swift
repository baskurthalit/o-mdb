//
//  MovieDetailVC.swift
//  OMDB
//
//  Created by Halit Baskurt on 24.07.2023.
//

import UIKit

class MovieDetailVC: BaseViewController {
    
    private var viewModel: MovieDetailVM!
    private var provider: MovieDetailProvider!
    
    func inject(viewModel: MovieDetailVM, provider: MovieDetailProvider) {
        self.viewModel = viewModel
        self.provider = provider
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addObservation()
    }
    
    private func addObservation() {
        addProviderObservation()
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
    
    private func addProviderObservation() {
        provider.stateClosure = { [weak self] userInteraction in
            switch userInteraction {
            case .updateUI(let data):
                self?.providerObservationHandler(data)
            default : break
            }
        }
    }
    
    private func providerObservationHandler(_ state: MovieDetailProviderImpl.UserInteractive?) {
        switch state {
        case .didTapMoviePoster(let movieItem):
            break
        default: break
        }
    }
    

    
    

}
