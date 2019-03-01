//
//  ErrorMessagePresentation.swift
//  DemoAppUIKit
//
//  Created by Jill Scott on 2/27/19.
//  Copyright © 2019 Jill Scott. All rights reserved.
//

import Foundation
import DemoAppKit

extension UIViewController {
    
    public func present(_ errorMessage: ErrorMessage) {
        let alert = UIAlertController(title: errorMessage.title,
                                      message: errorMessage.message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension ErrorMessage {
    
    public static func makeUnknown() -> ErrorMessage {
        return ErrorMessage(title: "Unknown Issue",
                            message: "DemoApp ran into an unexpected issue, please try again or contact us.")
    }
}

