//
//  UserSessionCoding.swift
//  DemoAppKit
//
//  Created by Jill Scott on 2/26/19.
//  Copyright © 2019 Jill Scott. All rights reserved.
//

// Description: Encode and decode protocol for user session

import Foundation

public protocol UserSessionCoding {
    
    func encode(userSession: UserSession) -> Data
    func decode(data: Data) -> UserSession
}
