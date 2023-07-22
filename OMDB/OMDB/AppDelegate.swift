//
//  AppDelegate.swift
//  OMDB
//
//  Created by Halit Baskurt on 20.07.2023.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private var connectionAlert : UIAlertController?
    private var reachability: ReachabilityManager = .shared

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reachabilityChanged(_:)),
                                               name: Notification.Name("internetConnectionChanged"), object: nil)
        reachability.startMonitoring()
        FirebaseApp.configure()
        
        FirebaseAnalyticsManager.shared.start(settings: .init())
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    @objc func reachabilityChanged(_ notification: NSNotification) {
        if let object = notification.object as? [String : Any],
           let isNetworkAvailable : Bool = object["isNetworkAvailable"] as? Bool {
            
            if isNetworkAvailable{
                if connectionAlert != nil {
                    connectionAlert?.dismiss(animated: true) { self.connectionAlert = nil }
                }
            } else {
                guard let topVC = UIApplication.getTopViewController(), topVC != connectionAlert else { return }
                connectionAlert = UIAlertController(title: "İnternet Bağlantısı YOK", message: "SERVICE_ERROR", preferredStyle: .alert)
                connectionAlert?.addAction(.init(title: "OK", style: .cancel, handler: { alertAction in
                    self.connectionAlert = nil
                }))
                
                if let connectionAlert, topVC != connectionAlert { topVC.present(connectionAlert, animated: true) }
            }
        }
    }
    
}

