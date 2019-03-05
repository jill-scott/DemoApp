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
    let serverDataFinder: ServerDataFinder
    
    // MARK: - Methods
    public init(finishedLoadingResponder: FinishedLoadingResponder, serverDataFinder: ServerDataFinder) {
               // , locator: Locator) {
        self.finishedLoadingResponder = finishedLoadingResponder
        self.serverDataFinder = serverDataFinder
    }
    
    public var errorMessages: Observable<ErrorMessage> {
        return errorMessagesSubject.asObserver()
    }
    private let errorMessagesSubject = PublishSubject<ErrorMessage>()
    
    public func getServerData() {
        serverDataFinder
            .getServerData()
            .done(finishedLoadingResponder.finishedLoading(with:))
            .catch { error in
                let errorMessage = ErrorMessage(title: "Error Getting Location",
                                                message: "Could not get your location. Please check location settings and try again.")
                self.errorMessagesSubject.onNext(errorMessage)
        }
    }
}
