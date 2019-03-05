//
//  ServerData.swift
//  DemoAppKit
//
//  Created by Jill Scott on 3/4/19.
//  Copyright © 2019 Jill Scott. All rights reserved.
//

import Foundation

public typealias ServerDataID = String

public struct ServerData: Identifiable, Equatable, Codable {
    
    // MARK: - Properties
    public internal(set) var id: ServerDataID
    public internal(set) var latitude: Double
    public internal(set) var longitude: Double
    
    // MARK: - Methods
    public init(id: ServerDataID, latitude: Double, longitude: Double) {
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
    }
}
