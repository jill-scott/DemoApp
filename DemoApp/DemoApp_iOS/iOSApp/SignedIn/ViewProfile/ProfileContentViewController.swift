//
//  ProfileContentViewController.swift
//  DemoApp_iOS
//
//  Created by Jill Scott on 2/26/19.
//  Copyright © 2019 Jill Scott. All rights reserved.
//

import UIKit
import DemoAppUIKit
import DemoAppKit
import RxSwift

public class ProfileContentViewController: NiblessViewController {
    
    // MARK: - Properties
    let viewModel: ProfileViewModel
    let disposeBag = DisposeBag()
    
    // MARK: - Methods
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init()
        
        self.navigationItem.title = "My Profile"
        self.navigationItem.rightBarButtonItem =
            UIBarButtonItem(barButtonSystemItem: .done,
                            target: viewModel,
                            action: #selector(ProfileViewModel.dismiss))
    }
    
    public override func loadView() {
        view = ProfileContentRootView(viewModel: viewModel)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        observeErrorMessages()
    }
    
    func observeErrorMessages() {
        viewModel
            .errorMessages
            .asDriver { _ in fatalError("Unexpected error from error messages observable.") }
            .drive(onNext: { [weak self] errorMessage in
                self?.present(errorMessage: errorMessage)
            })
            .disposed(by: disposeBag)
    }
}
