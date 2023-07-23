//
//  SplashUseCase.swift
//  OMDB
//
//  Created by Halit Baskurt on 21.07.2023.
//

import Foundation
import Firebase

protocol SplashUseCase {
    var  isNetworkAvailable: Bool { get }
    func fetchSplashTitleFromRemoteConfig(completion: @escaping SplashUseCaseImpl.FetchRemoteConfigCompleteType)
}

final class SplashUseCaseImpl: SplashUseCase {
    typealias FetchRemoteConfigCompleteType = (Result<String?,Error>) -> Void
    
    let reachabiltyManager: ReachabilityManager
    private var remoteConfig = RemoteConfig.remoteConfig()
    
    var isNetworkAvailable: Bool { reachabiltyManager.isNetworkAvailable }
    
    init(reachabiltyManager: ReachabilityManager = .shared) {
        self.reachabiltyManager = reachabiltyManager
    }
    
    deinit { print("DEINIT \(self)") }
}

extension SplashUseCaseImpl {
    func fetchSplashTitleFromRemoteConfig(completion: @escaping FetchRemoteConfigCompleteType) {
        remoteConfig.fetch() { [weak self] status, error in
            guard status == .success, let self = self else {
                completion(.failure(error ?? NSError(domain: "Remote Config Error", code: 1)))
                return
            }
            
            self.remoteConfig.activate()
        
            let splashScreenTitle : String? = self.remoteConfig.configValue(forKey: "launcScreenTitle").stringValue
            completion(.success(splashScreenTitle))
        }
    }
}
