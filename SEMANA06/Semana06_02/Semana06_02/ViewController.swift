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

        performSegue(withIdentifier: "mostrarConfirmacion", sender: oCliente)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mostrarConfirmacion",
           let pantallaConfirmacion = segue.destination as? ViewControllerConfirmacion,
           let cliente = sender as? ClienteModel {
            pantallaConfirmacion.pCliente = cliente
        }
    }
}
