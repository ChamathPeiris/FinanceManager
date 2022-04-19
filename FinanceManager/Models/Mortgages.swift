//
//  Mortgages.swift
//  FinanceManager
//
//  Created by Chamath Peiris on 2022-04-06.
//

import Foundation

class Mortgage {
    var loanAmount: Double
    var interest : Double
    var payment : Double
    var numberOfYears : Double
    var recordedHistoryArray : [String]
    
    init(loanAmount: Double, interest: Double, payment: Double, numberOfYears: Double) {
        self.loanAmount = loanAmount
        self.interest = interest
        self.payment = payment
        self.numberOfYears = numberOfYears
        self.recordedHistoryArray = [String]()
    }
    

     /// calculation of the principal loan amount
     /// monthly_interest_rate (in decimal) = (yearly_interest_rate / (12 * 100)
     /// principal_loan_amount = (monthly_payment * (pow((1 + monthly_interest_rate), number_of_months) - 1)) / (monthly_interest_rate * pow((1 + monthly_interest_rate), number_of_months))
     
    func calculateLoanAmount() -> Double {
        let monthlyInterestRate = self.interest / (12 * 100)
        let numberOfMonths = 12 * self.numberOfYears
        let loan = (self.payment * (pow((1 + monthlyInterestRate), numberOfMonths) - 1)) / (monthlyInterestRate * pow((1 + monthlyInterestRate), numberOfMonths))
        
        if loan < 0 || loan.isNaN || loan.isInfinite {
            self.loanAmount = 0.0;
            return self.loanAmount
        } else {
            self.loanAmount = loan.roundDoubleValue()
            return self.loanAmount
        }
        
    }
    
     /// Calculation of the annual interest rate
     /// number_of_months = number_of_years * 12
    func calculateAnnualInterestRate() -> Double {
        let numberOfMonths = 12 * self.numberOfYears
        var x = 1 + (((self.payment*numberOfMonths/self.loanAmount) - 1) / 12)
        
        func F(_ x: Double) -> Double {
            let F = self.loanAmount * x * pow(1 + x, numberOfMonths) / (pow(1+x, numberOfMonths) - 1) - self.payment
            return F;
        }
        
        func F_Prime(_ x: Double) -> Double {
            let F_Prime = self.loanAmount * pow(x+1, numberOfMonths-1) * (x * pow(x+1, numberOfMonths) + pow(x+1, numberOfMonths) - (numberOfMonths*x) - x - 1) / pow(pow(x+1, numberOfMonths) - 1, 2)
            return F_Prime
        }
        
        while(abs(F(x)) > Double(0.000001)) {
            x = x - F(x) / F_Prime(x)
        }
        
        let I = Double(12 * x * 100)
        
        if I < 0 || I.isNaN || I.isInfinite {
            self.interest = 0.0;
            return self.interest
        } else {
            self.interest = I.roundDoubleValue()
            return self.interest
        }
    }
    
    
     /// Calculation of the monthly payment value
     /// monthly_interest_rate (in decimal) = (yearly_interest_rate / (12 * 100)
     /// number_of_months = number_of_years * 12
     /// monthly_payment = (principal_loan_amount * monthly_interest_rate) / (1 - (pow((1 + monthly_interest_rate), number_of_months * -1)))
    func calculateMonthlyPayment() -> Double {
        let monthlyInterestRate = self.interest / (12 * 100)
        let numberOfMonths = 12 * self.numberOfYears
        let monthlyPayment = (self.loanAmount * monthlyInterestRate) / (1 - (pow((1 + monthlyInterestRate), numberOfMonths * -1)))
        
        if monthlyPayment < 0 || monthlyPayment.isNaN || monthlyPayment.isInfinite {
            self.payment = 0.0;
            return self.payment
        } else {
            self.payment = monthlyPayment.roundDoubleValue()
            return self.payment
        }
        
    }
    
    
    
     /// Calculation of the number of years
     /// monthly_interest_rate (in decimal) = (yearly_interest_rate / (12 * 100)
     /// number_of_months = log((monthly_payment / monthly_interest_rate) / ((monthly_payment / monthly_interest_rate) - (principal_loan_amount))) / log(1 + monthly_interest_rate)
     /// number_of_years = number_of_months / 12
    func calculateNumberOfYears() -> Double {
        let monthlyInterestRate = self.interest / (12 * 100)
        let numberOfMonths = log((self.payment / monthlyInterestRate) / ((self.payment / monthlyInterestRate) - (self.loanAmount))) / log(1 + monthlyInterestRate)
        
        if numberOfMonths < 0 || numberOfMonths.isNaN || numberOfMonths.isInfinite {
            self.numberOfYears = 0.0;
            return self.numberOfYears
        } else {
            self.numberOfYears = (numberOfMonths / 12).roundDoubleValue()
            return self.numberOfYears
        }
    }
    
}

