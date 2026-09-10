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

// DATOS DE LA RED

let estacionesLinea1: [Estacion] = [
    Estacion(id: "L1-01", codigo: "L1-01", nombre: "Villa El Salvador", distrito: "Villa El Salvador", sistema: .linea1, estado: .operativa, accesible: true, tieneAscensor: true),
    Estacion(id: "L1-02", codigo: "L1-02", nombre: "Parque Industrial", distrito: "Villa El Salvador", sistema: .linea1, estado: .operativa, accesible: true, tieneAscensor: true),
    Estacion(id: "L1-03", codigo: "L1-03", nombre: "Pumacahua", distrito: "Villa El Salvador", sistema: .linea1, estado: .operativa, accesible: true, tieneAscensor: false),
    Estacion(id: "L1-04", codigo: "L1-04", nombre: "Villa María", distrito: "Villa María del Triunfo", sistema: .linea1, estado: .operativa, accesible: true, tieneAscensor: false),
    Estacion(id: "L1-05", codigo: "L1-05", nombre: "María Auxiliadora", distrito: "Villa María del Triunfo", sistema: .linea1, estado: .operativa, accesible: true, tieneAscensor: false),
    Estacion(id: "L1-06", codigo: "L1-06", nombre: "San Juan", distrito: "San Juan de Miraflores", sistema: .linea1, estado: .operativa, accesible: true, tieneAscensor: true),
    Estacion(id: "L1-07", codigo: "L1-07", nombre: "Atocongo", distrito: "San Juan de Miraflores", sistema: .linea1, estado: .operativa, accesible: true, tieneAscensor: true),
    Estacion(id: "L1-08", codigo: "L1-08", nombre: "Jorge Chávez", distrito: "Santiago de Surco", sistema: .linea1, estado: .operativa, accesible: true, tieneAscensor: true),
    Estacion(id: "L1-09", codigo: "L1-09", nombre: "Ayacucho", distrito: "Santiago de Surco", sistema: .linea1, estado: .operativa, accesible: true, tieneAscensor: true),
    Estacion(id: "L1-10", codigo: "L1-10", nombre: "Cabitos", distrito: "Santiago de Surco", sistema: .linea1, estado: .operativa, accesible: true, tieneAscensor: true),
    Estacion(id: "L1-11", codigo: "L1-11", nombre: "Angamos", distrito: "San Borja", sistema: .linea1, estado: .operativa, accesible: true, tieneAscensor: true),
    Estacion(id: "L1-12", codigo: "L1-12", nombre: "San Borja Sur", distrito: "San Borja", sistema: .linea1, estado: .operativa, accesible: true, tieneAscensor: false),
    Estacion(id: "L1-13", codigo: "L1-13", nombre: "La Cultura", distrito: "San Borja", sistema: .linea1, estado: .operativa, accesible: true, tieneAscensor: true),
    Estacion(id: "L1-14", codigo: "L1-14", nombre: "Arriola", distrito: "La Victoria", sistema: .linea1, estado: .operativa, accesible: true, tieneAscensor: true),
    Estacion(id: "L1-15", codigo: "L1-15", nombre: "Gamarra", distrito: "La Victoria", sistema: .linea1, estado: .operativa, accesible: true, tieneAscensor: true),
    Estacion(id: "L1-16", codigo: "L1-16", nombre: "Grau", distrito: "La Victoria", sistema: .linea1, estado: .operativa, accesible: true, tieneAscensor: true),
    Estacion(id: "L1-17", codigo: "L1-17", nombre: "El Ángel", distrito: "Cercado de Lima", sistema: .linea1, estado: .operativa, accesible: true, tieneAscensor: true),
    Estacion(id: "L1-18", codigo: "L1-18", nombre: "Presbítero Maestro", distrito: "Cercado de Lima", sistema: .linea1, estado: .operativa, accesible: true, tieneAscensor: true),
    Estacion(id: "L1-19", codigo: "L1-19", nombre: "Caja de Agua", distrito: "San Juan de Lurigancho", sistema: .linea1, estado: .operativa, accesible: true, tieneAscensor: true),
    Estacion(id: "L1-20", codigo: "L1-20", nombre: "Pirámide del Sol", distrito: "San Juan de Lurigancho", sistema: .linea1, estado: .operativa, accesible: true, tieneAscensor: true),
    Estacion(id: "L1-21", codigo: "L1-21", nombre: "Los Jardines", distrito: "San Juan de Lurigancho", sistema: .linea1, estado: .operativa, accesible: true, tieneAscensor: true),
    Estacion(id: "L1-22", codigo: "L1-22", nombre: "Los Postes", distrito: "San Juan de Lurigancho", sistema: .linea1, estado: .operativa, accesible: true, tieneAscensor: true),
    Estacion(id: "L1-23", codigo: "L1-23", nombre: "San Carlos", distrito: "San Juan de Lurigancho", sistema: .linea1, estado: .operativa, accesible: true, tieneAscensor: true),
    Estacion(id: "L1-24", codigo: "L1-24", nombre: "San Martín", distrito: "San Juan de Lurigancho", sistema: .linea1, estado: .operativa, accesible: true, tieneAscensor: true),
    Estacion(id: "L1-25", codigo: "L1-25", nombre: "Santa Rosa", distrito: "San Juan de Lurigancho", sistema: .linea1, estado: .operativa, accesible: true, tieneAscensor: true),
    Estacion(id: "L1-26", codigo: "L1-26", nombre: "Bayóvar", distrito: "San Juan de Lurigancho", sistema: .linea1, estado: .operativa, accesible: true, tieneAscensor: true)
]

