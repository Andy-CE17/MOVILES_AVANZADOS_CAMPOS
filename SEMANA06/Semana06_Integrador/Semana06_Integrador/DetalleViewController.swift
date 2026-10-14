import UIKit

class DetalleViewController: UIViewController {
    @IBOutlet weak var nombreLabel: UILabel!
    @IBOutlet weak var precioLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var cantidadLabel: UILabel!

    @IBAction func disminuirCantidad(_ sender: UIButton) {}
    @IBAction func aumentarCantidad(_ sender: UIButton) {}
    @IBAction func agregarAlCarrito(_ sender: UIButton) {}
}

