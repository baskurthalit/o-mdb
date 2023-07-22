//
//  FirebaseAnalyticsManager.swift
//  OMDB
//
//  Created by Halit Baskurt on 22.07.2023.
//

import Foundation
import Firebase

struct FirebaseAnalyticsSettings {
    let analyticsUserIDKey = "User ID"
    let analyticsLogEnabled = true
    let logLevel: FirebaseLoggerLevel = .min
}

final class FirebaseAnalyticsManager {
    
    private(set) var settings: FirebaseAnalyticsSettings?
    static let shared: FirebaseAnalyticsManager = FirebaseAnalyticsManager()
    private init() { }
    
    func start(settings: FirebaseAnalyticsSettings) {
        self.settings = settings
        FirebaseConfiguration.shared.setLoggerLevel(settings.logLevel)
        Analytics.setAnalyticsCollectionEnabled(settings.analyticsLogEnabled)
    }
    
    func setUserID(userID: String) {
        Analytics.setUserID(userID)
    }
    
    func sendEvent(_ name: String, parameters: [String : Any]? = nil) {
        Analytics.logEvent(name, parameters: parameters)
    }
    
    private func setUserProperties(_ userID: String) {
        guard let settings else { return }
        Analytics.setUserProperty(userID, forName: settings.analyticsUserIDKey)
    }
    
}
