import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tablaCulturas: UITableView!

    let culturas = [
        Cultura(
            nombre: "Cultura Chavín",
            region: "Áncash",
            nombreImagen: "cultura_chavin",
            opciones: [
                OpcionCultural(titulo: "Chavín de Huántar", descripcion: "Chavín de Huántar fue el principal centro ceremonial de esta cultura. Sus templos de piedra, plazas y galerías subterráneas recibieron peregrinos de diferentes regiones de los Andes.", nombreImagen: "cultura_chavin"),
                OpcionCultural(titulo: "Lanzón Monolítico", descripcion: "El Lanzón Monolítico es una escultura de piedra ubicada dentro del templo de Chavín de Huántar. Representa una divinidad con rasgos humanos y animales y tuvo una función religiosa central.", nombreImagen: "cultura_chavin"),
                OpcionCultural(titulo: "Cabezas clavas", descripcion: "Las cabezas clavas son esculturas de piedra que estuvieron colocadas en los muros del templo. Combinan rasgos humanos, felinos, aves y serpientes vinculados con la religión chavín.", nombreImagen: "cultura_chavin")
            ]
        ),
        Cultura(
            nombre: "Cultura Nazca",
            region: "Ica",
            nombreImagen: "cultura_nazca",
            opciones: [
                OpcionCultural(titulo: "Líneas de Nazca", descripcion: "Las Líneas de Nazca son enormes geoglifos trazados sobre el desierto. Representan animales, plantas y figuras geométricas que pueden observarse con mayor claridad desde el aire.", nombreImagen: "cultura_nazca"),
                OpcionCultural(titulo: "Acueductos de Cantalloc", descripcion: "Los acueductos de Cantalloc permitieron aprovechar el agua subterránea en una región desértica. Sus accesos en forma de espiral facilitaron la limpieza y conservación de los canales.", nombreImagen: "cultura_nazca"),
                OpcionCultural(titulo: "Cerámica policroma", descripcion: "La cerámica nazca destacó por la variedad de colores y por sus representaciones de seres humanos, animales, plantas y seres mitológicos.", nombreImagen: "cultura_nazca")
            ]
        ),
        Cultura(
            nombre: "Cultura Moche",
            region: "La Libertad y Lambayeque",
            nombreImagen: "cultura_moche",
            opciones: [
                OpcionCultural(titulo: "Huacas del Sol y de la Luna", descripcion: "Las huacas del Sol y de la Luna fueron grandes construcciones de adobe. Funcionaron como centros administrativos y ceremoniales de la sociedad moche.", nombreImagen: "cultura_moche"),
                OpcionCultural(titulo: "Huacos retrato", descripcion: "Los huacos retrato representan rostros humanos con gran realismo. Gracias a ellos se conocen expresiones, enfermedades, costumbres y personajes de la sociedad moche.", nombreImagen: "cultura_moche"),
                OpcionCultural(titulo: "Señor de Sipán", descripcion: "El Señor de Sipán fue un importante gobernante moche. Su tumba contenía ornamentos de oro, plata y cobre que demostraron el alto desarrollo de la metalurgia moche.", nombreImagen: "cultura_moche")
            ]
        ),
        Cultura(
            nombre: "Cultura Chimú",
            region: "La Libertad",
            nombreImagen: "cultura_chimu",
            opciones: [
                OpcionCultural(titulo: "Chan Chan", descripcion: "Chan Chan fue la capital del reino Chimú y una de las ciudades de adobe más extensas del mundo. Estaba organizada en ciudadelas, plazas, depósitos y viviendas.", nombreImagen: "cultura_chimu"),
                OpcionCultural(titulo: "Orfebrería", descripcion: "Los artesanos chimú elaboraron máscaras, vasos, adornos y objetos ceremoniales con oro, plata y cobre mediante técnicas de gran precisión.", nombreImagen: "cultura_chimu"),
                OpcionCultural(titulo: "Canales de irrigación", descripcion: "Los chimú construyeron extensos canales para llevar agua a sus campos de cultivo y conectar diferentes valles de la costa norte del Perú.", nombreImagen: "cultura_chimu")
            ]
        ),
        Cultura(
            nombre: "Cultura Inca",
            region: "Cusco",
            nombreImagen: "cultura_inca",
            opciones: [
                OpcionCultural(titulo: "Machu Picchu", descripcion: "Machu Picchu es una ciudadela inca construida en el siglo XV. Destaca por su arquitectura de piedra y por su adaptación al paisaje montañoso del Cusco.", nombreImagen: "cultura_inca"),
                OpcionCultural(titulo: "Qhapaq Ñan", descripcion: "El Qhapaq Ñan fue una extensa red de caminos que comunicó los territorios del Tahuantinsuyo y facilitó el transporte, el comercio y la administración.", nombreImagen: "cultura_inca"),
                OpcionCultural(titulo: "Andenes agrícolas", descripcion: "Los andenes fueron terrazas construidas en las laderas de las montañas. Permitieron ampliar las áreas de cultivo, controlar el agua y reducir la erosión del suelo.", nombreImagen: "cultura_inca")
            ]
        )
    ]

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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "verOpcionesCultura",
              let celda = sender as? UITableViewCell,
              let indexPath = tablaCulturas.indexPath(for: celda),
              let destino = segue.destination
                as? OpcionesCulturaViewController else {
            return
        }

        destino.cultura = culturas[indexPath.row]
    }
}
