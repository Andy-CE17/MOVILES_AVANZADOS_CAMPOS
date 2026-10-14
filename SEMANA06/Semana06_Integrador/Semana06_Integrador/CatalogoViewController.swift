import UIKit

class CatalogoViewController: UIViewController {
    @IBOutlet weak var verCarritoButton: UIButton!

    let productos: [Producto] = [
        Producto(nombre: "Refrigeradora", precio: 2000, stock: 5),
        Producto(nombre: "Licuadora", precio: 250, stock: 10),
        Producto(nombre: "Laptop", precio: 3500, stock: 3),
        Producto(nombre: "Cocina", precio: 1200, stock: 4)
    ]

    let carrito = CarritoModel()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        verCarritoButton.setTitle(
            "Ver carrito (\(carrito.cantidadTotal()))",
            for: .normal
        )
    }

    @IBAction func productoTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "verDetalle", sender: sender)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "verDetalle":
            guard let button = sender as? UIButton,
                  productos.indices.contains(button.tag),
                  let destino = segue.destination as? DetalleViewController else {
                return
            }

            destino.producto = productos[button.tag]
            destino.carrito = carrito

        case "verCarrito":
            guard let destino = segue.destination as? CarritoViewController else {
                return
            }
            destino.carrito = carrito

        default:
            break
        }
    }
}

