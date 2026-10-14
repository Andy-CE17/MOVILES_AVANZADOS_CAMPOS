import UIKit

class CarritoViewController: UIViewController {
    @IBOutlet weak var detalleTextView: UITextView!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var descuentoLabel: UILabel!
    @IBOutlet weak var igvLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!

    var carrito: CarritoModel!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        actualizarResumen()
    }

    override func shouldPerformSegue(
        withIdentifier identifier: String,
        sender: Any?
    ) -> Bool {
        guard identifier == "irDatosCliente" else { return true }

        guard !carrito.items.isEmpty else {
            mostrarAlerta(
                titulo: "Carrito vacío",
                mensaje: "Agrega al menos un producto antes de finalizar la compra."
            )
            return false
        }

        return true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "irDatosCliente",
              let destino = segue.destination as? DatosClienteViewController else {
            return
        }
        destino.carrito = carrito
    }

    private func actualizarResumen() {
        if carrito.items.isEmpty {
            detalleTextView.text = "Tu carrito está vacío"
        } else {
            detalleTextView.text = carrito.items.map { item in
                String(
                    format: "%@ x%d\tS/ %.2f",
                    item.producto.nombre,
                    item.cantidad,
                    item.subtotal()
                )
            }.joined(separator: "\n")
        }

        let porcentaje = Int(carrito.porcentajeDescuento() * 100)
        subtotalLabel.text = String(
            format: "Subtotal: S/ %.2f",
            carrito.subtotal()
        )
        descuentoLabel.text = String(
            format: "Descuento (%d%%): -S/ %.2f",
            porcentaje,
            carrito.montoDescuento()
        )
        igvLabel.text = String(format: "IGV (18%%): S/ %.2f", carrito.igv())
        totalLabel.text = String(format: "TOTAL: S/ %.2f", carrito.total())
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

