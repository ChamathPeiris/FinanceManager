//
//  MortgageViewController.swift
//  FinanceManager
//
//  Created by Chamath Peiris on 2022-04-09.
//

import UIKit

class MortgageViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mortgageLoanAmountTextFiled: UITextField!
    @IBOutlet weak var mortgageInterestRateTextField: UITextField!
    @IBOutlet weak var monthlyPaymentTextField: UITextField!
    @IBOutlet weak var NumberOfYearsTextField: UITextField!
    @IBOutlet weak var mortgageCalculateButton: UIButton!
    @IBOutlet weak var mortgageClearButton: UIButton!
    @IBOutlet weak var mortgageSaveButton: UIButton!
    
    
    ///Create mortgage object
    var mortgage: Mortgage = Mortgage(loanAmount: 0.0, interest: 0.0, payment: 0.0, numberOfYears: 0.0)
    
    
    ///Initialize the view
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
    
    
    ///Create persistant storage using UserDefaults and add recordedHistoryArray
    func loadDefaultsData(_ historyKey :String) {
        let defaults = UserDefaults.standard
        mortgage.recordedHistoryArray = defaults.object(forKey: historyKey) as? [String] ?? [String]()
    }
    
    
    ///Stores all the textfield values
    func storeTextFieldValues() {
        UserDefaults.standard.set(mortgageLoanAmountTextFiled.text, forKey: "mortgageAmountTextFiled")
        UserDefaults.standard.set(mortgageInterestRateTextField.text, forKey: "mortgageInterestRateTextField")
        UserDefaults.standard.set(monthlyPaymentTextField.text, forKey: "mortgagemonthlyPaymentTextField")
        UserDefaults.standard.set(NumberOfYearsTextField.text, forKey: "mortgageNumberOfYearsTextField")
    }
    
    ///Populates the text fields with the prevoiusly stored values
    func populateTextFields() {
        mortgageLoanAmountTextFiled.text =  UserDefaults.standard.string(forKey: "mortgageAmountTextFiled")
        mortgageInterestRateTextField.text =  UserDefaults.standard.string(forKey: "mortgageInterestRateTextField")
        monthlyPaymentTextField.text =  UserDefaults.standard.string(forKey: "mortgagemonthlyPaymentTextField")
        NumberOfYearsTextField.text =  UserDefaults.standard.string(forKey: "mortgageNumberOfYearsTextField")
    }
    
    ///function for save button to save all the data in text fields
    @IBAction func onSaveFunction(_ sender: UIButton) {
        ///Makes sure that none of the textfields are empty
        if mortgageLoanAmountTextFiled.checkIfEmpty() == false && mortgageInterestRateTextField.checkIfEmpty() == false && monthlyPaymentTextField.checkIfEmpty() == false && NumberOfYearsTextField.checkIfEmpty() == false {
            
            ///Makes sure that the object is not holding empty values
            if(mortgage.loanAmount != 0 && mortgage.interest != 0 && mortgage.payment != 0 && mortgage.numberOfYears != 0) {
                
                let defaults = UserDefaults.standard
                let historyString = " 1. Loan Amount - \(mortgage.loanAmount) \n 2. Interest Rate (%) - \(mortgage.interest)  \n 3. Monthly Payment - \(mortgage.payment) \n 4. Number of Years (Time) - \(mortgage.numberOfYears)"
                
                
                ///After save is done, reset all the values for defaults to avoid the re-saving
                (mortgage.loanAmount, mortgage.interest, mortgage.payment, mortgage.numberOfYears) = (0,0,0,0)
                
                ///send history list to user defaults
                mortgage.recordedHistoryArray.append(historyString)
                defaults.set(mortgage.recordedHistoryArray, forKey: "MortgageHistory")
                
                showAlert(title: "Saved Successfully", msg: "Please click 'History' button to access saved details.")
                
            } else {
                showAlert(title: "Error", msg: "Please do a valid calculation to save")
            }
        } else {
            showAlert(title: "Error", msg: "Cannot save calculation with empty fields")
        }
    }
    
    ///function for calculate button to calculate the requested values
    @IBAction func onClaculate(_ sender: UIButton) {
        
        if mortgageLoanAmountTextFiled.checkIfEmpty() == false && mortgageInterestRateTextField.checkIfEmpty() == false && monthlyPaymentTextField.checkIfEmpty() == false && NumberOfYearsTextField.checkIfEmpty() == true{
            
            mortgage.loanAmount = Double(mortgageLoanAmountTextFiled.text!)!
            mortgage.interest = Double(mortgageInterestRateTextField.text!)!
            mortgage.payment = Double(monthlyPaymentTextField.text!)!
            NumberOfYearsTextField.text = String(mortgage.calculateNumberOfYears())  ///call the corresponding method
            storeTextFieldValues()  ///store values
            
        } else if mortgageLoanAmountTextFiled.checkIfEmpty() == false && mortgageInterestRateTextField.checkIfEmpty() == false && NumberOfYearsTextField.checkIfEmpty() == false && monthlyPaymentTextField.checkIfEmpty() == true{
            
            mortgage.loanAmount = Double(mortgageLoanAmountTextFiled.text!)!
            mortgage.interest = Double(mortgageInterestRateTextField.text!)!
            mortgage.numberOfYears = Double(NumberOfYearsTextField.text!)!
            monthlyPaymentTextField.text = String(mortgage.calculateMonthlyPayment())  ///call the corresponding method
            storeTextFieldValues()  ///store values
            
        } else if mortgageLoanAmountTextFiled.checkIfEmpty() == true && mortgageInterestRateTextField.checkIfEmpty() == false && NumberOfYearsTextField.checkIfEmpty() == false && monthlyPaymentTextField.checkIfEmpty() == false{
            
            mortgage.numberOfYears = Double(NumberOfYearsTextField.text!)!
            mortgage.interest = Double(mortgageInterestRateTextField.text!)!
            mortgage.payment = Double(monthlyPaymentTextField.text!)!
            mortgageLoanAmountTextFiled.text = String(mortgage.calculateLoanAmount())
            storeTextFieldValues()
            
        } else if mortgageLoanAmountTextFiled.checkIfEmpty() == false && mortgageInterestRateTextField.checkIfEmpty() == true && NumberOfYearsTextField.checkIfEmpty() == false && monthlyPaymentTextField.checkIfEmpty() == false{
            
            mortgage.loanAmount = Double(mortgageLoanAmountTextFiled.text!)!
            mortgage.numberOfYears = Double(NumberOfYearsTextField.text!)!
            mortgage.payment = Double(monthlyPaymentTextField.text!)!
            mortgageInterestRateTextField.text = String(mortgage.calculateAnnualInterestRate())
            storeTextFieldValues()
            
            
        } else {
            showAlert(title: "Error", msg: "Calculation Unsuccessfull!")
        }
        storeTextFieldValues()
        
    }
    
    ///Function for Clearing all the text fields
    func clearAllFields() {
        monthlyPaymentTextField.text=""
        mortgageLoanAmountTextFiled.text=""
        mortgageInterestRateTextField.text=""
        NumberOfYearsTextField.text=""
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
