//
//  SearchMovieVM.swift
//  OMDB
//
//  Created by Halit Baskurt on 22.07.2023.
//

import Foundation

protocol SearchMovieVM {
    var stateClosure: ((ObservationType<SearchMovieVMImpl.Event, Error>) -> () )? { get set }
    func searchMovie(for query : String)
    func start()
}

final class SearchMovieVMImpl: SearchMovieVM {
    
    var stateClosure: ((ObservationType<Event, Error>) -> ())?
    private let useCase: SearchMovieUseCase
    
    init(useCase:SearchMovieUseCase) {
        self.useCase = useCase
    }
    
    func start() {
        //
    }
    
    func searchMovie(for query:String) {
        useCase.searchMovie(query: query) { result in
            switch result {
            case .success(let searchMovie): break
            case .failure(let error): break
            }
        }
    }
    
    enum Event {
        case updateUI
    }
}
