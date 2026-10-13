import UIKit

class Profesor: NSObject {

    var nombre: String = ""
    var cargo: String = ""

    init(nombre: String, cargo: String) {
        self.nombre = nombre
        self.cargo = cargo
    }
}
