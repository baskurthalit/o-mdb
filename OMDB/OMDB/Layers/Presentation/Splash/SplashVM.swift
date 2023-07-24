//
//  SplashVM.swift
//  OMDB
//
//  Created by Halit Baskurt on 21.07.2023.
//

import Foundation

protocol SplashVM {
    var stateClosure:( (ObservationType<SplashVMImpl.Event, SplashVMImpl.ErrorType>) -> () )? { get set }
    
    func start()
}

final class SplashVMImpl:NSObject, SplashVM {
    
    var stateClosure: ((ObservationType<SplashEvent, ErrorType>) -> ())?
    
    typealias Event = SplashEvent
    typealias ErrorType = Error
    
    private var useCase: SplashUseCase
    
    init(useCase: SplashUseCase) {
        self.useCase = useCase
    }
    
    deinit {
        print("DEINIT \(self)")
        NotificationCenter.default.removeObserver(self)
    }
    
    func start() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reachabilityStatus(_:)),
                                               name: Notification.Name("internetConnectionChanged"), object: nil)
    }
    
    private func checkNetworkStatus(isNetworkAvailable: Bool) {
        let isNetworkAvailable: Bool = useCase.isNetworkAvailable
        guard isNetworkAvailable == true else {
            NSObject.cancelPreviousPerformRequests(withTarget: self)
            return
        }
        
        useCase.fetchSplashTitleFromRemoteConfig { [weak self] result in
            switch result {
            case .success(let splashTitle):
                self?.stateClosure?(.updateUI(.updateSplashTitle(title: splashTitle)))
            case .failure(let error): break
            }
        }
        
        self.perform(#selector(shouldCountinueMainScreen), with: nil, afterDelay: 3.0)
    }
    
    @objc private func shouldCountinueMainScreen() {
        self.stateClosure?(.updateUI(.shouldContinueMainScreen))
    }
    
    enum SplashEvent {
        case updateSplashTitle(title: String?)
        case shouldContinueMainScreen
    }
    
    @objc func reachabilityStatus(_ notification: NSNotification) {
        if let object = notification.object as? [String : Any],
           let isNetworkAvailable : Bool = object["isNetworkAvailable"] as? Bool {
            checkNetworkStatus(isNetworkAvailable: isNetworkAvailable)
        }
    }

}
