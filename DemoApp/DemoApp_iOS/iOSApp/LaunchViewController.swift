//
//  LaunchViewController.swift
//  DemoApp_iOS
//
//  Created by Jill Scott on 2/26/19.
//  Copyright © 2019 Jill Scott. All rights reserved.
//

// Description: Launch viewController and factory method

import UIKit
import DemoAppUIKit
import DemoAppKit
import RxCocoa
import RxSwift

public class LaunchViewController: NiblessViewController {
    
    // MARK: - Properties
    let viewModel: LaunchViewModel
    let disposeBag = DisposeBag()
    
    // MARK: - Methods
    init(launchViewModelFactory: LaunchViewModelFactory) {
        self.viewModel = launchViewModelFactory.makeLaunchViewModel()
        super.init()
    }
    
    public override func loadView() {
        view = LaunchRootView(viewModel: viewModel)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        observeErrorMessages()
    }
    
    func observeErrorMessages() {
        viewModel
            .errorMessages
            .asDriver { _ in fatalError("Unexpected error from error messages observable")
                }
            .drive(onNext: { [weak self] errorMessage in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.present(errorMessage: errorMessage,
                                   withPresentationState: strongSelf.viewModel.errorPresentation)
            })
            .disposed(by: disposeBag)
    }
}

protocol LaunchViewModelFactory {
    func makeLaunchViewModel() -> LaunchViewModel
}
