import UIKit

class OpcionesCulturaViewController: UIViewController,
                                      UITableViewDataSource,
                                      UITableViewDelegate {

    @IBOutlet weak var imagenCultura: UIImageView!
    @IBOutlet weak var nombreCultura: UILabel!
    @IBOutlet weak var tablaOpciones: UITableView!

    var cultura: Cultura?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = cultura?.nombre
        imagenCultura.layer.cornerRadius = 14
        imagenCultura.clipsToBounds = true
        nombreCultura.text = cultura?.nombre
        imagenCultura.image = UIImage(named: cultura?.nombreImagen ?? "")
    }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return cultura?.opciones.count ?? 0
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "opcionCell",
            for: indexPath
        ) as! OpcionTableViewCell

        guard let opcion = cultura?.opciones[indexPath.row] else {
            return cell
        }

        cell.tituloOpcion.text = opcion.titulo
        cell.imagenOpcion.image = UIImage(named: opcion.nombreImagen)
        return cell
    }
}
