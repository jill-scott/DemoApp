//
//  NiblessViewController.swift
//  DemoAppUIKit
//
//  Created by Jill Scott on 2/26/19.
//  Copyright © 2019 Jill Scott. All rights reserved.
//

// Description: Viewcontroller presented without loading via nib

import UIKit

open class NiblessViewController: UIViewController {
    
    // MARK: - Methods
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable, message:
               "Loading this view controller from a nib is unsupported in favor of initializer dependency injection.")
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @available(*, unavailable,
    message: "Loading this view controller from a nib is unsupported in favor of initializer dependency injection."
    )
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Loading this view controller from a nib is unsupported in favor of initializer dependency injection.")
    }
}
