//
//  Compund Savings.swift
//  FinanceManager
//
//  Created by Chamath Peiris on 4/12/22.
//

import Foundation

class CompoundSavings {
    
    var principalAmount: Double
    var futureValue : Double
    var interestRate : Double
    var numberOfYears : Double
    var compoundsPerYear : Int
    var isNumberOfYearsButtonEnabled : Bool
    var recordedHistoryArray : [String]
    
    init(principalAmount: Double, futureValue: Double, interestRate: Double, numberOfYears: Double, compoundsPerYear : Int, isNumberOfYearsButtonEnabled: Bool) {
        self.principalAmount = principalAmount
        self.futureValue = futureValue
        self.interestRate = interestRate
        self.numberOfYears = numberOfYears
        self.compoundsPerYear = compoundsPerYear
        self.isNumberOfYearsButtonEnabled = isNumberOfYearsButtonEnabled
        self.recordedHistoryArray = [String]()
    }
    
    
    /// Calculates principal amount
    func calculateprincipalAmount() -> Double {
        let interestRate = self.interestRate / 100
        var numberOfYears = self.numberOfYears
        if isNumberOfYearsButtonEnabled {
            numberOfYears = self.numberOfYears
        } else {
            numberOfYears = self.numberOfYears / 12
        }
        let principalValue = self.futureValue / pow(1 + (interestRate / Double(self.compoundsPerYear)), Double(self.compoundsPerYear) * numberOfYears)
        
       if principalValue < 0 || principalValue.isNaN || principalValue.isInfinite {
            self.principalAmount = 0.0;
            return self.principalAmount
        } else {
            self.principalAmount = principalValue.roundDoubleValue()
            print("principal awa")
            print(principalAmount)
            return self.principalAmount
        }
        
    }
    
    
    
    /// Calculates future savings value
    func calculateFutureValue() -> Double {
        let interestRate = self.interestRate / 100
        var numberOfYears = self.numberOfYears
        if isNumberOfYearsButtonEnabled {
            numberOfYears = self.numberOfYears
        } else {
            numberOfYears = self.numberOfYears / 12
        }
        let futureValueCal = self.principalAmount * pow(1 + (interestRate / Double(self.compoundsPerYear)), Double(self.compoundsPerYear) * numberOfYears)
        
        if futureValueCal < 0 || futureValueCal.isNaN || futureValueCal.isInfinite {
            self.futureValue = 0.0;
            return self.futureValue
        } else {
            self.futureValue = futureValueCal.roundDoubleValue()
            print("future awa")
            print(futureValue)
            return self.futureValue
        }
        
        
    }
    
    
    /// Calculates compound interest rate
    func calculateCompoundInterestRate() -> Double {
        var numberOfYears = self.numberOfYears
        if isNumberOfYearsButtonEnabled {
            numberOfYears = self.numberOfYears
        } else {
            numberOfYears = self.numberOfYears / 12
        }
        let interestRateCal = Double(self.compoundsPerYear) * (pow((self.futureValue / self.principalAmount), (1 / (Double(self.compoundsPerYear) * numberOfYears))) - 1)
        
        if interestRateCal < 0 || interestRateCal.isNaN || interestRateCal.isInfinite {
            self.interestRate = 0.0;
            return self.interestRate
        } else {
            let interestRateAnnual = interestRateCal * 100
            self.interestRate = interestRateAnnual.roundDoubleValue()
            return self.interestRate
        }
        
    }
    
    
    /// Calculates number of years
    func calculateNumberOfYears() -> Double {
        let interestRate = self.interestRate / 100
        let years = log(self.futureValue / self.principalAmount) / (Double(self.compoundsPerYear) * log(1 + (interestRate / Double(self.compoundsPerYear))))
        
        if years < 0 || years.isNaN || years.isInfinite {
            self.numberOfYears = 0.0;
            return self.numberOfYears
        } else {
            if isNumberOfYearsButtonEnabled {
                self.numberOfYears = years.roundDoubleValue()
            } else {
                self.numberOfYears = 12 * years.roundDoubleValue()
            }
            return self.numberOfYears
        }
    
    }
}
