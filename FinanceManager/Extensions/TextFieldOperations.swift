//
//  TextFieldOperations.swift
//  FinanceManager
//
//  Created by Chamath Peiris on 2022-04-07.
//

import Foundation
import UIKit

extension UITextField {

    
    ///for static textfields
    func greyedTextField() {
        self.backgroundColor = UIColor.cyan
    }
    
    ///function for checking the textfields wheather empty or not
    func checkIfEmpty() -> Bool{
            if self.text!.count > 0 {
                return false
            } else {
                return true
            }
        }
}
