import Foundation

struct LoanResult {
    let monthlyPayment: Double
    let totalPayment: Double
    let numberOfPayments: Int
}

enum LoanCalculator {

    static func calculate(
        principal: Double,
        annualRatePercent: Double,
        years: Double
    ) -> LoanResult {
        let numberOfPayments = max(1, Int((years * 12).rounded()))
        let monthlyRate = annualRatePercent / 100 / 12
        let monthlyPayment: Double

        if monthlyRate == 0 {
            monthlyPayment = principal / Double(numberOfPayments)
        } else {
            let compoundFactor = pow(1 + monthlyRate, Double(numberOfPayments))
            monthlyPayment = principal * (monthlyRate * compoundFactor) / (compoundFactor - 1)
        }

        return LoanResult(
            monthlyPayment: monthlyPayment,
            totalPayment: monthlyPayment * Double(numberOfPayments),
            numberOfPayments: numberOfPayments
        )
    }
}
