//
//  DemoAppDashboardDependencyContainer.swift
//  DemoApp_iOS
//
//  Created by Jill Scott on 3/4/19.
//  Copyright © 2019 Jill Scott. All rights reserved.
//

import UIKit
import DemoAppUIKit
import DemoAppKit

public class DemoAppDashboardDependencyContainer {
    
    // MARK: - Properties
    
    // From parent container
    //let imageCache: ImageCache
    let signedInViewModel: SignedInViewModel
    
    // Context
    //let pickupLocation: Location
    
    // Long-lived dependencies
//    let mapViewModel: PickMeUpMapViewModel
//    let newRideRemoteAPI: NewRideRemoteAPI
//    let newRideRepository: NewRideRepository
//    let rideOptionDataStore: RideOptionDataStore
    let dashboardViewModel: DashboardViewModel
    
    // MARK: - Methods
    init(signedInDependencyContainer: DemoAppSignedInDependencyContainer) {
    //,pickupLocation: Location) {
//        func makePickMeUpMapViewModel() -> PickMeUpMapViewModel {
//            return PickMeUpMapViewModel(pickupLocation: pickupLocation)
//        }
//        func makeNewRideRemoteAPI() -> NewRideRemoteAPI {
//            return FakeNewRideRemoteAPI()
//        }
//        func makeNewRideRepository(newRideRemoteAPI: NewRideRemoteAPI) -> NewRideRepository {
//            let newRideRemoteAPI = makeNewRideRemoteAPI()
//            return KooberNewRideRepository(remoteAPI: newRideRemoteAPI)
//        }
//        func makeRideOptionDataStore() -> RideOptionDataStore {
//            return RideOptionDataStoreInMemory()
//        }
        func makeDashboardViewModel() -> DashboardViewModel {
            return DashboardViewModel()
        }
        
        //self.imageCache = signedInDependencyContainer.imageCache
        self.signedInViewModel = signedInDependencyContainer.signedInViewModel
        
        //self.pickupLocation = pickupLocation
        
        //self.mapViewModel = makePickMeUpMapViewModel()
        //self.newRideRemoteAPI = makeNewRideRemoteAPI()
        //self.newRideRepository = makeNewRideRepository(newRideRemoteAPI: self.newRideRemoteAPI)
        //self.rideOptionDataStore = makeRideOptionDataStore()
        self.dashboardViewModel = makeDashboardViewModel()
    }
    
    // Pick-me-up (container view controller)
    public func makeDashboardViewController() -> DashboardViewController {
//        let mapViewController = makePickMeUpMapViewController()
//        let rideOptionPickerViewController = makeRideOptionPickerViewController()
//        let sendingRideRequestViewController = makeSendingRideRequestViewController()
        return DashboardViewController(viewModel: dashboardViewModel,
                                      viewControllerFactory: self)
    }
    
//    // Map
//    func makePickMeUpMapViewController() -> PickMeUpMapViewController {
//        return PickMeUpMapViewController(viewModelFactory: self,
//                                         imageCache: imageCache)
//    }
//
//    public func makePickMeUpMapViewModel() -> PickMeUpMapViewModel {
//        return mapViewModel
//    }
    
//    // Dropoff location picker
//    public func makeDropoffLocationPickerViewController() -> DropoffLocationPickerViewController {
//        let contentViewController = makeDropoffLocationPickerContentViewController()
//        return DropoffLocationPickerViewController(contentViewController: contentViewController)
//    }
//
//    func makeDropoffLocationPickerContentViewController() -> DropoffLocationPickerContentViewController {
//        return DropoffLocationPickerContentViewController(pickupLocation: pickupLocation,
//                                                          viewModel: makeDropoffLocationPickerViewModel())
//    }
//
//    public func makeDropoffLocationPickerViewModel() -> DropoffLocationPickerViewModel {
//        let repository = makeLocationRepository()
//        return DropoffLocationPickerViewModel(pickupLocation: pickupLocation,
//                                              locationRepository: repository,
//                                              dropoffLocationDeterminedResponder: pickMeUpViewModel,
//                                              cancelDropoffLocationSelectionResponder: pickMeUpViewModel)
//    }
//
//    public func makeLocationRepository() -> LocationRepository {
//        return KooberLocationRepository(remoteAPI: newRideRemoteAPI)
//    }
//
//    // Ride-option picker
//    public func makeRideOptionPickerViewController() -> RideOptionPickerViewController {
//        return RideOptionPickerViewController(pickupLocation: pickupLocation,
//                                              imageCache: imageCache,
//                                              viewModelFactory: self)
//    }
//
//    public func makeRideOptionPickerViewModel() -> RideOptionPickerViewModel {
//        let repository = makeRideOptionRepository()
//        return RideOptionPickerViewModel(repository: repository,
//                                         rideOptionDeterminedResponder: pickMeUpViewModel)
//    }
//
//    public func makeRideOptionRepository() -> RideOptionRepository {
//        return KooberRideOptionRepository(remoteAPI: newRideRemoteAPI,
//                                          datastore: rideOptionDataStore)
//    }
//
//    // Sending ride request
//    public func makeSendingRideRequestViewController() -> SendingRideRequestViewController {
//        return SendingRideRequestViewController()
//    }
}

extension DemoAppDashboardDependencyContainer: DashboardViewControllerFactory {}

