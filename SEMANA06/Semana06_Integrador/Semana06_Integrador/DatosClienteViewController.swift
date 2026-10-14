import UIKit

class DatosClienteViewController: UIViewController {
    @IBOutlet weak var apellidosTextField: UITextField!
    @IBOutlet weak var nombresTextField: UITextField!
    @IBOutlet weak var dniTextField: UITextField!

    @IBAction func confirmarCompra(_ sender: UIButton) {
        performSegue(withIdentifier: "verBoleta", sender: sender)
    }
}

