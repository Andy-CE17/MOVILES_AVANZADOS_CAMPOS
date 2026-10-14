import UIKit

class BoletaViewController: UIViewController {
    @IBOutlet weak var boletaTextView: UITextView!

    var carrito: CarritoModel!
    var cliente: ClienteModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        mostrarBoletaYConfirmarCompra()
    }

    @IBAction func cerrar(_ sender: UIButton) {
        let navegador = presentingViewController?.navigationController
        dismiss(animated: true) {
            navegador?.popToRootViewController(animated: true)
        }
    }

    private func mostrarBoletaYConfirmarCompra() {
        let porcentaje = Int(carrito.porcentajeDescuento() * 100)
        let lineas = carrito.items.map { item in
            String(
                format: "%@ x%d\tS/ %.2f",
                item.producto.nombre,
                item.cantidad,
                item.subtotal()
            )
        }.joined(separator: "\n")

        boletaTextView.text = """
        Cliente: \(cliente.nombreCompleto) (\(carrito.categoriaCliente()))
        DNI: \(cliente.dni)

        \(lineas)

        Subtotal:        \(moneda(carrito.subtotal()))
        Descuento (\(porcentaje)%): -\(moneda(carrito.montoDescuento()))
        IGV (18%):       \(moneda(carrito.igv()))
        TOTAL:           \(moneda(carrito.total()))
        """

        carrito.confirmarCompra()
    }

    private func moneda(_ valor: Double) -> String {
        String(format: "S/ %.2f", valor)
    }
}

