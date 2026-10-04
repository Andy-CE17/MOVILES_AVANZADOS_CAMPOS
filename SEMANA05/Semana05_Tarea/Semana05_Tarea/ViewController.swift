import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var principalTextField: UITextField!
    @IBOutlet private weak var annualRateTextField: UITextField!
    @IBOutlet private weak var yearsTextField: UITextField!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var monthlyPaymentLabel: UILabel!
    @IBOutlet private weak var totalPaymentLabel: UILabel!

    private lazy var currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "es_PE")
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        [monthlyPaymentLabel, totalPaymentLabel].forEach {
            $0?.layer.cornerRadius = 12
            $0?.clipsToBounds = true
        }
    }

    @IBAction private func calcularPrestamo(_ sender: Any) {
        view.endEditing(true)

        guard
            let principal = decimalValue(from: principalTextField.text),
            let annualRate = decimalValue(from: annualRateTextField.text),
            let years = decimalValue(from: yearsTextField.text),
            principal > 0,
            annualRate >= 0,
            years > 0
        else {
            showValidationError("Ingresa valores válidos en todos los campos.")
            return
        }

        let result = LoanCalculator.calculate(
            principal: principal,
            annualRatePercent: annualRate,
            years: years
        )

        guard result.monthlyPayment.isFinite, result.totalPayment.isFinite else {
            showValidationError("Los valores ingresados son demasiado grandes.")
            return
        }

        statusLabel.textColor = .secondaryLabel
        statusLabel.text = "Resultado para \(result.numberOfPayments) cuotas mensuales"
        monthlyPaymentLabel.text = "Cuota mensual\n\(currency(result.monthlyPayment))"
        totalPaymentLabel.text = "Monto total a pagar\n\(currency(result.totalPayment))"
    }

    private func decimalValue(from text: String?) -> Double? {
        guard let text else { return nil }
        let normalizedText = text
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: ",", with: ".")

        return Double(normalizedText)
    }

    private func currency(_ value: Double) -> String {
        currencyFormatter.string(from: NSNumber(value: value)) ?? String(format: "S/ %.2f", value)
    }

    private func showValidationError(_ message: String) {
        statusLabel.textColor = .systemRed
        statusLabel.text = message
        monthlyPaymentLabel.text = "Cuota mensual\nS/ 0.00"
        totalPaymentLabel.text = "Monto total a pagar\nS/ 0.00"
    }
}
