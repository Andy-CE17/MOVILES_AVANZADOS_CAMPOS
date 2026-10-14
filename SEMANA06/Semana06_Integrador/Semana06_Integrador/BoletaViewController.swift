import UIKit

class BoletaViewController: UIViewController {
    @IBOutlet weak var boletaTextView: UITextView!

    @IBAction func cerrar(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

