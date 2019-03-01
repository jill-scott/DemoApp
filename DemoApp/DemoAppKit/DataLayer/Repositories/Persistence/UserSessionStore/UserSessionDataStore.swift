//
//  UserSessionDataStore.swift
//  DemoAppKit
//
//  Created by Jill Scott on 2/25/19.
//  Copyright © 2019 Jill Scott. All rights reserved.
//

// Description: Protocol for reading, saving, and deleting user session

import Foundation
import PromiseKit

public typealias AuthToken = String

public protocol UserSessionDataStore {
    
    func readUserSession() -> Promise<UserSession?>
    func save(userSession: UserSession) -> Promise<(UserSession)>
    func delete(userSession: UserSession) -> Promise<(UserSession)>
}
