//
//  SearchMovieUseCase.swift
//  OMDB
//
//  Created by Halit Baskurt on 22.07.2023.
//

import Foundation

protocol SearchMovieUseCase {
    func searchMovie(query: String, completion: @escaping SearchMovieUseCaseImpl.SearchMovieCompletionType)
}

final class SearchMovieUseCaseImpl: SearchMovieUseCase {
    typealias SearchMovieCompletionType = (Result<SearchMovie,OMDBAPI.OMDBAPIError>) -> Void
    
    func searchMovie(query: String, completion: @escaping SearchMovieCompletionType) {
        OMDBAPI.search(query: query, completion: completion)
    }
}
