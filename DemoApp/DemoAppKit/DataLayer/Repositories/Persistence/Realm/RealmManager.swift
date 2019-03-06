//
//  RealmManager.swift
//  DemoAppKit
//
//  Created by Jill Scott on 3/5/19.
//  Copyright © 2019 Jill Scott. All rights reserved.
//

import Foundation
import RealmSwift

public class RealmManager {
    
    // MARK: - Properties
    let realm: Realm
    
    // MARK: - Methods
    public init(realm: Realm) {
        self.realm = realm
    }
    
    // Find
    
    func findRealmObject(object: RealmObject) -> RealmObject? {
        return realm.objects(RealmObject.self).first(where: { $0.id == object.id })
    }
    
    // Find Object by Type
    
    func findRealmObjectByType(type: RealmObjectType) -> RealmObject? {
        return realm.objects(RealmObject.self).first(where: { $0.type == type.rawValue })
    }
    
    // Replace
    
    func replaceRealmObject(object: RealmObject) {
        let prevObject = realm.objects(RealmObject.self).first(where: { $0.type == object.type })
        guard let previousValue = prevObject else { return }
        do {
            try realm.write {
                realm.delete(previousValue)
                realm.add(object, update: true)
                debugPrint("Wrote to realm successfully!")
            }
        } catch {
            debugPrint("Error when replacing object: \(error)")
        }
    }
    
    // Add/Update
    
    func addOrUpdateRealmObject(object: RealmObject) {
        do {
            try realm.write {
                realm.add(object, update: true)
            }
        } catch {
            debugPrint("Error when adding object: \(error)")
        }
    }
    
    // Delete
    
    func deleteRealmObject(object: RealmObject) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            debugPrint("Error deleting all realm data: \(error)")
        }
    }
    
}

enum RealmUserSessionDataStoreError: Error {
    
    case typeCast
    case unknown
}

