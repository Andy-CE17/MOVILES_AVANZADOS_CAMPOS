import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tfApellido: UITextField!
    @IBOutlet weak var tfNombre: UITextField!
    @IBOutlet weak var tfDni: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func btnContinuar(_ sender: Any) {
        let oCliente = ClienteModel(
            pCodigo: 0,
            pApellido: tfApellido.text ?? "",
            pNombre: tfNombre.text ?? "",
            pDni: tfDni.text ?? ""
        )

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let pantallaConfirmacion = storyboard.instantiateViewController(
            withIdentifier: "ViewControllerConfirmacion"
        ) as? ViewControllerConfirmacion else {
            return
        }

        pantallaConfirmacion.pCliente = oCliente
        present(pantallaConfirmacion, animated: true)
    }
}
