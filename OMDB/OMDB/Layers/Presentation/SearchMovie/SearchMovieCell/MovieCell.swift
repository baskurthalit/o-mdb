//
//  MovieCell.swift
//  OMDB
//
//  Created by Halit Baskurt on 23.07.2023.
//

import UIKit

final class MovieCell: UITableViewCell {
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var movieImdbScore: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    
    func setupCell(with movieItem: MovieItem) {
        self.movieYear.text = movieItem.Year
        self.movieTitle.text = movieItem.Title
        self.movieImdbScore.text = movieItem.imdbID
        setupMoviePoster(posterURLString: movieItem.Poster)
    }
    
    private func setupMoviePoster(posterURLString: String) {
        
    }
}
