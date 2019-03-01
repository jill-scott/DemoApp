//
//  RemoteUserSession.swift
//  DemoAppKit
//
//  Created by Jill Scott on 2/25/19.
//  Copyright © 2019 Jill Scott. All rights reserved.
//

// Description: Holds user remote info, namely user auth token. Part of user session

import Foundation

public struct RemoteUserSession: Codable {
    
    // MARK: - Properties
    let token: AuthToken
    
    // MARK: - Methods
    public init(token: AuthToken) {
        self.token = token
    }
}

extension RemoteUserSession: Equatable {
    
    public static func ==(lhs: RemoteUserSession, rhs: RemoteUserSession) -> Bool {
        return lhs.token == rhs.token
    }
}
