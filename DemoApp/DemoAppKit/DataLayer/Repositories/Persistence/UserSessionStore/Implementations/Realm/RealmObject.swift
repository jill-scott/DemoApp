//
//  RealmObject.swift
//  DemoAppKit
//
//  Created by Jill Scott on 3/4/19.
//  Copyright © 2019 Jill Scott. All rights reserved.
//

import Foundation

class RealmItem {
    
//    // MARK: - Properties
//    let service: NSString = "DemoAppCloud"
//    let itemClass = kSecClass as String
//    let itemService = kSecAttrService as String
//
//    // MARK: - Methods
//    func asDictionary() -> CFDictionary {
//        let item: [String: AnyObject] = [itemClass: kSecClassGenericPassword,
//                                         itemService: service]
//        return item as CFDictionary
//    }
}

class RealmItemWithData: RealmItem {
    
//    // MARK: - Properties
//    let data: AnyObject
//    let itemData = kSecValueData as String
//    
//    // MARK: - Methods
//    init(data: Data) {
//        self.data = data as AnyObject
//    }
//    
//    override func asDictionary() -> CFDictionary {
//        let item: [String: AnyObject] = [itemClass: kSecClassGenericPassword,
//                                         itemService: service,
//                                         itemData: data]
//        return item as CFDictionary
//    }
//    
//    func attributesAsDictionary() -> CFDictionary {
//        let attributes: [String: AnyObject] = [itemClass: kSecClassGenericPassword,
//                                               itemService: service]
//        return attributes as CFDictionary
//    }
//    
//    func dataAsDictionary() -> CFDictionary {
//        let justData: [String: AnyObject] = [itemData: data]
//        return justData as CFDictionary
//    }
}

class RealmItemQuery: RealmItem {
    
//    // MARK: - Properties
//    let matchLimit = kSecMatchLimit as String
//    let returnData = kSecReturnData as String
//
//    // MARK: - Methods
//    override func asDictionary() -> CFDictionary {
//        let query: [String: AnyObject] = [itemClass: kSecClassGenericPassword,
//                                          itemService: service,
//                                          matchLimit: kSecMatchLimitOne,
//                                          returnData: kCFBooleanTrue]
//        return query as CFDictionary
//    }
}
