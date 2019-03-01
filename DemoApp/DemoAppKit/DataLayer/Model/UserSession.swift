//
//  UserSession.swift
//  DemoAppKit
//
//  Created by Jill Scott on 2/25/19.
//  Copyright © 2019 Jill Scott. All rights reserved.
//

// Description: Stores user session information including user profile and remote user session

import Foundation

public class UserSession: Codable {
    
    // MARK: - Properties
    public let profile: UserProfile
    public let remoteSession: RemoteUserSession
    
    // MARK: - Methods
    public init(profile: UserProfile, remoteSession: RemoteUserSession) {
        self.profile = profile
        self.remoteSession = remoteSession
    }
}

extension UserSession: Equatable {
    
    public static func ==(lhs: UserSession, rhs: UserSession) -> Bool {
        return lhs.profile == rhs.profile &&
               lhs.remoteSession == rhs.remoteSession
    }
}
