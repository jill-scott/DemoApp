//
//  LaunchRootView.swift
//  DemoApp_iOS
//
//  Created by Jill Scott on 2/26/19.
//  Copyright © 2019 Jill Scott. All rights reserved.
//

import Foundation
import DemoAppUIKit
import DemoAppKit

class LaunchRootView: NiblessView {
    
    // MARK: - Properties
    let viewModel: LaunchViewModel
    
    //MARK: - Methods
    init(frame: CGRect = .zero,
         viewModel: LaunchViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        styleView()
        loadUserSession()
    }
    
    private func styleView() {
        backgroundColor = Color.background
    }
    
    private func loadUserSession() {
        viewModel.loadUserSession()
    }
    
}
