//
//  SceneDelegate.swift
//  OMDB
//
//  Created by Halit Baskurt on 20.07.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    private(set) var appCoordinator: AppCoordinator?
    private var connectionAlert : UIAlertController?
    private var isMovieFlowStart: Bool = false
    private var sessionDispatchWork: DispatchWorkItem?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reachabilityChanged(_:)),
                                               name: Notification.Name("internetConnectionChanged"), object: nil)
        
        let baseNavigationController: BaseNavigationController = .init()
        
        window.rootViewController = baseNavigationController
        
        let coordinator = AppCoordinator(navigationController: baseNavigationController, window: window)
        coordinator.start()
        self.appCoordinator = coordinator
        window.makeKeyAndVisible()
    }

    @objc func reachabilityChanged(_ notification: NSNotification) {
        if let object = notification.object as? [String : Any],
           let isNetworkAvailable : Bool = object["isNetworkAvailable"] as? Bool {
            updateAlertState(isNetworkAvailable: isNetworkAvailable)
            openMovieFlowIfNot(isNetworkAvailable: isNetworkAvailable)
        }
    }
    
    private func openMovieFlowIfNot(isNetworkAvailable: Bool) {
        guard isMovieFlowStart == false, isNetworkAvailable == true else {
            sessionDispatchWork?.cancel()
            sessionDispatchWork = nil
            return
        }
        
        var openMovieFlowWork = DispatchWorkItem {
            self.appCoordinator?.openMovieFlow()
            self.isMovieFlowStart = true
        }
        
        self.sessionDispatchWork = openMovieFlowWork
        
        if let sessionDispatchWork, !sessionDispatchWork.isCancelled {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: sessionDispatchWork)
        }
        
    }
    
    private func updateAlertState(isNetworkAvailable: Bool) {
        if isNetworkAvailable {
            if connectionAlert != nil {
                connectionAlert?.dismiss(animated: true) { self.connectionAlert = nil }
            }
        } else {
            guard let topVC = UIApplication.getTopViewController(base: appCoordinator?.navigationController),
                  topVC != connectionAlert else { return }
            connectionAlert = UIAlertController(title: "İnternet Bağlantısı YOK", message: "SERVICE_ERROR", preferredStyle: .alert)
            connectionAlert?.addAction(.init(title: "OK", style: .cancel, handler: { alertAction in
                self.connectionAlert = nil
            }))
            
            if let connectionAlert, topVC != connectionAlert { topVC.present(connectionAlert, animated: true) }
        }
    }

}

