//
//  SignedInResponder.swift
//  DemoAppKit
//
//  Created by Jill Scott on 2/25/19.
//  Copyright © 2019 Jill Scott. All rights reserved.
//

// Description: protocol for signedIn function

import Foundation

public protocol SignedInResponder {
    
    func signedIn(to userSession: UserSession)
}
