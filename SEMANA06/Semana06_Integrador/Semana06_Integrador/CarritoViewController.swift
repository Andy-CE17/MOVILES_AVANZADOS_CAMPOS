import UIKit

class CarritoViewController: UIViewController {
    @IBOutlet weak var detalleTextView: UITextView!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var descuentoLabel: UILabel!
    @IBOutlet weak var igvLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!

    var carrito: CarritoModel!
}

