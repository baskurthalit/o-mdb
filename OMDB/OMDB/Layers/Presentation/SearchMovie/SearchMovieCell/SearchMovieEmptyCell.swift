//
//  SearchMovieEmptyCell.swift
//  OMDB
//
//  Created by Halit Baskurt on 23.07.2023.
//

import UIKit
import Lottie

class SearchMovieEmptyCell: UITableViewCell {
    @IBOutlet weak var animationView: LottieAnimationView! {
        didSet { animationView.loopMode = .loop }
    }
    
    
    @IBOutlet weak var emptyInfoText: UILabel!
    @IBOutlet weak var emptyInfoView: UIView!
    
    func setupCell(infoText: String = "", textColor: UIColor = .black.withAlphaComponent(0.5)) {
        self.emptyInfoText.text = infoText
        self.emptyInfoText.textColor = textColor
        animationView.play()
    }

}
