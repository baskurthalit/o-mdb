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

final class SplashVMImpl : SplashVM {
    
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
    
    private func fetchRemoteConfigDependingNetworkStatus(isNetworkAvailable: Bool) {
        guard isNetworkAvailable == true else { return }
        
        useCase.fetchSplashTitleFromRemoteConfig { [weak self] result in
            switch result {
            case .success(let splashTitle):
                self?.stateClosure?(.updateUI(.updateSplashTitle(title: splashTitle)))
            case .failure(let error): break
            }
        }
    }
    
    enum SplashEvent {
        case updateSplashTitle(title: String?)
    }
    
    @objc func reachabilityStatus(_ notification: NSNotification) {
        if let object = notification.object as? [String : Any],
           let isNetworkAvailable : Bool = object["isNetworkAvailable"] as? Bool {
            fetchRemoteConfigDependingNetworkStatus(isNetworkAvailable: isNetworkAvailable)
        }
    }

}
