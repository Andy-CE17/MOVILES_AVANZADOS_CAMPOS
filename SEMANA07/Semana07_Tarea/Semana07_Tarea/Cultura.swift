import Foundation

struct OpcionCultural {
    let titulo: String
    let descripcion: String
    let nombreImagen: String
}

struct Cultura {
    let nombre: String
    let region: String
    let nombreImagen: String
    let opciones: [OpcionCultural]
}
