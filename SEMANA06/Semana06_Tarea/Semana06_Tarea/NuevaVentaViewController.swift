import UIKit

class NuevaVentaViewController: UIViewController {

    @IBOutlet weak var tfElectrodomestico: UITextField!
    @IBOutlet weak var tfPrecioUnitario: UITextField!
    @IBOutlet weak var tfCantidad: UITextField!
    @IBOutlet weak var tfMeses: UITextField!
    @IBOutlet weak var tfInteresMensual: UITextField!

    private var ventaCalculada: VentaModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Nueva Venta"
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard identifier == "showResultado" else { return true }

        guard let venta = calcularVenta() else {
            mostrarMensaje(
                titulo: "Datos incompletos",
                mensaje: "Ingresa un nombre y valores numéricos válidos. El precio, la cantidad y los meses deben ser mayores que cero."
            )
            return false
        }

        ventaCalculada = venta
        return true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showResultado",
              let pantallaResultado = segue.destination as? ResultadoViewController,
              let ventaCalculada else {
            return
        }

        pantallaResultado.venta = ventaCalculada
    }

    private func calcularVenta() -> VentaModel? {
        let nombre = tfElectrodomestico.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let precioTexto = tfPrecioUnitario.text?.replacingOccurrences(of: ",", with: ".") ?? ""
        let interesTexto = tfInteresMensual.text?.replacingOccurrences(of: ",", with: ".") ?? ""

        guard !nombre.isEmpty,
              let precioUnitario = Double(precioTexto), precioUnitario > 0,
              let cantidad = Double(tfCantidad.text ?? ""), cantidad > 0,
              let meses = Double(tfMeses.text ?? ""), meses > 0,
              let tasaInteresMensual = Double(interesTexto), tasaInteresMensual >= 0 else {
            return nil
        }

        let subtotal = precioUnitario * cantidad
        let igv = subtotal * 0.18
        let base = subtotal + igv
        let intereses = base * (tasaInteresMensual / 100) * meses
        let total = base + intereses
        let cuota = total / meses

        return VentaModel(
            subtotal: subtotal,
            igv: igv,
            base: base,
            intereses: intereses,
            total: total,
            cuota: cuota
        )
    }

    private func mostrarMensaje(titulo: String, mensaje: String) {
        let alerta = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "Aceptar", style: .default))
        present(alerta, animated: true)
    }
}
