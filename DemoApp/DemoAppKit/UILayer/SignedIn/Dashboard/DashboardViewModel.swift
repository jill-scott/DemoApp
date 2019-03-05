//
//  DashboardViewModel.swift
//  DemoAppKit
//
//  Created by Jill Scott on 3/4/19.
//  Copyright © 2019 Jill Scott. All rights reserved.
//

import Foundation
import RxSwift

public class DashboardViewModel {
    
    // MARK: - Properties
    public var view: Observable<DashboardView> { return viewSubject.asObservable() }
    private let viewSubject: BehaviorSubject<DashboardView>
    
    public var shouldDisplayInitialInfo: Observable<Bool> { return shouldDisplayInitialInfoSubject.asObservable() }
    private let shouldDisplayInitialInfoSubject = BehaviorSubject<Bool>(value: true)
    public var errorMessages: Observable<ErrorMessage> { return errorMessagesSubject.asObservable() }
    private let errorMessagesSubject = PublishSubject<ErrorMessage>()
    public let errorPresentation: BehaviorSubject<ErrorPresentation?> = BehaviorSubject(value: nil)
    
    let disposeBag = DisposeBag()
    
    // MARK: - Methods
    public init(shouldDisplayInitialInfo: Bool = true) {
        self.shouldDisplayInitialInfoSubject.onNext(shouldDisplayInitialInfo)
        self.viewSubject = BehaviorSubject(value: .initial)
        
        viewSubject
            .asObservable()
            .subscribe(onNext: { [weak self] view in
                self?.updateShouldDisplayInitialInfo(basedOn: view)
            })
            .disposed(by: disposeBag)
    }
    
    func updateShouldDisplayInitialInfo(basedOn view: DashboardView) {
        shouldDisplayInitialInfoSubject.onNext(shouldDisplayInitialInfo(during: view))
    }
    
    func shouldDisplayInitialInfo(during view: DashboardView) -> Bool {
        switch view {
        case .initial:
            return true
        case .final:
            return false
        }
    }
    
    @objc public func showProcessedDashboard() {
        debugPrint("OK")
    }
    
//    public func dropOffUser(at location: Location) {
//        guard case let .initial(pickupLocation) = progress else {
//            fatalError()
//        }
//        let waypoints = NewRideWaypoints(pickupLocation: pickupLocation,
//                                         dropoffLocation: location)
//        progress = .waypointsDetermined(waypoints: waypoints)
//        viewSubject.onNext(.selectRideOption)
//        mapViewModel.dropoffLocation.onNext(location)
//    }
    
//    public func pickUpUser(in rideOptionID: RideOptionID) {
//        if case let .waypointsDetermined(waypoints) = progress {
//            let rideRequest = NewRideRequest(waypoints: waypoints,
//                                             rideOptionID: rideOptionID)
//            progress = .rideRequestReady(rideRequest: rideRequest)
//            viewSubject.onNext(.confirmRequest)
//        } else if case let .rideRequestReady(oldRideRequest) = progress {
//            let rideRequest = NewRideRequest(waypoints: oldRideRequest.waypoints,
//                                             rideOptionID: rideOptionID)
//            progress = .rideRequestReady(rideRequest: rideRequest)
//            viewSubject.onNext(.confirmRequest)
//        } else {
//            fatalError()
//        }
//    }
    
//    @objc
//    public func showSelectDropoffLocationView() {
//        viewSubject.onNext(.selectDropoffLocation)
//    }
//
//    @objc
//    public func sendRideRequest() {
//        guard case let .rideRequestReady(rideRequest) = progress else {
//            fatalError()
//        }
//        viewSubject.onNext(.sendingRideRequest)
//        newRideRepository.request(newRide: rideRequest)
//            .done {
//                self.viewSubject.onNext(.final)
//            }.catch { error in
//                self.goToNextScreenAfterErrorPresentation()
//                let errorMessage = ErrorMessage(title: "Ride Request Error",
//                                                message: "There was an error trying to confirm your ride request.\nPlease try again.")
//                self.errorMessagesSubject.onNext(errorMessage)
//        }
//    }
//
//    public func finishedSendingNewRideRequest() {
//        newRideRequestAcceptedResponder.newRideRequestAccepted()
//    }
//
//    func goToNextScreenAfterErrorPresentation() {
//        _ = errorPresentation
//            .filter { $0 == .dismissed }
//            .take(1)
//            .subscribe(onNext: { [weak self] _ in
//                self?.viewSubject.onNext(PickMeUpView.confirmRequest)
//            })
//    }
}

