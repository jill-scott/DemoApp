//
//  LoadingViewModel.swift
//  DemoAppKit
//
//  Created by Jill Scott on 3/4/19.
//  Copyright © 2019 Jill Scott. All rights reserved.
//

import Foundation
import RxSwift

public class LoadingViewModel {
    
    // MARK: - Properties
    let finishedLoadingResponder: FinishedLoadingResponder
    //let locator: Locator
    
    // MARK: - Methods
    public init(finishedLoadingResponder: FinishedLoadingResponder) {
               // , locator: Locator) {
        self.finishedLoadingResponder = finishedLoadingResponder
        //self.locator = locator
    }
    
    public var errorMessages: Observable<ErrorMessage> {
        return errorMessagesSubject.asObserver()
    }
    private let errorMessagesSubject = PublishSubject<ErrorMessage>()
    
//    public func getUsersCurrentLocation() {
//        locator
//            .getUsersCurrentLocation()
//            .done(determinedPickupLocationResponder.pickUpUser(at:))
//            .catch { error in
//                let errorMessage = ErrorMessage(title: "Error Getting Location",
//                                                message: "Could not get your location. Please check location settings and try again.")
//                self.errorMessagesSubject.onNext(errorMessage)
//        }
//    }
    
    public func finishedLoading() {
        finishedLoadingResponder.finishedLoading()
    }
}
