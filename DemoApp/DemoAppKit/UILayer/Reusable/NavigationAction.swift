//
//  NavigationAction.swift
//  DemoAppKit
//
//  Created by Jill Scott on 2/27/19.
//  Copyright © 2019 Jill Scott. All rights reserved.
//

import Foundation

public enum NavigationAction<ViewModelType>: Equatable where ViewModelType: Equatable {
    
    case present(view: ViewModelType)
    case presented(view: ViewModelType)
}
