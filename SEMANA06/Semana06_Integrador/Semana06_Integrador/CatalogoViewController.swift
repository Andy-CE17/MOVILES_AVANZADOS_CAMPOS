import UIKit

class CatalogoViewController: UIViewController {
    @IBOutlet weak var verCarritoButton: UIButton!

    @IBAction func productoTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "verDetalle", sender: sender)
    }
}