let estacionesLinea2: [Estacion] = [
    Estacion(id: "L2-E01", codigo: "E01", nombre: "Puerto del Callao", distrito: "Callao", sistema: .linea2, estado: .enConstruccion, accesible: true, tieneAscensor: true),
    Estacion(id: "L2-E02", codigo: "E02", nombre: "Buenos Aires", distrito: "Callao", sistema: .linea2, estado: .enConstruccion, accesible: true, tieneAscensor: true),
    Estacion(id: "L2-E03", codigo: "E03", nombre: "Juan Pablo II", distrito: "Callao", sistema: .linea2, estado: .enConstruccion, accesible: true, tieneAscensor: true),
    Estacion(id: "L2-E04", codigo: "E04", nombre: "Insurgentes", distrito: "Bellavista", sistema: .linea2, estado: .enConstruccion, accesible: true, tieneAscensor: true),
    Estacion(id: "L2-E05", codigo: "E05", nombre: "Carmen de la Legua", distrito: "Carmen de la Legua Reynoso", sistema: .linea2, estado: .enConstruccion, accesible: true, tieneAscensor: true),
    Estacion(id: "L2-E06", codigo: "E06", nombre: "Óscar R. Benavides", distrito: "Cercado de Lima", sistema: .linea2, estado: .enConstruccion, accesible: true, tieneAscensor: true),
    Estacion(id: "L2-E07", codigo: "E07", nombre: "San Marcos", distrito: "Cercado de Lima", sistema: .linea2, estado: .enConstruccion, accesible: true, tieneAscensor: true),
    Estacion(id: "L2-E08", codigo: "E08", nombre: "Elio", distrito: "Cercado de Lima", sistema: .linea2, estado: .enConstruccion, accesible: true, tieneAscensor: true),
    Estacion(id: "L2-E09", codigo: "E09", nombre: "La Alborada", distrito: "Cercado de Lima", sistema: .linea2, estado: .enConstruccion, accesible: true, tieneAscensor: true),
    Estacion(id: "L2-E10", codigo: "E10", nombre: "Tingo María", distrito: "Breña", sistema: .linea2, estado: .enConstruccion, accesible: true, tieneAscensor: true),
    Estacion(id: "L2-E11", codigo: "E11", nombre: "Parque Murillo", distrito: "Breña", sistema: .linea2, estado: .enConstruccion, accesible: true, tieneAscensor: true),
    Estacion(id: "L2-E12", codigo: "E12", nombre: "Plaza Bolognesi", distrito: "Cercado de Lima", sistema: .linea2, estado: .enConstruccion, accesible: true, tieneAscensor: true),
    Estacion(id: "L2-E13", codigo: "E13", nombre: "Estación Central", distrito: "Cercado de Lima", sistema: .linea2, estado: .enConstruccion, accesible: true, tieneAscensor: true),
    Estacion(id: "L2-E14", codigo: "E14", nombre: "Manco Cápac", distrito: "La Victoria", sistema: .linea2, estado: .enConstruccion, accesible: true, tieneAscensor: true),
    Estacion(id: "L2-E15", codigo: "E15", nombre: "Cangallo", distrito: "La Victoria", sistema: .linea2, estado: .enConstruccion, accesible: true, tieneAscensor: true),
    Estacion(id: "L2-E16", codigo: "E16", nombre: "28 de Julio", distrito: "La Victoria", sistema: .linea2, estado: .enConstruccion, accesible: true, tieneAscensor: true),
    Estacion(id: "L2-E17", codigo: "E17", nombre: "Nicolás Ayllón", distrito: "La Victoria", sistema: .linea2, estado: .enConstruccion, accesible: true, tieneAscensor: true),
    Estacion(id: "L2-E18", codigo: "E18", nombre: "Circunvalación", distrito: "San Luis", sistema: .linea2, estado: .enConstruccion, accesible: true, tieneAscensor: true),
    Estacion(id: "L2-E19", codigo: "E19", nombre: "San Juan de Dios", distrito: "San Luis", sistema: .linea2, estado: .enConstruccion, accesible: true, tieneAscensor: true),
    Estacion(id: "L2-E20", codigo: "E20", nombre: "Evitamiento", distrito: "Santa Anita", sistema: .linea2, estado: .operativa, accesible: true, tieneAscensor: true),
    Estacion(id: "L2-E21", codigo: "E21", nombre: "Óvalo Santa Anita", distrito: "Santa Anita", sistema: .linea2, estado: .operativa, accesible: true, tieneAscensor: true),
    Estacion(id: "L2-E22", codigo: "E22", nombre: "Colectora Industrial", distrito: "Santa Anita", sistema: .linea2, estado: .operativa, accesible: true, tieneAscensor: true),
    Estacion(id: "L2-E23", codigo: "E23", nombre: "Hermilio Valdizán", distrito: "Santa Anita", sistema: .linea2, estado: .operativa, accesible: true, tieneAscensor: true),
    Estacion(id: "L2-E24", codigo: "E24", nombre: "Mercado Santa Anita", distrito: "Santa Anita", sistema: .linea2, estado: .operativa, accesible: true, tieneAscensor: true),
    Estacion(id: "L2-E25", codigo: "E25", nombre: "Vista Alegre", distrito: "Ate", sistema: .linea2, estado: .enConstruccion, accesible: true, tieneAscensor: true),
    Estacion(id: "L2-E26", codigo: "E26", nombre: "Prolongación Javier Prado", distrito: "Ate", sistema: .linea2, estado: .enConstruccion, accesible: true, tieneAscensor: true),
    Estacion(id: "L2-E27", codigo: "E27", nombre: "Municipalidad de Ate", distrito: "Ate", sistema: .linea2, estado: .enConstruccion, accesible: true, tieneAscensor: true)
]
