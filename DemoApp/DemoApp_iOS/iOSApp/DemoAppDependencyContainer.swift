//
//  DemoAppDependencyContainer.swift
//  DemoApp
//
//  Created by Jill Scott on 2/25/19.
//  Copyright © 2019 Jill Scott. All rights reserved.
//

// Description: These are long-lived dependencies that exist as long as the app does

import UIKit
import DemoAppKit
import RealmSwift

public class DemoAppDependencyContainer {
    
    // MARK: - Properties
    
    // Long-lived dependencies
    let sharedUserSessionRepository: UserSessionRepository
    let sharedMainViewModel = MainViewModel()
    
    // MARK: - Methods
    
    public init() {
        // The following functions must be placed within the init so we can create our initializers
        // for the class's properties
        
        func makeUserSessionRepository() -> UserSessionRepository {
            let dataStore = makeUserSessionDataStore()
            let remoteAPI = makeAuthRemoteAPI()
            return DemoAppUserSessionRepository(dataStore: dataStore,
                                               remoteAPI: remoteAPI)
        }
        
        func makeUserSessionDataStore() -> UserSessionDataStore {
            #if USER_SESSION_DATASTORE_FILEBASED
            return FileUserSessionDataStore()
            
            #else
            //let coder = makeUserSessionCoder()
            //return KeychainUserSessionDataStore(userSessionCoder: coder)
            
            let realm = makeUserSessionRealm()
            return RealmUserSessionDataStore(realm: realm)
            #endif
        }
        
        func makeUserSessionCoder() -> UserSessionCoding {
            return UserSessionPropertyListCoder()
        }
        
        func makeAuthRemoteAPI() -> AuthRemoteAPI {
            return FakeAuthRemoteAPI()
        }
        
        func makeUserSessionRealm() -> Realm {
            RealmMigration.performRealmMigration()
            
            do {
                guard let identifier = Bundle.main.infoDictionary?["ENVIRONMENT"] as? String else {
                    fatalError("ENVIRONMENT variable not found.")
                }
                
                var config = Realm.Configuration()
                config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("\(identifier).realm")
                return try Realm(configuration: config)
            } catch {
                debugPrint("Unable to initalize Realm!  Fatal Error!")
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
        
        self.sharedUserSessionRepository = makeUserSessionRepository()
    }
    
    // Main
    // Factories needed to create a MainViewController
    
    public func makeMainViewController() -> MainViewController {
        let launchViewController = makeLaunchViewController()
        
        let onboardingViewControllerFactory = {
            return self.makeOnboardingViewController()
        }
        
        let signedInViewControllerFactory = { (userSession: UserSession) in
            return self.makeSignedInViewController(session: userSession)
        }
        
        return MainViewController(viewModel: sharedMainViewModel,
                                  launchViewController: launchViewController,
                                  onboardingViewControllerFactory: onboardingViewControllerFactory,
                                  signedInViewControllerFactory: signedInViewControllerFactory)
    }
    
    // Launching
    // Factories needed to make a LaunchViewController
    
    public func makeLaunchViewController() -> LaunchViewController {
        return LaunchViewController(launchViewModelFactory: self)
    }
    
    public func makeLaunchViewModel() -> LaunchViewModel {
        return LaunchViewModel(userSessionRepository: sharedUserSessionRepository,
                               notSignedInResponder: sharedMainViewModel,
                               signedInResponder: sharedMainViewModel)
    }
    
    // Onboarding (signed out)
    // Factories needed to create an OnboardingViewController
    
    public func makeOnboardingViewController() -> OnboardingViewController {
        let dependencyContainer = DemoAppOnboardingDependencyContainer(appDependencyContainer: self)
        return dependencyContainer.makeOnboardingViewController()
    }
    
    // Signed In
    // Factories needed to make SignedInViewController
    
    public func makeSignedInViewController(session: UserSession) ->
        SignedInViewController {
            let dependencyContainer = makeSignedInDependencyContainer(session: session)
            return dependencyContainer.makeSignedInViewController()
    }
    
    public func makeSignedInDependencyContainer(session: UserSession) ->
        DemoAppSignedInDependencyContainer {
            return DemoAppSignedInDependencyContainer(userSession: session,
                                                      appDependencyContainer: self)
    }
}

extension DemoAppDependencyContainer: LaunchViewModelFactory {}
