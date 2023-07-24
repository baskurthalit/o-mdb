//
//  MovieDetailPosterCell.swift
//  OMDB
//
//  Created by Halit Baskurt on 24.07.2023.
//

import UIKit

final class MovieDetailPosterCell: UITableViewCell {
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var moviePosterContainer: UIView!{
        didSet{
            moviePosterContainer.layer.cornerRadius = 20
        }
    }
    
    func setupCell(imageUrl: String) {
        self.moviePosterImageView.load(urlString: imageUrl)
    }
}
