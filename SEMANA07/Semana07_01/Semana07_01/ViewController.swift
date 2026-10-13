import UIKit

class ViewController: UIViewController,
       UITableViewDelegate,UITableViewDataSource {

    var listaProfesores = [
        Profesor(nombre: "Jaime Gomez", cargo: "Coordinador de Software"),
        Profesor(nombre: "Jaime Farfan", cargo: "Docente de Software TC"),
        Profesor(nombre: "Juan León", cargo: "Docente de Software TC"),
        Profesor(nombre: "Silvia Montoya", cargo: "Docente de Software TC"),
        Profesor(nombre: "Theobaldo Diaz", cargo: "Docente de Software TC"),
        Profesor(nombre: "Elliot Garamendi", cargo: "Docente de Software TC"),
        Profesor(nombre: "Edwin Huerto", cargo: "Docente de Redes TC")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return listaProfesores.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
