//
//  SavingsViewController.swift
//  FinanceManager
//
//  Created by Chamath Peiris on 2022-04-06.
//

import UIKit

class SavingsViewController: UIViewController {
    
    
    @IBOutlet weak var CompoundView: UIView!
    @IBOutlet weak var NormalView: UIView!
    
    @IBOutlet weak var savingsSegmentController: UISegmentedControl!
    
    ///Intialize the view
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    ///call the appropriate view controller when changing the segemted control
    @IBAction func onSegmentChange(_ sender: UISegmentedControl) {
        switch savingsSegmentController.selectedSegmentIndex {
        case 0:
            NormalView.alpha = 1
            CompoundView.alpha = 0
        case 1:
            NormalView.alpha = 0
            CompoundView.alpha = 1
        default:
            print("Unhandled Exception")
        }
    }
    
    
}

