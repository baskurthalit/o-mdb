//
//  BaseNavigationController.swift
//  OMDB
//
//  Created by Halit Baskurt on 20.07.2023.
//

import UIKit

class BaseNavigationController: UINavigationController {
    weak var coordinator: CoordinatorDelegate?
    private var window : UIWindow?
    
    deinit { print("DEINIT -> \(self)") }
}
