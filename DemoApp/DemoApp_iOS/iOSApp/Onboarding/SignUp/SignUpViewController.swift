//
//  SignUpViewController.swift
//  DemoApp_iOS
//
//  Created by Jill Scott on 2/27/19.
//  Copyright © 2019 Jill Scott. All rights reserved.
//

import UIKit
import DemoAppUIKit
import DemoAppKit
import RxSwift

public class SignUpViewController: NiblessViewController {
    
    // MARK: - Properties
    let viewModel: SignUpViewModel
    let disposeBag = DisposeBag()
    
    // MARK: - Methods
    init(viewModelFactory: SignUpViewModelFactory) {
        self.viewModel = viewModelFactory.makeSignUpViewModel()
        super.init()
    }
    
    public override func loadView() {
        view = SignUpRootView(viewModel: viewModel)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        observeErrorMessages()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addKeyboardObservers()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObservers()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        (view as! SignUpRootView).configureViewAfterLayout()
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

protocol SignUpViewModelFactory {
    
    func makeSignUpViewModel() -> SignUpViewModel
}

extension SignUpViewController {
    
    func addKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(handleContentUnderKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(handleContentUnderKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    func removeObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    @objc func handleContentUnderKeyboard(notification: Notification) {
        if let userInfo = notification.userInfo,
            let keyboardEndFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let convertedKeyboardEndFrame = view.convert(keyboardEndFrame.cgRectValue, from: view.window)
            if notification.name == UIResponder.keyboardWillHideNotification {
                (view as! SignUpRootView).moveContentForDismissedKeyboard()
            } else {
                (view as! SignUpRootView).moveContent(forKeyboardFrame: convertedKeyboardEndFrame)
            }
        }
    }
}

