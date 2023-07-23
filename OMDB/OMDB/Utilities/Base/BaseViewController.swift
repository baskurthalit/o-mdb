//
//  BaseViewController.swift
//  OMDB
//
//  Created by Halit Baskurt on 20.07.2023.
//

import UIKit

class BaseViewController: UIViewController {
    weak var coordinator: CoordinatorDelegate?
    
    func setNavigationTitle(_ title : String, _ color : UIColor = .black) {
        self.title = title
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20),
                                                                        NSAttributedString.Key.foregroundColor: color]
    }
}
