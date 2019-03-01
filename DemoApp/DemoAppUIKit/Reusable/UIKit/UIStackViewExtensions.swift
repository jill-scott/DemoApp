//
//  UIStackViewExtensions.swift
//  DemoAppUIKit
//
//  Created by Jill Scott on 2/27/19.
//  Copyright © 2019 Jill Scott. All rights reserved.
//

import UIKit

extension UIStackView {
    
    // MARK: - Methods
    public func removeAllArangedSubviews() {
        arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
}
