//
//  MovieDetailVM.swift
//  OMDB
//
//  Created by Halit Baskurt on 24.07.2023.
//

import Foundation


protocol MovieDetailVM {
    var stateClosure: ((ObservationType<MovieDetailVMImpl.Event, Error>) -> () )? { get set }
    func start()
}

final class MovieDetailVMImpl: MovieDetailVM {
    var stateClosure: ((ObservationType<Event, Error>) -> ())?

    let useCase: MovieDetailUseCase
    let movieItem: MovieItem
    
    init(useCase: MovieDetailUseCase, movieItem: MovieItem) {
        self.useCase = useCase
        self.movieItem = movieItem
    }
    
    func start() {
        //
    }
    
    
    
    enum Event {
        case updateUI
    }
}
