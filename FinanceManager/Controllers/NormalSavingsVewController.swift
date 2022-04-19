//
//  NormalSavingsVewController.swift
//  FinanceManager
//
//  Created by Chamath Peiris  on 2022-04-15.
//

import Foundation
import UIKit

class NormalSavingsViewController: UIViewController{
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var savingsPrincipalamountTextField: UITextField!
    @IBOutlet weak var savingsInterestRateTextField: UITextField!
    @IBOutlet weak var savingsCoumpoundYear: UITextField!
    @IBOutlet weak var savingsFutureValueTextField: UITextField!
    @IBOutlet weak var savingsNoOfYears: UITextField!
    @IBOutlet weak var savingsPaymentValue: UITextField!
    
    @IBOutlet weak var savingsNoOfYearsSwitch: UISwitch!
    @IBOutlet weak var noOfYearsUILabel: UILabel!
    
    @IBOutlet weak var savingsDepositsSwitch: UISwitch!
    @IBOutlet weak var depositsUILabel: UILabel!
    
    @IBOutlet weak var savingsCalculateButton: UIButton!
    @IBOutlet weak var savingsClearButton: UIButton!
    @IBOutlet weak var savingsSaveButton: UIButton!
    
    var savingsType: String = "Normal Savings"
    var isNormal: Bool = false
    
