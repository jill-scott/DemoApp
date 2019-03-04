//
//  DemoAppSignedInDependencyContainer.swift
//  DemoApp_iOS
//
//  Created by Jill Scott on 2/26/19.
//  Copyright © 2019 Jill Scott. All rights reserved.
//

// Description: Dependencies for scope of user being signed in

import UIKit
import DemoAppUIKit
import DemoAppKit
import RxSwift

public class DemoAppSignedInDependencyContainer {
    
    // MARK: - Properties
    
    // From parent contianer
    let userSessionRepository: UserSessionRepository
    let mainViewModel: MainViewModel
    
    // Context
    let userSession: UserSession
    
    // Long-lived dependencies
    let signedInViewModel: SignedInViewModel
    //let imageCache: ImageCache
    let serverDataFinder: ServerDataFinder
    
    // MARK: - Methods
    public init(userSession: UserSession, appDependencyContainer: DemoAppDependencyContainer) {
        func makeSignedInViewModel() -> SignedInViewModel {
            return SignedInViewModel()
        }
//        func makeImageCache() -> ImageCache {
//            return InBundleImageCache()
//        }
        
        func makeServerDataFinder() -> ServerDataFinder {
            return FakeServerDataFinder()
        }
        
        self.userSessionRepository = appDependencyContainer.sharedUserSessionRepository
        self.mainViewModel = appDependencyContainer.sharedMainViewModel
        
        self.userSession = userSession
        
        self.signedInViewModel = makeSignedInViewModel()
        //self.imageCache = makeImageCache()
        self.serverDataFinder = makeServerDataFinder()
    }
    
    // Signed in
    public func makeSignedInViewController() -> SignedInViewController {
        let profileViewController = makeProfileViewController()
        return SignedInViewController(viewModel: signedInViewModel,
                                      userSession: userSession,
                                      profileViewController: profileViewController,
                                      viewControllerFactory: self)
    }
    
//    // Loading Dashboard
//    public func makeLoadingDashboardViewController() -> LoadingDashboardViewController {
//        return LoadingDashboardViewController(viewModelFactory: self)
//    }
//
//    public func makeLoadingDashboardViewModel() -> LoadingDashboardViewModel {
//        return LoadingDashboardViewModel(finishedLoadingDashboardResponder: signedInViewModel)
//    }
    
//    // Getting user's location
//    public func makeGettingUsersLocationViewController() -> GettingUsersLocationViewController {
//        return GettingUsersLocationViewController(viewModelFactory: self)
//    }
//
//    public func makeGettingUsersLocationViewModel() -> GettingUsersLocationViewModel {
//        return GettingUsersLocationViewModel(determinedPickUpLocationResponder: signedInViewModel,
//                                             locator: locator)
//    }
    
    //Loading
    
    public func makeLoadingViewController() -> LoadingViewController {
        return LoadingViewController(viewModelFactory: self)
    }
    
    public func makeLoadingViewModel() -> LoadingViewModel {
        return LoadingViewModel(finishedLoadingResponder: signedInViewModel, serverDataFinder: serverDataFinder)
    }
    
    // Dashboard
    
    public func makeDashboardViewController() -> DashboardViewController {
        let dashboardDependencyContainer = DemoAppDashboardDependencyContainer(signedInDependencyContainer: self)
        return dashboardDependencyContainer.makeDashboardViewController()
    }
    
//    // Pick-me-up
//    public func makePickMeUpViewController(pickupLocation: Location) -> PickMeUpViewController {
//        let pickMeUpDependencyContainer = KooberPickMeUpDependencyContainer(signedInDependencyContainer: self,
//                                                                            pickupLocation: pickupLocation)
//        return pickMeUpDependencyContainer.makePickMeUpViewController()
//    }
    
//    // Waiting for Pickup
//    public func makeWaitingForPickupViewController() -> WaitingForPickupViewController {
//        return WaitingForPickupViewController(viewModelFactory: self)
//    }
//
//    public func makeWaitingForPickupViewModel() -> WaitingForPickupViewModel {
//        return WaitingForPickupViewModel(goToNewRideNavigator: signedInViewModel)
//    }
    
    // View profile
    public func makeProfileViewController() -> ProfileViewController {
        let contentViewController = makeProfileContentViewController()
        return ProfileViewController(contentViewController: contentViewController)
    }
    
    private func makeProfileContentViewController() -> ProfileContentViewController {
        let viewModel = makeProfileViewModel()
        return ProfileContentViewController(viewModel: viewModel)
    }
    
    public func makeProfileViewModel() -> ProfileViewModel {
        return ProfileViewModel(userSession: userSession,
                                notSignedInResponder: mainViewModel,
                                doneWithProfileResponder: signedInViewModel,
                                userSessionRepository: userSessionRepository)
    }
}

extension DemoAppSignedInDependencyContainer: SignedInViewControllerFactory {}

extension DemoAppSignedInDependencyContainer: LoadingViewModelFactory {}
//, DashboardViewModelFactory {}

//extension DemoAppSignedInDependencyContainer: GettingUsersLocationViewModelFactory, WaitingForPickupViewModelFactory {}
