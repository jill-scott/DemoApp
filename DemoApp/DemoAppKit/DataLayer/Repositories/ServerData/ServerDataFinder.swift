//
//  ServerDataFinder.swift
//  DemoAppKit
//
//  Created by Jill Scott on 3/4/19.
//  Copyright © 2019 Jill Scott. All rights reserved.
//

import Foundation
import PromiseKit

public protocol ServerDataFinder {
    
    func getServerData() -> Promise<ServerData>
}