    ///Create savings object
    var savings: Savings = Savings(principalAmount: 0.0, interestRate: 0.0, paymentValue: 0.0, compoundsPerYear: 12, futureValue: 0.0, totalNumberOfPayments: 0.0, isNumberOfYearsButtonEnabled: true)
    
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
        savings.recordedHistoryArray = defaults.object(forKey: historyKey) as? [String] ?? [String]()
    }
    
    ///Function for Clearing all the text fields
    func clearAllFields() {
        savingsPrincipalamountTextField.text = ""
        savingsInterestRateTextField.text = ""
        savingsFutureValueTextField.text = ""
        savingsNoOfYears.text = ""
        savingsPaymentValue.text = ""
    }
    
    ///function for save the values of the textfields in to array
    @IBAction func onSaveFunction(_ sender: UIButton) {
        
        ///intialize the history array
        var recordedHistoryArray: String = ""
        
        ///Makes sure that none of the textfields are empty
        
        if savingsPrincipalamountTextField.checkIfEmpty() == false && savingsInterestRateTextField.checkIfEmpty() == false && savingsFutureValueTextField.checkIfEmpty() == false && savingsNoOfYears.checkIfEmpty() == false  {
            
            ///Makes sure that the object is not holding empty values
            if(savings.principalAmount != 0 && savings.interestRate != 0 && savings.futureValue != 0 && savings.totalNumberOfPayments != 0) {
                
                
                
                let defaults = UserDefaults.standard
                
                ///save the past calculations by deviding number of years and number of payments
                if(savingsNoOfYearsSwitch.isOn) {
                    
                    recordedHistoryArray = "Savings = \(savingsType),\n1. Principal Amount = \(savingsPrincipalamountTextField.text!),  \n2. Interest Rate = \(savingsInterestRateTextField.text!),\n3. Number of Compound Per Year = \(savingsCoumpoundYear.text!), \n4. Future Value = \(savingsFutureValueTextField.text!), \n5. Number of Years = \(savingsNoOfYears.text!), \n6. Payment Value = \(savingsPaymentValue.text!)"
                    
                }
                else{
                    recordedHistoryArray = "Savings = \(savingsType),\n 1. Principal Amount = \(savingsPrincipalamountTextField.text!), \n 2. Interest Rate = \(savingsInterestRateTextField.text!),\n3. Number of Compound Per Year = \(savingsCoumpoundYear.text!), \n4. Future Value = \(savingsFutureValueTextField.text!), \n5. Number of Payments = \(savingsNoOfYears.text!), \n6. Payment Value = \(savingsPaymentValue.text!)"
                    
                }
                
                
                ///Resets the object to default values as soon as a save operation is done (to prevent re-saving values without making another calculation)
                (savings.principalAmount, savings.interestRate, savings.paymentValue, savings.futureValue, savings.totalNumberOfPayments) = (0,0,0,0,0)
                
                ///send history list to user defaults
                savings.recordedHistoryArray.append(recordedHistoryArray)
                defaults.set(savings.recordedHistoryArray, forKey: "SavingsHistory")
                
                showAlert(title: "Saved Successfully", msg: "Please click 'History' button to access saved details.")
                
            } else {
                showAlert(title: "Error", msg: "Please do a valid calculation to save")
            }
            
        } else {
            showAlert(title: "Error", msg: "Cannot save calculation with empty fields")
        }
    }
    
    ///Stores all the textfield values
    func storeTextFieldValues() {
        UserDefaults.standard.set(savingsPrincipalamountTextField.text, forKey: "savingspresentValueField")
        UserDefaults.standard.set(savingsInterestRateTextField.text, forKey: "savingsInterestRateTextField")
        UserDefaults.standard.set(savingsPaymentValue.text, forKey: "savingsPaymentValue")
        UserDefaults.standard.set(savingsFutureValueTextField.text, forKey: "savingsFutureValueTextField")
        UserDefaults.standard.set(savingsNoOfYears.text, forKey: "savingsNoOfYearsTextField")
    }
    
    ///Populates the text fields with the prevoiusly stored values
    func populateTextFields() {
        savingsPrincipalamountTextField.text =  UserDefaults.standard.string(forKey: "savingspresentValueField")
        savingsInterestRateTextField.text =  UserDefaults.standard.string(forKey: "savingsInterestRateTextField")
        savingsPaymentValue.text =  UserDefaults.standard.string(forKey: "savingsPaymentValue")
        savingsFutureValueTextField.text =  UserDefaults.standard.string(forKey: "savingsFutureValueTextField")
        savingsNoOfYears.text =  UserDefaults.standard.string(forKey: "savingsNoOfYearsTextField")
    }
    
    ///Change the deposit time UILabel according to the UISwitch
    @IBAction func onDepositsTime(_ sender: UISwitch) {
        if(savingsDepositsSwitch.isOn) {
            depositsUILabel.text = "End"
        } else {
            depositsUILabel.text = "Beginning"
        }
        
    }
    
    ///Change the paymentTime  UILabel according to the UISwitch
    @IBAction func onPaymentTime(_ sender: UISwitch) {
        
        if(savingsNoOfYearsSwitch.isOn) {
            noOfYearsUILabel.text = "Number of Years"
        } else {
            noOfYearsUILabel.text = "Number of Payements"
        }
    }
    
    
    
    @IBAction func onCalculate(_ sender: UIButton) {
        
        if (savingsNoOfYearsSwitch.isOn) {
            savings.isNumberOfYearsButtonEnabled = true
        } else {
            savings.isNumberOfYearsButtonEnabled = false
        }
        
        ///deposit made at the END
        if (depositsUILabel.text) == "End" {
            
            if savingsPrincipalamountTextField.checkIfEmpty() == true && savingsInterestRateTextField.checkIfEmpty() == false && savingsFutureValueTextField.checkIfEmpty() == false && savingsNoOfYears.checkIfEmpty() == false  {
                
                savings.interestRate = Double(savingsInterestRateTextField.text!)!
                savings.futureValue = Double(savingsFutureValueTextField.text!)!
                savings.totalNumberOfPayments = Double(savingsNoOfYears.text!)!
                savings.paymentValue = Double(savingsPaymentValue.text!)!
                savingsPrincipalamountTextField.text = String(savings.calculateEndPrincipalAmount())
                
                
                
            } else if savingsInterestRateTextField.checkIfEmpty() == true && savingsNoOfYears.checkIfEmpty() == false && savingsPrincipalamountTextField.checkIfEmpty() == false && savingsFutureValueTextField.checkIfEmpty() == false
            {
                savings.totalNumberOfPayments = Double(savingsNoOfYears.text!)!
                savings.principalAmount = Double(savingsPrincipalamountTextField.text!)!
                savings.futureValue = Double(savingsFutureValueTextField.text!)!
                savings.paymentValue = Double(savingsPaymentValue.text!)!
                savingsInterestRateTextField.text = String(savings.calculateInterest())
                
                
            } else if savingsFutureValueTextField.checkIfEmpty() == true && savingsInterestRateTextField.checkIfEmpty() == false && savingsPrincipalamountTextField.checkIfEmpty() == false && savingsNoOfYears.checkIfEmpty() == false {
                
                savings.interestRate = Double(savingsInterestRateTextField.text!)!
                savings.principalAmount = Double(savingsPrincipalamountTextField.text!)!
                savings.totalNumberOfPayments = Double(savingsNoOfYears.text!)!
                
                savings.paymentValue = Double(savingsPaymentValue.text!)!
                savingsFutureValueTextField.text = String(savings.calculateEndFutureValue())
                
                
                
                
            } else if savingsNoOfYears.checkIfEmpty() == true && savingsInterestRateTextField.checkIfEmpty() == false && savingsPrincipalamountTextField.checkIfEmpty() == false && savingsFutureValueTextField.checkIfEmpty() == false {
                
                savings.interestRate = Double(savingsInterestRateTextField.text!)!
                savings.principalAmount = Double(savingsPrincipalamountTextField.text!)!
                savings.futureValue = Double(savingsFutureValueTextField.text!)!
                savings.paymentValue = Double(savingsPaymentValue.text!)!
                savingsNoOfYears.text = String(savings.calculateEndNumberOfPayments())
            } else if savingsPaymentValue.checkIfEmpty() == true && savingsInterestRateTextField.checkIfEmpty() == false && savingsFutureValueTextField.checkIfEmpty() == false && savingsPrincipalamountTextField.checkIfEmpty() == false && savingsNoOfYears.checkIfEmpty() == false {
                
                savings.interestRate = Double(savingsInterestRateTextField.text!)!
                savings.futureValue = Double(savingsFutureValueTextField.text!)!
                savings.principalAmount = Double(savingsPrincipalamountTextField.text!)!
                savings.totalNumberOfPayments = Double(savingsNoOfYears.text!)!
                
                savingsPaymentValue.text = String(savings.calculateEndPayment())
            } else{
                showAlert(title: "Error", msg: "Calculation Unsuccessfull!")
                
            }
            ///deposit made at the BEGINNING
        } else {
            if (savingsPrincipalamountTextField.text?.isEmpty)! {
                savings.interestRate = Double(savingsInterestRateTextField.text!)!
                savings.futureValue = Double(savingsFutureValueTextField.text!)!
                savings.paymentValue = Double(savingsPaymentValue.text!)!
                savings.totalNumberOfPayments = Double(savingsNoOfYears.text!)!
                
                savingsPrincipalamountTextField.text = String(savings.calculateBeginningPrincipalAmount())
                
                
            } else if (savingsInterestRateTextField.text?.isEmpty)! {
                savings.totalNumberOfPayments = Double(savingsNoOfYears.text!)!
                savings.paymentValue = Double(savingsPaymentValue.text!)!
                savings.principalAmount = Double(savingsPrincipalamountTextField.text!)!
                savings.futureValue = Double(savingsFutureValueTextField.text!)!
                
                savingsInterestRateTextField.text = String(savings.calculateInterest())
                
                
            } else if (savingsFutureValueTextField.text?.isEmpty)! {
                savings.interestRate = Double(savingsInterestRateTextField.text!)!
                savings.paymentValue = Double(savingsPaymentValue.text!)!
                savings.principalAmount = Double(savingsPrincipalamountTextField.text!)!
                savings.totalNumberOfPayments = Double(savingsNoOfYears.text!)!
                
                savingsFutureValueTextField.text = String(savings.calculateBeginningFutureValue())
                
                
            } else if (savingsNoOfYears.text?.isEmpty)! {
                savings.interestRate = Double(savingsInterestRateTextField.text!)!
                savings.paymentValue = Double(savingsPaymentValue.text!)!
                savings.principalAmount = Double(savingsPrincipalamountTextField.text!)!
                savings.futureValue = Double(savingsFutureValueTextField.text!)!
                
                savingsNoOfYears.text = String(savings.calculateBeginningNumberOfPayments())
                
                
            } else if (savingsPaymentValue.text?.isEmpty)! {
                savings.interestRate = Double(savingsInterestRateTextField.text!)!
                savings.futureValue = Double(savingsFutureValueTextField.text!)!
                savings.principalAmount = Double(savingsPrincipalamountTextField.text!)!
                savings.totalNumberOfPayments = Double(savingsNoOfYears.text!)!
                
                savingsPaymentValue.text = String(savings.calculateBeginningPayment())
            }
            else{
                showAlert(title: "Error", msg: "Calculation Unsuccessfull!")            }
        }
        storeTextFieldValues()
        savingsClearButton.isEnabled = true
        
    }
    
    ///clear text fields values for reset 
    @IBAction func onClear(_ sender: UIButton) {
        clearAllFields()
        storeTextFieldValues()
    }
    
    ///save textfields values to populate them even though app quits
    @IBAction func saveTextFields(_ sender: UITextField) {
        storeTextFieldValues()
    }
    
    
    
}
