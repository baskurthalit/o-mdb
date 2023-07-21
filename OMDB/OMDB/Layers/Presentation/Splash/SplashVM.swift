//
//  SplashVM.swift
//  OMDB
//
//  Created by Halit Baskurt on 21.07.2023.
//

import Foundation

protocol SplashVM {
    var vmStateClosure:( (ObservationType<SplashVMImpl.Event, SplashVMImpl.ErrorType>) -> () )? { get set }
    
    func start()
}

final class SplashVMImpl: SplashVM {
    
    var vmStateClosure: ((ObservationType<SplashEvent, ErrorType>) -> ())?
    
    typealias Event = SplashEvent
    typealias ErrorType = Error
    
    private var useCase: SplashUseCase
    
    init(useCase: SplashUseCase) {
        self.useCase = useCase
    }
    
    func start() { }
    
    
    enum SplashEvent {
        case updateUI
    }
}
