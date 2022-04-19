//
//  RoundDouble.swift
//  FinanceManager
//
//  Created by Chamath Peiris on 2022-04-06.
//

import Foundation

import UIKit

extension Double {
    
    
    ///function for round double values to 2 decimal points
    func roundDoubleValue() -> Double {
        let divisor = pow(10.0, 2.0)
        let rounded = (self * divisor).rounded() / divisor
        return rounded
    }
    
    
}
