import Foundation

// ENUMS

enum SistemaTransporte: String {
    case linea1 = "Línea 1"
    case linea2 = "Línea 2"
    case metropolitano = "Metropolitano"
    case ramalLinea4 = "Ramal Línea 4"
}

enum EstadoEstacion: String {
    case operativa = "Operativa"
    case enConstruccion = "En construcción"
    case proyectada = "Proyectada"
}

enum TipoRuta: String {
    case directa = "Ruta directa"
    case multimodal = "Ruta multimodal"
    case futura = "Ruta futura / referencial"
}


// STRUCTS

struct Estacion {
    let id: String
    let codigo: String
    let nombre: String
    let distrito: String
    let sistema: SistemaTransporte
    let estado: EstadoEstacion
    let accesible: Bool
    let tieneAscensor: Bool
}

struct Conexion {
    let origenID: String
    let destinoID: String
    let estado: EstadoEstacion
    let descripcion: String
}

struct TransporteComplementario {
    let ruta: String
    let empresa: String
    let origenID: String
    let destinoID: String
    let paraderoSubida: String
    let distritoSubida: String
    let paraderoBajada: String
    let distritoBajada: String
    let tiempoReferencial: Int
}
