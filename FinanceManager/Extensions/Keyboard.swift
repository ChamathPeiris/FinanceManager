//
//  HideKeyboard.swift
//  FinanceManager
//
//  Created by Chamath Peiris on 2022-04-09.
//

import Foundation
import UIKit

extension UIViewController {
    
    
    /// Hides the keyboard when touching outside of a textfield area
    /// (https://stackoverflow.com/questions/24126678/close-ios-keyboard-by-touching-anywhere-using-swift)
    
    func hideKeyboardOnTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    /// Closes the popup keyboard
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func addKeyboardEventListeners() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillChange(notification: Notification){}
}
