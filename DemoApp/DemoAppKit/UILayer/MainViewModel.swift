//
//  MainViewModel.swift
//  DemoAppKit
//
//  Created by Jill Scott on 2/25/19.
//  Copyright © 2019 Jill Scott. All rights reserved.
//

// Description: holds methods for main view, signed in and not signed in

import Foundation
import RxSwift

public class MainViewModel: SignedInResponder, NotSignedInResponder {
    
    // MARK: - Properties
    public var view: Observable<MainView> { return viewSubject.asObservable() }
    private let viewSubject = BehaviorSubject<MainView>(value: .launching)
    
    // MARK: - Methods
    public init() {}
    
    public func notSignedIn() {
        viewSubject.onNext(.onboarding)
    }
    
    public func signedIn(to userSession: UserSession) {
        viewSubject.onNext(.signedIn(userSession: userSession))
    }
}
