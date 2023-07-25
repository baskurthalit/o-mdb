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
        stateClosure?(.updateUI(.updateNavigationTitle(with: movieItem.Title)))
        prepareUI()
        sendMovieDetailViewEvent()
    }
    
    func sendMovieDetailViewEvent() {
        FirebaseAnalyticsManager
            .shared
            .sendEvent("page_view",
                       parameters:
                        [ "movie_type": movieItem.type,
                          "image_url" : movieItem.Poster ?? "not-have",
                          "imdb_id" : movieItem.imdbID,
                          "movie_title" : movieItem.Title ])
    }
    
    private func prepareUI() {
        var rows: [MovieDetailProviderImpl.RowType] = []
        
        rows.append(.imagePoster(posterUrl: movieItem.Poster))
        rows.append(.imageInformation(movieItem: movieItem))
        
        stateClosure?(.updateUI(.setProviderData(contentData: [.Detail(rows: rows)])))
    }
    
    
    
    enum Event {
        case updateNavigationTitle(with: String)
        case setProviderData(contentData: [MovieDetailProviderImpl.SectionType])
    }
}
