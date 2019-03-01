//
//  UserSessionPropertyListCoder.swift
//  DemoAppKit
//
//  Created by Jill Scott on 2/26/19.
//  Copyright © 2019 Jill Scott. All rights reserved.
//

// Description: plist encoder/decoder for user session

import Foundation

public class UserSessionPropertyListCoder: UserSessionCoding {
    
    // MARK: - Methods
    public init() {}
    
    public func encode(userSession: UserSession) -> Data {
        return try! PropertyListEncoder().encode(userSession)
    }
    
    public func decode(data: Data) -> UserSession {
        return try! PropertyListDecoder().decode(UserSession.self, from: data)
    }
}
