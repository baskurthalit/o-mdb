//
//  RouterFlow.swift
//  OMDB
//
//  Created by Halit Baskurt on 22.07.2023.
//

import Foundation

enum AppFlow {
    case movie(movieFlow: MovieFlow)
    
}

enum MovieFlow {
    case searchMovie
    case movieDetail
}
