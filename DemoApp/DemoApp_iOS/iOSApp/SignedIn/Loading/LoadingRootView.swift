//
//  LoadingRootView.swift
//  DemoApp_iOS
//
//  Created by Jill Scott on 3/4/19.
//  Copyright © 2019 Jill Scott. All rights reserved.
//

import UIKit
import DemoAppUIKit
import DemoAppKit

public class LoadingRootView: NiblessView {
    
    // MARK: - Properties
    let viewModel: LoadingViewModel
    
    let appLogoImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "thumbs-up"))
        imageView.backgroundColor = Color.background
        return imageView
    }()
    
    let gettingLocationLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.text = "Loading dashboard..."
        label.textColor = .white
        return label
    }()
    
    // MARK: - Methods
    init(frame: CGRect = .zero,
         viewModel: LoadingViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        viewModel.finishedLoading()
    }
    
    public override func didMoveToWindow() {
        super.didMoveToWindow()
        backgroundColor = Color.background
        constructHierarchy()
        activateConstraints()
    }
    
    func constructHierarchy() {
        addSubview(appLogoImageView)
        addSubview(gettingLocationLabel)
    }
    
    func activateConstraints() {
        activateConstraintsAppLogo()
        activateConstraintsLocationLabel()
    }
    
    func activateConstraintsAppLogo() {
        appLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        let centerY = appLogoImageView.centerYAnchor
            .constraint(equalTo: centerYAnchor)
        let centerX = appLogoImageView.centerXAnchor
            .constraint(equalTo: centerXAnchor)
        NSLayoutConstraint.activate([centerY, centerX])
    }
    
    func activateConstraintsLocationLabel() {
        gettingLocationLabel.translatesAutoresizingMaskIntoConstraints = false
        let topY = gettingLocationLabel.topAnchor
            .constraint(equalTo: appLogoImageView.bottomAnchor, constant: 30)
        let centerX = gettingLocationLabel.centerXAnchor
            .constraint(equalTo: centerXAnchor)
        NSLayoutConstraint.activate([topY, centerX])
    }
}
