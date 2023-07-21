//
//  ReachabiltyManager.swift
//  OMDB
//
//  Created by Halit Baskurt on 21.07.2023.
//

import Foundation
import Reachability

final class ReachabilityManager: NSObject {
    static let shared : ReachabilityManager = .init()
    
    var isNetworkAvailable : Bool {
        return reachabilityStatus != .unavailable
    }
    
    var isWifi: Bool {
        return reachabilityStatus == .wifi
    }
    
    var reachabilityStatus: Reachability.Connection = .unavailable
    let reachability = try! Reachability()
    
    @objc func reachabilityChanged(notification: Notification) {
        guard let reachability = notification.object as? Reachability else { return }
        reachabilityStatus = reachability.connection
    }
    
    func startMonitoring() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.reachabilityChanged),
                                               name: Notification.Name.reachabilityChanged,
                                               object: reachability)
        do {
            try reachability.startNotifier()
        } catch { debugPrint("Could not start reachability notifier") }
    }
    
}
