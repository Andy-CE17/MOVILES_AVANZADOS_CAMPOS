import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let culturas = [
        Cultura(
            nombre: "Cultura Chavín",
            region: "Áncash",
            descripcion: "La cultura Chavín se desarrolló alrededor del centro ceremonial de Chavín de Huántar. Destacó por su arquitectura de piedra, sus galerías internas y esculturas religiosas como las cabezas clavas y el Lanzón Monolítico.",
            nombreImagen: "cultura_chavin"
        ),
        Cultura(
            nombre: "Cultura Nazca",
            region: "Ica",
            descripcion: "La cultura Nazca se desarrolló en los valles de la costa sur del Perú. Es reconocida por las Líneas de Nazca, su cerámica policroma y sus sistemas de acueductos construidos para aprovechar el agua en una zona desértica.",
            nombreImagen: "cultura_nazca"
        ),
        Cultura(
            nombre: "Cultura Moche",
            region: "La Libertad y Lambayeque",
            descripcion: "La cultura Moche se desarrolló en la costa norte del Perú. Sobresalió por sus huacos retrato, la metalurgia y grandes construcciones de adobe como las huacas del Sol y de la Luna.",
            nombreImagen: "cultura_moche"
        ),
        Cultura(
            nombre: "Cultura Chimú",
            region: "La Libertad",
            descripcion: "La cultura Chimú tuvo como capital a Chan Chan, una extensa ciudad construida en adobe. Sus habitantes destacaron en la orfebrería, la pesca, la agricultura y el manejo de canales de irrigación.",
            nombreImagen: "cultura_chimu"
        ),
        Cultura(
            nombre: "Cultura Inca",
            region: "Cusco",
            descripcion: "La cultura Inca organizó el Tahuantinsuyo y tuvo al Cusco como su centro político. Destacó por su red de caminos, su organización administrativa y construcciones de piedra como Machu Picchu.",
            nombreImagen: "cultura_inca"
        )
    ]

    private var culturaSeleccionada: Cultura?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Culturas Peruanas"
    }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return culturas.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "culturaCell",
            for: indexPath
        ) as! CulturaTableViewCell

        let cultura = culturas[indexPath.row]
        cell.nombreCultura.text = cultura.nombre
        cell.regionCultura.text = cultura.region
        cell.imagenCultura.image = UIImage(named: cultura.nombreImagen)
        return cell
    }

    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        culturaSeleccionada = culturas[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "verDetalleCultura", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "verDetalleCultura",
           let detalle = segue.destination as? DetalleCulturaViewController {
            detalle.cultura = culturaSeleccionada
        }
    }
}
