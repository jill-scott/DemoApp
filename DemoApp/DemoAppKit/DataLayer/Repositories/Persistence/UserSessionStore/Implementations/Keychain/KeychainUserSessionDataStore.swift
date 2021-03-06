//
//  KeychainUserSessionDataStore.swift
//  DemoAppKit
//
//  Created by Jill Scott on 2/26/19.
//  Copyright © 2019 Jill Scott. All rights reserved.
//

// Description: Saves user session data to keychain

import Foundation
import PromiseKit

public class KeychainUserSessionDataStore: UserSessionDataStore {
    
    // MARK: - Properties
    let userSessionCoder: UserSessionCoding
    
    // MARK: - Methods
    public init(userSessionCoder: UserSessionCoding) {
        self.userSessionCoder = userSessionCoder
    }
    
    public func readUserSession() -> Promise<UserSession?> {
        return Promise<UserSession?> { seal in
            DispatchQueue.global().async {
                self.readUserSessionSync(seal: seal)
            }
        }
    }
    
    public func save(userSession: UserSession) -> Promise<(UserSession)> {
        let data = userSessionCoder.encode(userSession: userSession)
        let item = KeychainItemWithData(data: data)
        return self.readUserSession()
            .map { userSessionFromKeychain -> UserSession in
                if userSessionFromKeychain == nil {
                    try Keychain.save(item: item)
                } else {
                    try Keychain.update(item: item)
                }
                return userSession
        }
    }
    
    public func delete(userSession: UserSession) -> Promise<(UserSession)> {
        return Promise<UserSession> { seal in
            DispatchQueue.global().async {
                self.deleteSync(userSession: userSession, seal: seal)
            }
        }
    }
}

extension KeychainUserSessionDataStore {
    
    func readUserSessionSync(seal: Resolver<UserSession?>) {
        do {
            let query = KeychainItemQuery()
            if let data = try Keychain.findItem(query: query) {
                let userSession = self.userSessionCoder.decode(data: data)
                seal.fulfill(userSession)
            } else {
                seal.fulfill(nil)
            }
        } catch {
            seal.reject(error)
        }
    }
    
    func deleteSync(userSession: UserSession, seal: Resolver<UserSession>) {
        do {
            let item = KeychainItem()
            try Keychain.delete(item: item)
            seal.fulfill(userSession)
        } catch {
            seal.reject(error)
        }
    }
}

enum KeychainUserSessionDataStoreError: Error {
    
    case typeCast
    case unknown
}
