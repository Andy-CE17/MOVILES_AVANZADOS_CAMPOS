import UIKit

class DetalleViewController: UIViewController {
    @IBOutlet weak var nombreLabel: UILabel!
    @IBOutlet weak var precioLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var cantidadLabel: UILabel!

    var producto: Producto!
    var carrito: CarritoModel!
    private var cantidad = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        mostrarProducto()
    }

    @IBAction func disminuirCantidad(_ sender: UIButton) {
        guard cantidad > 1 else { return }
        cantidad -= 1
        cantidadLabel.text = "\(cantidad)"
    }

    @IBAction func aumentarCantidad(_ sender: UIButton) {
        guard cantidad < producto.stock else {
            mostrarAlerta(
                titulo: "Stock insuficiente",
                mensaje: "Solo hay \(producto.stock) unidades disponibles."
            )
            return
        }

        cantidad += 1
        cantidadLabel.text = "\(cantidad)"
    }

    @IBAction func agregarAlCarrito(_ sender: UIButton) {
        guard carrito.agregar(producto: producto, cantidad: cantidad) else {
            let cantidadAgregada = carrito.items
                .first(where: { $0.producto === producto })?.cantidad ?? 0
            let disponible = max(producto.stock - cantidadAgregada, 0)

            mostrarAlerta(
                titulo: "Stock insuficiente",
                mensaje: "Puedes agregar como máximo \(disponible) unidades más."
            )
            return
        }

        let alerta = UIAlertController(
            title: "Producto agregado",
            message: "\(cantidad) unidad(es) de \(producto.nombre) se agregaron al carrito.",
            preferredStyle: .alert
        )
        alerta.addAction(UIAlertAction(title: "Aceptar", style: .default) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        })
        present(alerta, animated: true)
    }

    private func mostrarProducto() {
        title = producto.nombre
        nombreLabel.text = producto.nombre
        precioLabel.text = String(format: "Precio: S/ %.2f", producto.precio)
        stockLabel.text = "Stock: \(producto.stock)"
        cantidadLabel.text = "\(cantidad)"
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

