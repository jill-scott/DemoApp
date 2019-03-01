//
//  AuthRemoteAPI.swift
//  DemoAppKit
//
//  Created by Jill Scott on 2/26/19.
//  Copyright © 2019 Jill Scott. All rights reserved.
//

// Description: Protocol for auth remote api

import Foundation
import PromiseKit

public protocol AuthRemoteAPI {
    
    func signIn(username: String, password: String) -> Promise<UserSession>
    func signUp(account: NewAccount) -> Promise<UserSession>
}
