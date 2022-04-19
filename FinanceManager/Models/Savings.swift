//
//  Savings.swift
//  FinanceManager
//
//  Created by Chamath Peiris on 2022-04-06.
//

import Foundation

class Savings {
    
    var principalAmount: Double
    var futureValue : Double
    var interestRate : Double
    var totalNumberOfPayments: Double
    var compoundsPerYear : Int
    var paymentValue : Double
    var isNumberOfYearsButtonEnabled : Bool
    var recordedHistoryArray : [String]
    
    
    init(principalAmount: Double, interestRate: Double, paymentValue: Double, compoundsPerYear: Int, futureValue: Double, totalNumberOfPayments: Double, isNumberOfYearsButtonEnabled: Bool) {
        self.principalAmount = principalAmount
        self.interestRate = interestRate
        self.paymentValue = paymentValue
        self.compoundsPerYear = compoundsPerYear
        self.futureValue = futureValue
        self.totalNumberOfPayments = totalNumberOfPayments
        self.isNumberOfYearsButtonEnabled = isNumberOfYearsButtonEnabled
        self.recordedHistoryArray = [String]()
    }
    
    
    /// Calculation of the current savings value with end
    func calculateEndPrincipalAmount() -> Double {
        let decimalInterest = self.interestRate/100
        var numberOfYears = self.totalNumberOfPayments
        if isNumberOfYearsButtonEnabled {
            numberOfYears = self.totalNumberOfPayments
        } else {
            numberOfYears = self.totalNumberOfPayments / 12
        }
        let compounds = Double(self.compoundsPerYear)
        let principal = (self.futureValue - (self.paymentValue * ((pow((1 + decimalInterest/compounds), (compounds*numberOfYears)) - 1) / (decimalInterest/compounds)))) / (pow(1+(decimalInterest/compounds), (compounds*numberOfYears)))
        
        if principal < 0 || principal.isNaN || principal.isInfinite {
            self.principalAmount = 0;
            return self.principalAmount
        } else {
            self.principalAmount = principal.roundDoubleValue()
            return self.principalAmount
        }
        
    }
    
    
    /// Calculation of the current savings value with beginning
    func calculateBeginningPrincipalAmount() -> Double {
        let decimalInterest = self.interestRate/100
        var numberOfYears = self.totalNumberOfPayments
        if isNumberOfYearsButtonEnabled {
            numberOfYears = self.totalNumberOfPayments
        } else {
            numberOfYears = self.totalNumberOfPayments / 12
        }
        let compounds = Double(self.compoundsPerYear)
        let principal = (self.futureValue - (self.paymentValue * ((pow((1 + decimalInterest/compounds), (compounds*numberOfYears)) - 1) / (decimalInterest/compounds)) * (1 + (decimalInterest/compounds)))) / (pow(1+(decimalInterest/compounds), (compounds*numberOfYears)))
        
        if principal < 0 || principal.isNaN || principal.isInfinite {
            self.principalAmount = 0;
            return self.principalAmount
        } else {
            self.principalAmount = principal.roundDoubleValue()
            return self.principalAmount
        }
        
    }
    
    
    /// Calculation of the end monthly deposit value
    func calculateEndPayment() -> Double {
        let decimalInterest = self.interestRate/100
        var numberOfYears = self.totalNumberOfPayments
        if isNumberOfYearsButtonEnabled {
            numberOfYears = self.totalNumberOfPayments
        } else {
            numberOfYears = self.totalNumberOfPayments / 12
        }
        let compounds = Double(self.compoundsPerYear)
        let pmt = (self.futureValue - (self.principalAmount * (pow(1+(decimalInterest/compounds), (compounds*numberOfYears))))) / ((pow((1 + decimalInterest/compounds), (compounds*numberOfYears)) - 1) / (decimalInterest/compounds))
        
        if pmt < 0 || pmt.isNaN || pmt.isInfinite {
            self.paymentValue = 0;
            return self.paymentValue
        } else {
            self.paymentValue = pmt.roundDoubleValue()
            return self.paymentValue
        }
    }
    
    
    /// Calculation of the beginning monthly deposit value
    func calculateBeginningPayment() -> Double {
        let decimalInterest = self.interestRate/100
        var numberOfYears = self.totalNumberOfPayments
        if isNumberOfYearsButtonEnabled {
            numberOfYears = self.totalNumberOfPayments
        } else {
            numberOfYears = self.totalNumberOfPayments / 12
        }
        let compounds = Double(self.compoundsPerYear)
        let pmt = (self.futureValue - (self.principalAmount * (pow(1+(decimalInterest/compounds), (compounds*numberOfYears))))) / (((pow((1 + decimalInterest/compounds), (compounds*numberOfYears)) - 1) / (decimalInterest/compounds)) * (1 + (decimalInterest/compounds)))
        
        if pmt < 0 || pmt.isNaN || pmt.isInfinite {
            self.paymentValue = 0;
            return self.paymentValue
        } else {
            self.paymentValue = pmt.roundDoubleValue()
            return self.paymentValue
        }
    }
    
    
    /// Calculation of the end future value
    func calculateEndFutureValue() -> Double {
        let decimalInterest = self.interestRate/100
        var numberOfYears = self.totalNumberOfPayments
        if isNumberOfYearsButtonEnabled {
            numberOfYears = self.totalNumberOfPayments
        } else {
            numberOfYears = self.totalNumberOfPayments / 12
        }
        let compounds = Double(self.compoundsPerYear)
        let a = (self.principalAmount * (pow(1+(decimalInterest/compounds), (compounds*numberOfYears)))) + (self.paymentValue * ((pow((1 + decimalInterest/compounds), (compounds*numberOfYears)) - 1) / (decimalInterest/compounds)))
        
        if a < 0 || a.isNaN || a.isInfinite {
            self.futureValue = 0;
            return self.futureValue
        } else {
            self.futureValue = a.roundDoubleValue()
            return self.futureValue
        }
    }
    
    
    /// Calculation of the beginning future value
    func calculateBeginningFutureValue() -> Double {
        let decimalInterest = self.interestRate/100
        var numberOfYears = self.totalNumberOfPayments
        if isNumberOfYearsButtonEnabled {
            numberOfYears = self.totalNumberOfPayments
        } else {
            numberOfYears = self.totalNumberOfPayments / 12
        }
        let compounds = Double(self.compoundsPerYear)
        let a = (self.principalAmount * (pow(1+(decimalInterest/compounds), (compounds*numberOfYears)))) + (self.paymentValue * ((pow((1 + decimalInterest/compounds), (compounds*numberOfYears)) - 1) / (decimalInterest/compounds)) * (1 + (decimalInterest/compounds)))
        
        if a < 0 || a.isNaN || a.isInfinite {
            self.futureValue = 0;
            return self.futureValue
        } else {
            self.futureValue = a.roundDoubleValue()
            return self.futureValue
        }
        
    }
    
    
    /// Calculation of the end number of payments
    func calculateEndNumberOfPayments() -> Double {
        let decimalInterest = self.interestRate/100
        let compounds = Double(self.compoundsPerYear)
        let numberOfyears = (log(self.futureValue + ((self.paymentValue*compounds)/decimalInterest)) - log(((decimalInterest*self.principalAmount) + (self.paymentValue*compounds)) / decimalInterest)) / (compounds * log(1+(decimalInterest/compounds)))
        
        if numberOfyears < 0 || numberOfyears.isNaN || numberOfyears.isInfinite {
            self.totalNumberOfPayments = 0;
            return self.totalNumberOfPayments
        } else {
            if isNumberOfYearsButtonEnabled {
                self.totalNumberOfPayments = numberOfyears.roundDoubleValue()
            } else {
                self.totalNumberOfPayments = 12 * numberOfyears.roundDoubleValue()
            }
            return self.totalNumberOfPayments
        }
    }
    
    
    /// Calculation of the beginning number of payments
    func calculateBeginningNumberOfPayments() -> Double {
        let decimalInterest = self.interestRate/100
        let compounds = Double(self.compoundsPerYear)
        let numberOfyears = ((log(self.futureValue + self.paymentValue + ((self.paymentValue * compounds) / decimalInterest)) - log(self.principalAmount + self.paymentValue + ((self.paymentValue * compounds) / decimalInterest))) / (compounds * log(1 + (decimalInterest / compounds))))
        
        if numberOfyears < 0 || numberOfyears.isNaN || numberOfyears.isInfinite {
            self.totalNumberOfPayments = 0;
            return self.totalNumberOfPayments
        } else {
            if isNumberOfYearsButtonEnabled {
                self.totalNumberOfPayments = numberOfyears.roundDoubleValue()
            } else {
                self.totalNumberOfPayments = 12 * numberOfyears.roundDoubleValue()
            }
            return self.totalNumberOfPayments
        }
    }
    
    
    /// Calculation of the compound interest rate
    func calculateInterest() -> Double{
        var numberOfYears = self.totalNumberOfPayments
        if isNumberOfYearsButtonEnabled {
            numberOfYears = self.totalNumberOfPayments
        } else {
            numberOfYears = self.totalNumberOfPayments / 12
        }
        let interestRate = Double(self.compoundsPerYear) * (pow((self.futureValue / self.principalAmount), (1 / (Double(self.compoundsPerYear) * numberOfYears))) - 1)
        
        if interestRate < 0 || interestRate.isNaN || interestRate.isInfinite {
            self.interestRate = 0.0;
            return self.interestRate
        } else {
            let annualInterestRate = interestRate * 100
            self.interestRate = annualInterestRate.roundDoubleValue()
            return self.interestRate
        }
    }
    
    
}
