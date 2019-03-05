//
//  LoadingViewController.swift
//  DemoApp_iOS
//
//  Created by Jill Scott on 3/4/19.
//  Copyright © 2019 Jill Scott. All rights reserved.
//

import UIKit
import DemoAppUIKit
import DemoAppKit
import RxSwift
import RxCocoa

public class LoadingViewController: NiblessViewController {
    
    // MARK: - Properties
    let viewModel: LoadingViewModel
    let disposeBag = DisposeBag()
    
    // MARK: - Methods
    init(viewModelFactory: LoadingViewModelFactory) {
        self.viewModel = viewModelFactory.makeLoadingViewModel()
        super.init()
    }
    
    override public func loadView() {
        view = LoadingRootView(viewModel: viewModel)
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

protocol LoadingViewModelFactory {
    
    func makeLoadingViewModel() -> LoadingViewModel
}

