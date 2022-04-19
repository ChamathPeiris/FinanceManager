//
//  LoansViewController.swift
//  FinanceManager
//
//  Created by Chamath Peiris on 2022-04-06.
//

import UIKit

class LoansViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loanAmountTextField: UITextField!
    @IBOutlet weak var interestRateTextField: UITextField!
    @IBOutlet weak var monthlyPaymentTextField: UITextField!
    @IBOutlet weak var numberOfPaymentsTextField: UITextField!
    @IBOutlet weak var loanCalculateButtion: UIButton!
    @IBOutlet weak var loanClearButton: UIButton!
    
    @IBOutlet weak var loanSaveButton: UIButton!
    
    
    ///Create loan object
    var loan: Loan = Loan(loanAmount: 0.0, interest: 0.0, payment: 0.0, numberOfPayments: 0)
    
    
    ///Initialize the view
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardOnTap()
        addKeyboardEventListeners()
        populateTextFields()
    }
    
    ///Function for Clearing all the text fields
    func clearAllFields() {
        loanAmountTextField.text=""
        interestRateTextField.text=""
        monthlyPaymentTextField.text=""
        numberOfPaymentsTextField.text=""
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
    
    ///Create persistant storage using UserDefaults and add recordedHistoryArray
    func loadDefaultsData(_ historyKey :String) {
        let defaults = UserDefaults.standard
        loan.recordedHistoryArray = defaults.object(forKey: historyKey) as? [String] ?? [String]()
    }
    
    
    ///Stores all the textfield values
    func storeTextFieldValues() {
        UserDefaults.standard.set(loanAmountTextField.text, forKey: "loansAmountField")
        UserDefaults.standard.set(interestRateTextField.text, forKey: "loansInterestRateField")
        UserDefaults.standard.set(monthlyPaymentTextField.text, forKey: "loansPaymentField")
        UserDefaults.standard.set(numberOfPaymentsTextField.text, forKey: "loansNumberOfPaymentsField")
    }
    
    ///Populates the text fields with the prevoiusly stored values
    func populateTextFields() {
        loanAmountTextField.text =  UserDefaults.standard.string(forKey: "loansAmountField")
        interestRateTextField.text =  UserDefaults.standard.string(forKey: "loansInterestRateField")
        monthlyPaymentTextField.text =  UserDefaults.standard.string(forKey: "loansPaymentField")
        numberOfPaymentsTextField.text =  UserDefaults.standard.string(forKey: "loansNumberOfPaymentsField")
    }
    
    ///function for save button to save all the data in text fields
    @IBAction func onSaveFunction(_ sender: UIButton) {
        ///Makes sure that none of the textfields are empty
        if loanAmountTextField.checkIfEmpty() == false && interestRateTextField.checkIfEmpty() == false && monthlyPaymentTextField.checkIfEmpty() == false && numberOfPaymentsTextField.checkIfEmpty() == false {
            
            ///Makes sure that the object is not holding empty values
            if(loan.loanAmount != 0 && loan.interest != 0 && loan.payment != 0 && loan.numberOfPayments != 0) {
                
                let defaults = UserDefaults.standard
                let historyString = " 1. Loan Amount - \(loan.loanAmount) \n 2. Interest Rate (%) - \(loan.interest) \n 3. Monthly Payment - \(loan.payment) \n 4. Number of Payments - \(loan.numberOfPayments)"
                
                ///After save is done, reset all the values for defaults to avoid the re-saving
                (loan.loanAmount, loan.interest, loan.payment, loan.numberOfPayments) = (0,0,0,0)
                
                ///send history list to user defaults
                loan.recordedHistoryArray.append(historyString)
                defaults.set(loan.recordedHistoryArray, forKey: "LoansHistory")
                
                showAlert(title: "Saved Successfully", msg: "Please click 'History' button to access saved details.")
                
            } else {
                showAlert(title: "Error", msg: "Please do a valid calculation to save")
            }
            
        } else {
            showAlert(title: "Error", msg: "Cannot save calculation with empty fields")
        }
    }
    
    ///function for calculate button to calculate the requested values
    @IBAction func onCalculate(_ sender: UIButton) {
        
        if loanAmountTextField.checkIfEmpty() == false && interestRateTextField.checkIfEmpty() == false && monthlyPaymentTextField.checkIfEmpty() == false && numberOfPaymentsTextField.checkIfEmpty() == true{
            
            loan.loanAmount = Double(loanAmountTextField.text!)!
            loan.interest = Double(interestRateTextField.text!)!
            loan.payment = Double(monthlyPaymentTextField.text!)!
            numberOfPaymentsTextField.text = String(loan.calculateNumberOfPayments())
            storeTextFieldValues()
            
        } else if loanAmountTextField.checkIfEmpty() == false && interestRateTextField.checkIfEmpty() == false && numberOfPaymentsTextField.checkIfEmpty() == false && monthlyPaymentTextField.checkIfEmpty() == true{
            
            loan.loanAmount = Double(loanAmountTextField.text!)!
            loan.interest = Double(interestRateTextField.text!)!
            loan.numberOfPayments = Int(Double(numberOfPaymentsTextField.text!)!)
            monthlyPaymentTextField.text = String(loan.calculateMonthlyPayment())
            storeTextFieldValues()
            
        } else if loanAmountTextField.checkIfEmpty() == true && interestRateTextField.checkIfEmpty() == false && numberOfPaymentsTextField.checkIfEmpty() == false && monthlyPaymentTextField.checkIfEmpty() == false{
            
            loan.numberOfPayments = Int(Double(numberOfPaymentsTextField.text!)!)
            loan.interest = Double(interestRateTextField.text!)!
            loan.payment = Double(monthlyPaymentTextField.text!)!
            loanAmountTextField.text = String(loan.calculateLoanAmount())
            storeTextFieldValues()
            
        } else if loanAmountTextField.checkIfEmpty() == false && interestRateTextField.checkIfEmpty() == true && numberOfPaymentsTextField.checkIfEmpty() == false && monthlyPaymentTextField.checkIfEmpty() == false{
            
            loan.loanAmount = Double(loanAmountTextField.text!)!
            loan.numberOfPayments = Int(Double(numberOfPaymentsTextField.text!)!)
            loan.payment = Double(monthlyPaymentTextField.text!)!
            interestRateTextField.text = String(loan.calculateAnnualInterestRate())
            storeTextFieldValues()
            
        } else {
            showAlert(title: "Error", msg: "Calculation Unsuccessfull!")
        }
    }
    
    
    ///Clear button function to clear the text fields
    @IBAction func onClear(_ sender: UIButton) {
        clearAllFields()
        storeTextFieldValues()
    }
    
    ///save textfields values to populate them even though app quits
    @IBAction func saveTextFields(_ sender: UITextField) {
        storeTextFieldValues()
    }
    
}
