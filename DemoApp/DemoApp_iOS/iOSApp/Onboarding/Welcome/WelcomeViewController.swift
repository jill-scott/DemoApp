//
//  WelcomeViewController.swift
//  DemoApp_iOS
//
//  Created by Jill Scott on 2/27/19.
//  Copyright © 2019 Jill Scott. All rights reserved.
//

import UIKit
import DemoAppUIKit
import DemoAppKit

public class WelcomeViewController: NiblessViewController {
    
    // MARK: - Properties
    let welcomeViewModelFactory: WelcomeViewModelFactory
    
    // MARK: - Methods
    init(welcomeViewModelFactory: WelcomeViewModelFactory) {
        self.welcomeViewModelFactory = welcomeViewModelFactory
        super.init()
    }
    
    public override func loadView() {
        let viewModel = welcomeViewModelFactory.makeWelcomeViewModel()
        view = WelcomeRootView(viewModel: viewModel)
    }
}

protocol WelcomeViewModelFactory {
    
    func makeWelcomeViewModel() -> WelcomeViewModel
}

