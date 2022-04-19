//
//  CompoundSavingsController.swift
//  FinanceManager
//
//  Created by Chamath Peiris  on 2022-04-15.
//

import Foundation
import UIKit

class CompoundSavingsViewController: UIViewController{
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var compoundPrincipalamountTextField: UITextField!
    @IBOutlet weak var compoundInterestRateTextField: UITextField!
    @IBOutlet weak var coumpoundYear: UITextField!
    @IBOutlet weak var compoundFutureValueTextField: UITextField!
    @IBOutlet weak var compoundNoOfYears: UITextField!
    
    @IBOutlet weak var compoundNoOfYearsSwitch: UISwitch!
    @IBOutlet weak var noOfYearsUILabel: UILabel!
    
    
    @IBOutlet weak var compoundCalculateButton: UIButton!
    @IBOutlet weak var compoundClearButton: UIButton!
    @IBOutlet weak var compoundSaveButton: UIButton!
    
    var savingsType: String = "Compound Savings"
    
    ///Create savings object
    var compoundSavings: CompoundSavings = CompoundSavings(principalAmount: 0.0, futureValue: 0.0, interestRate: 0.0, numberOfYears: 0.0, compoundsPerYear: 12, isNumberOfYearsButtonEnabled: true)
    
    ///Intialize the view
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardOnTap()
        addKeyboardEventListeners()
        populateTextFields()
    }
    
    ///override the keyboardWillChange function for control the keyboard's behaviour
    override func keyboardWillChange(notification: Notification) {
        
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {return}
        
        if notification.name == UIResponder.keyboardWillShowNotification || notification.name ==  UIResponder.keyboardWillChangeFrameNotification {
            ///display the keyboard without hiding the text field
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardRect.height, right: 0)
        } else {
            ///come back to the default position when disappering the keyboard
            scrollView.contentInset = UIEdgeInsets.zero
        }
    }
    
    ///Create persistant storage using UserDefaults and add historyStringArray
    func loadDefaultsData(_ historyKey :String) {
        let defaults = UserDefaults.standard
        compoundSavings.recordedHistoryArray = defaults.object(forKey: historyKey) as? [String] ?? [String]()
    }
    
    ///Function for Clearing all the text fields
    func clearAllFields() {
        compoundPrincipalamountTextField.text = ""
        compoundInterestRateTextField.text = ""
        compoundFutureValueTextField.text = ""
        compoundNoOfYears.text = ""
    }
    
    ///Stores all the textfield values
    func storeTextFieldValues() {
        UserDefaults.standard.set(compoundPrincipalamountTextField.text, forKey: "compoundPrincipalAmountField")
        UserDefaults.standard.set(compoundInterestRateTextField.text, forKey: "compoundInterestRateTextField")
        UserDefaults.standard.set(compoundFutureValueTextField.text, forKey: "compoundFutureValueTextField")
        UserDefaults.standard.set(compoundNoOfYears.text, forKey: "compoundNoOfYearsTextField")
    }
    
    ///Populates the text fields with the prevoiusly stored values
    func populateTextFields() {
        compoundPrincipalamountTextField.text =  UserDefaults.standard.string(forKey: "compoundPrincipalAmountField")
        compoundInterestRateTextField.text =  UserDefaults.standard.string(forKey: "compoundInterestRateTextField")
        compoundFutureValueTextField.text =  UserDefaults.standard.string(forKey: "compoundFutureValueTextField")
        compoundNoOfYears.text =  UserDefaults.standard.string(forKey: "compoundNoOfYearsTextField")
    }
    
    
 
    
    ///Change the paymentTime  UILabel according to the UISwitch
    @IBAction func onPaymentTime(_ sender: UISwitch) {
        
        if(compoundNoOfYearsSwitch.isOn) {
            noOfYearsUILabel.text = "Number of Years"
        } else {
            noOfYearsUILabel.text = "Number of Payements"
        }
    }
    
    
    
    @IBAction func onCalculate(_ sender: UIButton) {
        
        if (compoundNoOfYearsSwitch.isOn) {
            compoundSavings.isNumberOfYearsButtonEnabled = true
        } else {
            compoundSavings.isNumberOfYearsButtonEnabled = false
        }
        
        
        if compoundPrincipalamountTextField.checkIfEmpty() == true && compoundInterestRateTextField.checkIfEmpty() == false && compoundFutureValueTextField.checkIfEmpty() == false && compoundNoOfYears.checkIfEmpty() == false
        {
            compoundSavings.numberOfYears = Double(compoundNoOfYears.text!)!
            compoundSavings.interestRate = Double(compoundInterestRateTextField.text!)!
            compoundSavings.futureValue = Double(compoundFutureValueTextField.text!)!
            compoundPrincipalamountTextField.text = String(compoundSavings.calculateprincipalAmount())
            
            
            
        } else if compoundInterestRateTextField.checkIfEmpty() == true && compoundNoOfYears.checkIfEmpty() == false && compoundPrincipalamountTextField.checkIfEmpty() == false && compoundFutureValueTextField.checkIfEmpty() == false
        {
            compoundSavings.numberOfYears = Double(compoundNoOfYears.text!)!
            compoundSavings.principalAmount = Double(compoundPrincipalamountTextField.text!)!
            compoundSavings.futureValue = Double(compoundFutureValueTextField.text!)!
            compoundInterestRateTextField.text = String(compoundSavings.calculateCompoundInterestRate())
            
            
        } else if compoundFutureValueTextField.checkIfEmpty() == true && compoundInterestRateTextField.checkIfEmpty() == false && compoundPrincipalamountTextField.checkIfEmpty() == false && compoundNoOfYears.checkIfEmpty() == false {
            compoundSavings.numberOfYears = Double(compoundNoOfYears.text!)!
            compoundSavings.interestRate = Double(compoundInterestRateTextField.text!)!
            compoundSavings.principalAmount = Double(compoundPrincipalamountTextField.text!)!
            compoundFutureValueTextField.text = String(compoundSavings.calculateFutureValue())
            
            
        } else if compoundNoOfYears.checkIfEmpty() == true && compoundInterestRateTextField.checkIfEmpty() == false && compoundPrincipalamountTextField.checkIfEmpty() == false && compoundFutureValueTextField.checkIfEmpty() == false {
            
            compoundSavings.interestRate = Double(compoundInterestRateTextField.text!)!
            compoundSavings.principalAmount = Double(compoundPrincipalamountTextField.text!)!
            compoundSavings.futureValue = Double(compoundFutureValueTextField.text!)!
            compoundNoOfYears.text = String(compoundSavings.calculateNumberOfYears())
        } else{
            showAlert(title: "Error", msg: "Calculation Unsuccessfull!")
            
        }
        storeTextFieldValues()
    }
    
    
    @IBAction func onClear(_ sender: UIButton) {
        clearAllFields()
        storeTextFieldValues()
    }
    
    ///function for save the values of the textfields in to array
    @IBAction func onSaveFunction(_ sender: UIButton) {
        
        ///intialize the history array
        var recordedHistoryArray: String = ""
        
        ///Makes sure that none of the textfields are empty
        if compoundPrincipalamountTextField.checkIfEmpty() == false && compoundInterestRateTextField.checkIfEmpty() == false && compoundFutureValueTextField.checkIfEmpty() == false && compoundNoOfYears.checkIfEmpty() == false  {
            
            ///Makes sure that the object is not holding empty values
            if(compoundSavings.principalAmount != 0 && compoundSavings.interestRate != 0 && compoundSavings.futureValue != 0) {
                
                let defaults = UserDefaults.standard
                
                ///save the past calculations by deviding number of years and number of payments
                if(compoundNoOfYearsSwitch.isOn) {
                    
                    recordedHistoryArray = "Savings = \(savingsType),\n1. Principal Amount = \(compoundPrincipalamountTextField.text!),  \n2. Interest Rate = \(compoundInterestRateTextField.text!),\n3. Number of Compound Per Year = \(coumpoundYear.text!), \n4. Future Value = \(compoundFutureValueTextField.text!), \n5. Number of Years = \(compoundNoOfYears.text!)"
                    
                }
                else{
                    recordedHistoryArray = "Savings = \(savingsType),\n 1. Principal Amount = \(compoundPrincipalamountTextField.text!), \n 2. Interest Rate = \(compoundInterestRateTextField.text!),\n3. Number of Compound Per Year = \(coumpoundYear.text!), \n4. Future Value = \(compoundFutureValueTextField.text!), \n5. Number of Payments = \(compoundNoOfYears.text!)"
                    
                }
                
                
                ////After save is done, reset all the values for defaults to avoid the re-saving
                (compoundSavings.principalAmount, compoundSavings.interestRate, compoundSavings.futureValue, compoundSavings.numberOfYears) = (0,0,0,0)
                
                ///send history list to user defaults
                compoundSavings.recordedHistoryArray.append(recordedHistoryArray)
                defaults.set(compoundSavings.recordedHistoryArray, forKey: "SavingsHistory")
                
                
                showAlert(title: "Saved Successfully", msg: "Please click 'History' button to access saved details.")
            } else {
                showAlert(title: "Error", msg: "Please do a valid calculation to save")
            }
            
            
        } else {
            showAlert(title: "Error", msg: "Cannot save calculation with empty fields")
        }
    }
    
    ///save textfields values to populate them even though app quits
    @IBAction func saveTextFields(_ sender: UITextField) {
        storeTextFieldValues()
    }
    
}



