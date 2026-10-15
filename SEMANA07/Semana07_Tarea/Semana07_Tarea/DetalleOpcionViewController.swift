import UIKit

class DetalleOpcionViewController: UIViewController {

    @IBOutlet weak var tituloOpcion: UILabel!
    @IBOutlet weak var imagenOpcion: UIImageView!
    @IBOutlet weak var descripcionOpcion: UILabel!

    var opcion: OpcionCultural?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detalle"
        imagenOpcion.layer.cornerRadius = 14
        imagenOpcion.clipsToBounds = true
        tituloOpcion.text = opcion?.titulo
        descripcionOpcion.text = opcion?.descripcion
        imagenOpcion.image = UIImage(named: opcion?.nombreImagen ?? "")
    }
}
