//
//  SearchMovieVC.swift
//  OMDB
//
//  Created by Halit Baskurt on 21.07.2023.
//

import UIKit

class SearchMovieVC: BaseViewController {
    
    private var viewModel: SearchMovieVM!
    private var provider: SearchMovieProvider!
    
    @IBOutlet weak var searchTextField: UITextField! {
        didSet{ searchTextField.delegate = self }
    }
    private var searchText: String = ""
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTitle("Search Movie")
        addObservation()
        provider.setupTableView(tableView)
        viewModel.start()
    }
    
    private func addObservation() {
        addViewModelObservation()
        addProviderObservation()
    }
    
    func inject(viewModel: SearchMovieVM, provider: SearchMovieProvider) {
        self.viewModel = viewModel
        self.provider = provider
    }
    
    private func addViewModelObservation() {
        viewModel.stateClosure = { [weak self] viewModelState in
            switch viewModelState{
            case .updateUI(let data): self?.viewModelObservationHandler(data)
            case .error(let error): break
            }
        }
    }
    
    private func viewModelObservationHandler(_ state: SearchMovieVMImpl.Event?) {
        switch state {
        case .setProviderData(let data):
            provider.setProviderData(contentData: data)
        case .updateLoading(let isLoadingActive):
            isLoadingActive ? startLoading() : stopLoading()
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
    
    private func providerObservationHandler(_ state: SearchMovieProviderImpl.UserInteractive?) {
        switch state {
        case .didTapMovie(let movieItem):
            coordinator?.navigate(to: .movie(.movieDetail(withMovieItem: movieItem)))
        default: break
        }
    }


}

extension SearchMovieVC: UITextFieldDelegate {
    
    @objc func searchMovie() {
        viewModel.searchMovie(for: searchText)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == searchTextField {
            let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
            
            NSObject.cancelPreviousPerformRequests(withTarget: self)
            if let searchText = newText, !searchText.trimmingCharacters(in: .whitespaces).isEmpty {
                self.searchText = searchText
                self.perform(#selector(searchMovie), with: nil, afterDelay: 1.0)
            } else {
                self.viewModel.setStartPage()
            }
        }
        return true
    }
}
