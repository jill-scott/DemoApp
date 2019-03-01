//
//  OnboardingView.swift
//  DemoAppKit
//
//  Created by Jill Scott on 2/27/19.
//  Copyright © 2019 Jill Scott. All rights reserved.
//

import Foundation

public enum OnboardingView {
    
    case welcome
    case signin
    case signup
    
    public func hidesNavigationBar() -> Bool {
        switch self {
        case .welcome:
            return true
        default:
            return false
        }
    }
}

