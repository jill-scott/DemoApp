//
//  FakeServerDataFinder.swift
//  DemoAppKit
//
//  Created by Jill Scott on 3/4/19.
//  Copyright © 2019 Jill Scott. All rights reserved.
//

import Foundation
import PromiseKit

public class FakeServerDataFinder: ServerDataFinder {
    
    // MARK: - Methods
    public init() {}
    
    public func getServerData() -> Promise<ServerData> {
        return Promise { seal in
            DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 2) {
                let serverData = ServerData(id: "0", latitude: -33.864308, longitude: 151.209146)
                seal.fulfill(serverData)
            }
        }
    }
}
