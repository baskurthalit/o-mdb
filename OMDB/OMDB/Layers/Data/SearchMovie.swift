//
//  SearchMovie.swift
//  OMDB
//
//  Created by Halit Baskurt on 22.07.2023.
//

import Foundation

struct SearchMovie: Codable {
    let Search:[MovieItem]
}

struct MovieItem: Codable {
    let Title : String
    let Year : String
    let imdbID : String
    let `Type`: String
    let Poster: String
}
