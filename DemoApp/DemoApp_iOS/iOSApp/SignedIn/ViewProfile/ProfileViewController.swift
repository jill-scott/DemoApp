//
//  ProfileViewController.swift
//  DemoApp_iOS
//
//  Created by Jill Scott on 2/26/19.
//  Copyright © 2019 Jill Scott. All rights reserved.
//

import UIKit

public class ProfileViewController: UINavigationController {
    
    // MARK: - Methods
    init(contentViewController: ProfileContentViewController) {
        super.init(rootViewController: contentViewController)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
    }
    
    @available(*, unavailable, message: "Loading nibless view controllers from a nib is unsupported in favor of initializer dependency injection.")
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @available(*, unavailable, message: "Loading nibless view controllers from a nib is unsupported in favor of initializer dependency injection.")
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Loading nibless view controllers from a nib is unsupported in favor of initializer dependency injection.")
    }
}
