import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var weightTextField: UITextField!
    @IBOutlet private weak var heightTextField: UITextField!
    @IBOutlet private weak var resultLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        resultLabel.text = "Introduce tu peso y altura"
        resultLabel.layer.cornerRadius = 12
        resultLabel.clipsToBounds = true
    }

    @IBAction private func calcularResultado(_ sender: Any) {
        view.endEditing(true)

        guard
            let weight = decimalValue(from: weightTextField.text),
            let height = decimalValue(from: heightTextField.text),
            weight > 0,
            height > 0
        else {
            resultLabel.text = "Por favor, ingresa valores válidos."
            return
        }

        let bmi = weight / (height * height)
        let status: String

        if bmi < 18.5 {
            status = "Bajo peso"
        } else if bmi < 25 {
            status = "Peso normal"
        } else if bmi < 30 {
            status = "Sobrepeso"
        } else {
            status = "Obesidad"
        }

        resultLabel.text = "IMC: \(String(format: "%.2f", bmi)) - \(status)"
    }

    private func decimalValue(from text: String?) -> Double? {
        guard let text else { return nil }
        let normalizedText = text
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: ",", with: ".")

        return Double(normalizedText)
    }
}
