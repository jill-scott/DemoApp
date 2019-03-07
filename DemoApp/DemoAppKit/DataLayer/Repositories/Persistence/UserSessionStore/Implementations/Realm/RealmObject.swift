//
//  RealmObject.swift
//  DemoAppKit
//
//  Created by Jill Scott on 3/5/19.
//  Copyright © 2019 Jill Scott. All rights reserved.
//

import Foundation
import RealmSwift

class RealmObject: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var type: String = ""
        
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience public init(type: RealmObjectType, id: String) {
        self.init()
        
        self.id = createID(type: type, id: id)
        self.type = type.rawValue
    }
}

enum RealmObjectType: String {
    case user = "user"
}

extension RealmObject {
    func createID(type: RealmObjectType, id: String) -> String {
        return "\(type)-\(id)"
    }
    
    func getType() -> RealmObjectType? {
        return RealmObjectType(rawValue: type)
    }
}
