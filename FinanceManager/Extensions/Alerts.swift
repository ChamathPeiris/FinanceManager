//
//  Alerts.swift
//  FinanceManager
//
//  Created by Chamath Peiris on 2022-04-08.
//


import UIKit

extension UIViewController {
    
    
    ///create alert messages
    ///https://stackoverflow.com/questions/24022479/how-would-i-create-a-uialertview-in-swift
    func showAlert(title: String, msg: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
   
    
}
