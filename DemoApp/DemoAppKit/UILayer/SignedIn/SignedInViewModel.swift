//
//  SignedInViewModel.swift
//  DemoAppKit
//
//  Created by Jill Scott on 2/26/19.
//  Copyright © 2019 Jill Scott. All rights reserved.
//

import Foundation
import RxSwift

//public class SignedInViewModel: DeterminedPickUpLocationResponder,
//    NewRideRequestAcceptedResponder,
//    GoToNewRideNavigator,
public class SignedInViewModel: DoneWithProfileResponder, FinishedLoadingResponder {
    
    // MARK: - Properties
    public var view: Observable<SignedInView> { return viewSubject.asObservable() }
    private let viewSubject = BehaviorSubject<SignedInView>(value: .loading)
    
    public var showingProfileScreen: Observable<Bool> { return showingProfileScreenSubject.asObservable() }
    private let showingProfileScreenSubject = BehaviorSubject<Bool>(value: false)
    
    // MARK: - Methods
    public init() {}
    
//    public func pickUpUser(at location: Location) {
//        viewSubject.onNext(.pickMeUp(pickupLocation: location))
//    }
    
//    public func newRideRequestAccepted() {
//        viewSubject.onNext(.waitingForPickup)
//    }
//
//    public func navigateToNewRide() {
//        viewSubject.onNext(.gettingUsersLocation)
//    }
    
    @objc
    public func presentProfileScreen() {
        showingProfileScreenSubject.onNext(true)
    }
    
    public func finishedViewingProfile() {
        showingProfileScreenSubject.onNext(false)
    }
    
    public func finishedLoading(with serverData: ServerData) {
        viewSubject.onNext(.dashboard)
    }
}
