//
//  RealmUser.swift
//  DemoAppKit
//
//  Created by Jill Scott on 3/5/19.
//  Copyright © 2019 Jill Scott. All rights reserved.
//

import Foundation
import RealmSwift

class RealmUser: RealmObject {
    
    @objc dynamic var name = ""
    @objc dynamic var email = ""
    @objc dynamic var mobileNumber = ""
    @objc dynamic var avatarString = ""
    @objc dynamic var authToken = ""
    
    convenience init(id: String, userSession: UserSession) {
        self.init(type: RealmObjectType.user, id: id)
        self.name = userSession.profile.name
        self.email = userSession.profile.email
        self.avatarString = userSession.profile.avatar.absoluteString
        self.authToken = userSession.remoteSession.token
    }
    
}

// MARK: - Functions

extension RealmUser {
    
    // This shouldn't be here. It knows too much!
    func toUserSession() -> UserSession? {
        if let avatarURL = URL(string: avatarString) {
            let userProfile = UserProfile(name: name, email: email, mobileNumber: mobileNumber, avatar: avatarURL)
            let userSession = RemoteUserSession(token: authToken)
            return UserSession(profile: userProfile, remoteSession: userSession)
        }
        return nil
    }
}
