import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var personasArreglo = ["Jaime Gomez", "Juan León", "Silvia Montoya", "Theobaldo Diaz", "Elliot Garamendi"]
    var personasImagenArreglo = ["avatar1", "avatar2", "avatar3", "avatar4", "avatar5"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return personasArreglo.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "miCell") as? PersonasTableViewCell
        cell?.personaNombre.text = personasArreglo[indexPath.row]
        cell?.personaImagen.image = UIImage(named: personasImagenArreglo[indexPath.row])
        return cell!
    }
}
