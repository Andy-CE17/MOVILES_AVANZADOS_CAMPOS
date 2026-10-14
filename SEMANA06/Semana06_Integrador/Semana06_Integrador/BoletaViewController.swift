import UIKit

class BoletaViewController: UIViewController {
    @IBOutlet weak var boletaTextView: UITextView!

    var carrito: CarritoModel!
    var cliente: ClienteModel!

    @IBAction func cerrar(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

