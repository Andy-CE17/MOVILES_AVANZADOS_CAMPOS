import UIKit

class DatosClienteViewController: UIViewController {
    @IBOutlet weak var apellidosTextField: UITextField!
    @IBOutlet weak var nombresTextField: UITextField!
    @IBOutlet weak var dniTextField: UITextField!

    var carrito: CarritoModel!

    @IBAction func confirmarCompra(_ sender: UIButton) {
        let apellidos = apellidosTextField.text?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let nombres = nombresTextField.text?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let dni = dniTextField.text?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        guard !apellidos.isEmpty, !nombres.isEmpty, !dni.isEmpty else {
            mostrarAlerta(
                titulo: "Datos incompletos",
                mensaje: "Completa los apellidos, nombres y DNI."
            )
            return
        }

        guard dni.count == 8, dni.allSatisfy(\.isNumber) else {
            mostrarAlerta(
                titulo: "DNI inválido",
                mensaje: "El DNI debe contener exactamente 8 dígitos."
            )
            return
        }

        performSegue(withIdentifier: "verBoleta", sender: sender)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "verBoleta",
              let destino = segue.destination as? BoletaViewController else {
            return
        }

        destino.carrito = carrito
        destino.cliente = ClienteModel(
            apellidos: apellidosTextField.text?.trimmingCharacters(
                in: .whitespacesAndNewlines
            ) ?? "",
            nombres: nombresTextField.text?.trimmingCharacters(
                in: .whitespacesAndNewlines
            ) ?? "",
            dni: dniTextField.text?.trimmingCharacters(
                in: .whitespacesAndNewlines
            ) ?? ""
        )
    }

    private func mostrarAlerta(titulo: String, mensaje: String) {
        let alerta = UIAlertController(
            title: titulo,
            message: mensaje,
            preferredStyle: .alert
        )
        alerta.addAction(UIAlertAction(title: "Aceptar", style: .default))
        present(alerta, animated: true)
    }
}

