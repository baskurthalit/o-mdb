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
    
    private override init() {}
    
    private(set) var reachabilityStatus: Reachability.Connection = .unavailable
    let reachability = try! Reachability()
    
    @objc private func reachabilityChanged(notification: Notification) {
        guard let reachability = notification.object as? Reachability else { return }
        reachabilityStatus = reachability.connection
        sendNotificationReachabiltyChanged()
    }
    
    private func sendNotificationReachabiltyChanged() {
        NotificationCenter.default.post(name: Notification.Name("internetConnectionChanged"),
                                        object: ["isNetworkAvailable" : isNetworkAvailable])
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
