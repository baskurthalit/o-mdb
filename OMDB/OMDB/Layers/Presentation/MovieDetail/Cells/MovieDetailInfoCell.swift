//
//  MovieDetailInfoCell.swift
//  OMDB
//
//  Created by Halit Baskurt on 24.07.2023.
//

import UIKit

class MovieDetailInfoCell: UITableViewCell {

    @IBOutlet weak var movieDetailTypeText: UILabel!
    @IBOutlet weak var movieDetailYearText: UILabel!
    
    func setupCell(with movieItem: MovieItem) {
        self.movieDetailTypeText.text = movieItem.type
        self.movieDetailYearText.text = movieItem.Year
    }
    
}
