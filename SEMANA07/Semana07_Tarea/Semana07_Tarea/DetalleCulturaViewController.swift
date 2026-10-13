import UIKit

class DetalleCulturaViewController: UIViewController {

    @IBOutlet weak var imagenDetalle: UIImageView!
    @IBOutlet weak var nombreDetalle: UILabel!
    @IBOutlet weak var regionDetalle: UILabel!
    @IBOutlet weak var descripcionDetalle: UILabel!

    var cultura: Cultura?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detalle de la Cultura"
        imagenDetalle.layer.cornerRadius = 14
        imagenDetalle.clipsToBounds = true
        mostrarCultura()
    }

    private func mostrarCultura() {
        guard let cultura else { return }
        nombreDetalle.text = cultura.nombre
        regionDetalle.text = cultura.region
        descripcionDetalle.text = cultura.descripcion
        imagenDetalle.image = UIImage(named: cultura.nombreImagen)
    }
}
