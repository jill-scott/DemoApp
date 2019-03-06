//
//  RealmUserSessionDataStore.swift
//  DemoAppKit
//
//  Created by Jill Scott on 3/4/19.
//  Copyright © 2019 Jill Scott. All rights reserved.
//

import Foundation
import PromiseKit

import Foundation
import PromiseKit
import RealmSwift

public class RealmUserSessionDataStore: UserSessionDataStore {
    
    // MARK: - Properties
    let realmManager: RealmManager
    
    // MARK: - Methods
    public init(realm: Realm) {
        self.realmManager = RealmManager(realm: realm)
    }
    
    public func readUserSession() -> Promise<UserSession?> {
        return Promise<UserSession?> { seal in
            DispatchQueue.main.async {
                self.readUserSessionSync(seal: seal)
            }
        }
    }
    
    // Realm Object
    
    // check this one
    public func save(userSession: UserSession) -> Promise<(UserSession)> {
        return self.readUserSession()
            .map { [weak self] _ -> UserSession in
                self?.realmManager.addOrUpdateRealmObject(object: RealmUser(id: userSession.profile.email, userSession: userSession))
                debugPrint("Saved User Session")
                return userSession
        }
    }
    
    public func delete(userSession: UserSession) -> Promise<(UserSession)> {
        return Promise<UserSession> { seal in
            DispatchQueue.main.async {
                self.deleteSync(userSession: userSession, seal: seal)
            }
        }
    }
}

extension RealmUserSessionDataStore {
    
    func readUserSessionSync(seal: Resolver<UserSession?>) {
        if let realmUser = realmManager.findRealmObjectByType(type: RealmObjectType.user) as? RealmUser {
            let userSession = realmUser.toUserSession()
            seal.fulfill(userSession)
        } else {
            seal.fulfill(nil)
        }
    }
    
    func deleteSync(userSession: UserSession, seal: Resolver<UserSession>) {
        
        let realmUser = RealmUser(id: userSession.profile.email, userSession: userSession)
        realmManager.deleteRealmObject(object: realmUser)
        seal.fulfill(userSession)
    }
}
