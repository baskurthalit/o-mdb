//
//  Coordinator.swift
//  OMDB
//
//  Created by Halit Baskurt on 21.07.2023.
//

import UIKit

enum CoordinatorType : String, CaseIterable {
    case app
    case movie
}

protocol Coordinator: AnyObject {
    var coordinatorType: CoordinatorType { get }
    var parentCoordinator: Coordinator? { get set }
    var childCoordinators: [Coordinator] { get set }
    var navigationController: BaseNavigationController { get set }
    func removeChild(coordinator: Coordinator)
    func addChild(coordinator: Coordinator)
    
    func start(completion: @escaping () -> Void)
}

extension Coordinator {
    func addChild(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func removeChild(coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}

protocol CoordinatorDelegate: AnyObject {
    func navigate(to flowType: AppFlow)
}
