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

struct TarjetaTransporte {
    let identificador: String
    var saldo: Decimal
}

var tarjeta = TarjetaTransporte(identificador: "DEMO-001", saldo: 10)
// Tarifa plana por viaje, simulada para el ejercicio; no es una tarifa oficial.
var tarifaSimulada: Decimal = Decimal(string: "1.50")!

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

let estacionesMetropolitano: [Estacion] = [
    Estacion(id: "MET-01", codigo: "MET-01", nombre: "Chimpu Ocllo", distrito: "Carabayllo", sistema: .metropolitano, estado: .operativa, accesible: true, tieneAscensor: false),
    Estacion(id: "MET-02", codigo: "MET-02", nombre: "Los Incas", distrito: "Comas", sistema: .metropolitano, estado: .operativa, accesible: true, tieneAscensor: false),
    Estacion(id: "MET-03", codigo: "MET-03", nombre: "Andrés Belaunde", distrito: "Comas", sistema: .metropolitano, estado: .operativa, accesible: true, tieneAscensor: false),
    Estacion(id: "MET-04", codigo: "MET-04", nombre: "22 de Agosto", distrito: "Comas", sistema: .metropolitano, estado: .operativa, accesible: true, tieneAscensor: false),
    Estacion(id: "MET-05", codigo: "MET-05", nombre: "Las Vegas", distrito: "Comas", sistema: .metropolitano, estado: .operativa, accesible: true, tieneAscensor: false),
    Estacion(id: "MET-06", codigo: "MET-06", nombre: "Universidad", distrito: "Comas", sistema: .metropolitano, estado: .operativa, accesible: true, tieneAscensor: false),
    Estacion(id: "MET-07", codigo: "MET-07", nombre: "Naranjal", distrito: "Independencia", sistema: .metropolitano, estado: .operativa, accesible: true, tieneAscensor: true),
    Estacion(id: "MET-08", codigo: "MET-08", nombre: "Izaguirre", distrito: "Independencia", sistema: .metropolitano, estado: .operativa, accesible: true, tieneAscensor: false),
    Estacion(id: "MET-09", codigo: "MET-09", nombre: "Pacífico", distrito: "Independencia", sistema: .metropolitano, estado: .operativa, accesible: true, tieneAscensor: false),
    Estacion(id: "MET-10", codigo: "MET-10", nombre: "Independencia", distrito: "Independencia", sistema: .metropolitano, estado: .operativa, accesible: true, tieneAscensor: false),
    Estacion(id: "MET-11", codigo: "MET-11", nombre: "Los Jazmines", distrito: "Independencia", sistema: .metropolitano, estado: .operativa, accesible: true, tieneAscensor: false),
    Estacion(id: "MET-12", codigo: "MET-12", nombre: "Tomás Valle", distrito: "San Martín de Porres", sistema: .metropolitano, estado: .operativa, accesible: true, tieneAscensor: false),
    Estacion(id: "MET-13", codigo: "MET-13", nombre: "El Milagro", distrito: "San Martín de Porres", sistema: .metropolitano, estado: .operativa, accesible: true, tieneAscensor: false),
    Estacion(id: "MET-14", codigo: "MET-14", nombre: "Honorio Delgado", distrito: "San Martín de Porres", sistema: .metropolitano, estado: .operativa, accesible: true, tieneAscensor: false),
    Estacion(id: "MET-15", codigo: "MET-15", nombre: "UNI", distrito: "Rímac", sistema: .metropolitano, estado: .operativa, accesible: true, tieneAscensor: false),
    Estacion(id: "MET-16", codigo: "MET-16", nombre: "Parque del Trabajo", distrito: "Rímac", sistema: .metropolitano, estado: .operativa, accesible: true, tieneAscensor: false),
    Estacion(id: "MET-17", codigo: "MET-17", nombre: "Caquetá", distrito: "Rímac", sistema: .metropolitano, estado: .operativa, accesible: true, tieneAscensor: false),

    Estacion(id: "MET-18", codigo: "MET-18", nombre: "Ramón Castilla", distrito: "Cercado de Lima", sistema: .metropolitano, estado: .operativa, accesible: true, tieneAscensor: false),
    Estacion(id: "MET-19", codigo: "MET-19", nombre: "Tacna", distrito: "Cercado de Lima", sistema: .metropolitano, estado: .operativa, accesible: true, tieneAscensor: false),
    Estacion(id: "MET-20", codigo: "MET-20", nombre: "Jirón de la Unión", distrito: "Cercado de Lima", sistema: .metropolitano, estado: .operativa, accesible: true, tieneAscensor: false),
    Estacion(id: "MET-21", codigo: "MET-21", nombre: "Colmena", distrito: "Cercado de Lima", sistema: .metropolitano, estado: .operativa, accesible: true, tieneAscensor: false),

    Estacion(id: "MET-22", codigo: "MET-22", nombre: "Dos de Mayo", distrito: "Cercado de Lima", sistema: .metropolitano, estado: .operativa, accesible: true, tieneAscensor: false),
    Estacion(id: "MET-23", codigo: "MET-23", nombre: "Quilca", distrito: "Cercado de Lima", sistema: .metropolitano, estado: .operativa, accesible: true, tieneAscensor: false),
    Estacion(id: "MET-24", codigo: "MET-24", nombre: "España", distrito: "Cercado de Lima", sistema: .metropolitano, estado: .operativa, accesible: true, tieneAscensor: false),

    Estacion(id: "MET-25", codigo: "MET-25", nombre: "Central", distrito: "Cercado de Lima", sistema: .metropolitano, estado: .operativa, accesible: true, tieneAscensor: true),
    Estacion(id: "MET-26", codigo: "MET-26", nombre: "Estadio Nacional", distrito: "Cercado de Lima", sistema: .metropolitano, estado: .operativa, accesible: true, tieneAscensor: false),
    Estacion(id: "MET-27", codigo: "MET-27", nombre: "México", distrito: "La Victoria", sistema: .metropolitano, estado: .operativa, accesible: true, tieneAscensor: false),
    Estacion(id: "MET-28", codigo: "MET-28", nombre: "Canadá", distrito: "La Victoria", sistema: .metropolitano, estado: .operativa, accesible: true, tieneAscensor: false),
    Estacion(id: "MET-29", codigo: "MET-29", nombre: "Javier Prado", distrito: "San Isidro", sistema: .metropolitano, estado: .operativa, accesible: true, tieneAscensor: false),
    Estacion(id: "MET-30", codigo: "MET-30", nombre: "Andrés Reyes", distrito: "San Isidro", sistema: .metropolitano, estado: .operativa, accesible: true, tieneAscensor: false),
    Estacion(id: "MET-31", codigo: "MET-31", nombre: "Canaval y Moreyra", distrito: "San Isidro", sistema: .metropolitano, estado: .operativa, accesible: true, tieneAscensor: false),
    Estacion(id: "MET-32", codigo: "MET-32", nombre: "Aramburú", distrito: "San Isidro", sistema: .metropolitano, estado: .operativa, accesible: true, tieneAscensor: false),
    Estacion(id: "MET-33", codigo: "MET-33", nombre: "Domingo Orué", distrito: "Surquillo", sistema: .metropolitano, estado: .operativa, accesible: true, tieneAscensor: false),
    Estacion(id: "MET-34", codigo: "MET-34", nombre: "Angamos", distrito: "Surquillo", sistema: .metropolitano, estado: .operativa, accesible: true, tieneAscensor: false),
    Estacion(id: "MET-35", codigo: "MET-35", nombre: "Ricardo Palma", distrito: "Miraflores", sistema: .metropolitano, estado: .operativa, accesible: true, tieneAscensor: false),
    Estacion(id: "MET-36", codigo: "MET-36", nombre: "Benavides", distrito: "Miraflores", sistema: .metropolitano, estado: .operativa, accesible: true, tieneAscensor: false),
    Estacion(id: "MET-37", codigo: "MET-37", nombre: "28 de Julio", distrito: "Miraflores", sistema: .metropolitano, estado: .operativa, accesible: true, tieneAscensor: false),
    Estacion(id: "MET-38", codigo: "MET-38", nombre: "Plaza de Flores", distrito: "Barranco", sistema: .metropolitano, estado: .operativa, accesible: true, tieneAscensor: false),
    Estacion(id: "MET-39", codigo: "MET-39", nombre: "Balta", distrito: "Barranco", sistema: .metropolitano, estado: .operativa, accesible: true, tieneAscensor: false),
    Estacion(id: "MET-40", codigo: "MET-40", nombre: "Bulevar", distrito: "Barranco", sistema: .metropolitano, estado: .operativa, accesible: true, tieneAscensor: false),
    Estacion(id: "MET-41", codigo: "MET-41", nombre: "Estadio Unión", distrito: "Barranco", sistema: .metropolitano, estado: .operativa, accesible: true, tieneAscensor: false),
    Estacion(id: "MET-42", codigo: "MET-42", nombre: "Escuela Militar", distrito: "Chorrillos", sistema: .metropolitano, estado: .operativa, accesible: true, tieneAscensor: false),
    Estacion(id: "MET-43", codigo: "MET-43", nombre: "Terán", distrito: "Chorrillos", sistema: .metropolitano, estado: .operativa, accesible: true, tieneAscensor: false),
    Estacion(id: "MET-44", codigo: "MET-44", nombre: "Rosario de Villa", distrito: "Chorrillos", sistema: .metropolitano, estado: .operativa, accesible: true, tieneAscensor: false),
    Estacion(id: "MET-45", codigo: "MET-45", nombre: "Matellini", distrito: "Chorrillos", sistema: .metropolitano, estado: .operativa, accesible: true, tieneAscensor: true)
]

let estacionesRamalLinea4: [Estacion] = [
    Estacion(id: "L4-01", codigo: "L4-01", nombre: "Gambetta", distrito: "Callao", sistema: .ramalLinea4, estado: .enConstruccion, accesible: true, tieneAscensor: true),
    Estacion(id: "L4-02", codigo: "L4-02", nombre: "Canta Callao", distrito: "Callao", sistema: .ramalLinea4, estado: .enConstruccion, accesible: true, tieneAscensor: true),
    Estacion(id: "L4-03", codigo: "L4-03", nombre: "Bocanegra", distrito: "Callao", sistema: .ramalLinea4, estado: .enConstruccion, accesible: true, tieneAscensor: true),
    Estacion(id: "L4-04", codigo: "L4-04", nombre: "Aeropuerto", distrito: "Callao", sistema: .ramalLinea4, estado: .enConstruccion, accesible: true, tieneAscensor: true),
    Estacion(id: "L4-05", codigo: "L4-05", nombre: "El Olivar", distrito: "Callao", sistema: .ramalLinea4, estado: .enConstruccion, accesible: true, tieneAscensor: true),
    Estacion(id: "L4-06", codigo: "L4-06", nombre: "Quilca", distrito: "Callao", sistema: .ramalLinea4, estado: .enConstruccion, accesible: true, tieneAscensor: true),
    Estacion(id: "L4-07", codigo: "L4-07", nombre: "Morales Duárez", distrito: "Callao", sistema: .ramalLinea4, estado: .enConstruccion, accesible: true, tieneAscensor: true),
    Estacion(id: "L4-08", codigo: "L4-08", nombre: "Carmen de la Legua", distrito: "Carmen de la Legua Reynoso", sistema: .ramalLinea4, estado: .enConstruccion, accesible: true, tieneAscensor: true)
]

let todasLasEstaciones =
    estacionesLinea1 +
    estacionesLinea2 +
    estacionesMetropolitano +
    estacionesRamalLinea4
func normalizarTexto(_ texto: String) -> String {
    return texto
        .folding(options: [.diacriticInsensitive, .caseInsensitive], locale: .current)
        .trimmingCharacters(in: .whitespacesAndNewlines)
}

func distanciaEdicion(_ texto1: String, _ texto2: String) -> Int {
    let a = Array(texto1)
    let b = Array(texto2)

    var matriz = Array(
        repeating: Array(repeating: 0, count: b.count + 1),
        count: a.count + 1
    )

    for i in 0...a.count {
        matriz[i][0] = i
    }

    for j in 0...b.count {
        matriz[0][j] = j
    }

    if !a.isEmpty && !b.isEmpty {
        for i in 1...a.count {
            for j in 1...b.count {
                if a[i - 1] == b[j - 1] {
                    matriz[i][j] = matriz[i - 1][j - 1]
                } else {
                    matriz[i][j] = min(
                        matriz[i - 1][j] + 1,
                        matriz[i][j - 1] + 1,
                        matriz[i - 1][j - 1] + 1
                    )
                }
            }
        }
    }

    return matriz[a.count][b.count]
    
}


// RF01 - LISTAR ESTACIONES POR SISTEMA

func estacionesDelSistema(_ sistema: SistemaTransporte) -> [Estacion] {
    return todasLasEstaciones.filter {
        $0.sistema == sistema
    }
}

func mostrarTablaEstaciones(_ estaciones: [Estacion]) {
    print("")
    print("================================================================================")
    print("CÓDIGO     ESTACIÓN                         DISTRITO                    ESTADO")
    print("================================================================================")

    for estacion in estaciones {
        let codigo = estacion.codigo.padding(
            toLength: 10,
            withPad: " ",
            startingAt: 0
        )

        let nombre = estacion.nombre.padding(
            toLength: 32,
            withPad: " ",
            startingAt: 0
        )

        let distrito = estacion.distrito.padding(
            toLength: 28,
            withPad: " ",
            startingAt: 0
        )

        print("\(codigo)\(nombre)\(distrito)\(estacion.estado.rawValue)")
    }

    print("================================================================================")
    print("Total de estaciones: \(estaciones.count)")
}

// RF02 - BUSCAR ESTACIONES

func buscarEstaciones(_ texto: String) -> [Estacion] {
    let consulta = normalizarTexto(texto)

    guard !consulta.isEmpty else {
        return []
    }

    let coincidencias = todasLasEstaciones.filter { estacion in
        let nombre = normalizarTexto(estacion.nombre)
        let codigo = normalizarTexto(estacion.codigo)
        let distrito = normalizarTexto(estacion.distrito)

        return nombre.contains(consulta) ||
               codigo.contains(consulta) ||
               distrito.contains(consulta)
    }

    if !coincidencias.isEmpty {
        return coincidencias
    }

    guard consulta.count >= 5 else {
        return []
    }

    return todasLasEstaciones.filter { estacion in
        let nombre = normalizarTexto(estacion.nombre)

        return distanciaEdicion(consulta, nombre) <= 2
    }
}
var transportesComplementarios: [TransporteComplementario] = [
    TransporteComplementario(
        ruta: "SE-09",
        empresa: "Corredor Morado",
        origenID: "L1-23",
        destinoID: "MET-31",
        paraderoSubida: "San Carlos",
        distritoSubida: "San Juan de Lurigancho",
        paraderoBajada: "Canaval y Moreyra",
        distritoBajada: "San Isidro",
        tiempoReferencial: 42
    ),

    TransporteComplementario(
        ruta: "1068",
        empresa: "Nuevo Perú",
        origenID: "L1-16",
        destinoID: "L2-E21",
        paraderoSubida: "Grau",
        distritoSubida: "La Victoria",
        paraderoBajada: "Óvalo Santa Anita",
        distritoBajada: "Santa Anita",
        tiempoReferencial: 38
    ),

    TransporteComplementario(
        ruta: "4604",
        empresa: "Transporte urbano",
        origenID: "L2-E24",
        destinoID: "L1-14",
        paraderoSubida: "Mercado Santa Anita",
        distritoSubida: "Santa Anita",
        paraderoBajada: "Arriola",
        distritoBajada: "La Victoria",
        tiempoReferencial: 30
    ),

    TransporteComplementario(
        ruta: "1227",
        empresa: "Almirante Miguel Grau S.A.",
        origenID: "L2-E21",
        destinoID: "MET-34",
        paraderoSubida: "Óvalo Santa Anita",
        distritoSubida: "Santa Anita",
        paraderoBajada: "Vía Expresa - zona Angamos",
        distritoBajada: "Surquillo",
        tiempoReferencial: 44
    ),

    TransporteComplementario(
        ruta: "1073",
        empresa: "Transporte urbano",
        origenID: "L2-E23",
        destinoID: "MET-34",
        paraderoSubida: "Hermilio Valdizán",
        distritoSubida: "Santa Anita",
        paraderoBajada: "Vía Expresa - zona Angamos",
        distritoBajada: "Surquillo",
        tiempoReferencial: 40
    ),

    TransporteComplementario(
        ruta: "201 / 204",
        empresa: "Corredor Rojo",
        origenID: "L1-13",
        destinoID: "MET-29",
        paraderoSubida: "La Cultura",
        distritoSubida: "San Borja",
        paraderoBajada: "Javier Prado - Vía Expresa",
        distritoBajada: "San Isidro",
        tiempoReferencial: 25
    )
]

// RF03 - MOSTRAR INFORMACIÓN DE UNA ESTACIÓN

func mostrarInformacionEstacion(_ estacion: Estacion) {
    let tieneTransporte = !transportesDesde(estacion.id).isEmpty

    print("")
    print("==================================================")
    print("            INFORMACIÓN DE ESTACIÓN")
    print("==================================================")
    print("Nombre: \(estacion.nombre)")
    print("Código: \(estacion.codigo)")
    print("Distrito: \(estacion.distrito)")
    print("Sistema: \(estacion.sistema.rawValue)")
    print("Estado: \(estacion.estado.rawValue)")
    print("Accesibilidad: \(estacion.accesible ? "Sí" : "No")")
    print("Ascensor: \(estacion.tieneAscensor ? "Sí" : "No")")

    if estacion.estado != .operativa {
        print("Transporte complementario: No disponible")
    } else {
        print(
            "Transporte complementario: \(tieneTransporte ? "Disponible" : "No registrado")"
        )
    }

    print("==================================================")
}


let conexionesSistemas: [Conexion] = [
    Conexion(
        origenID: "L1-15",
        destinoID: "L2-E16",
        estado: .enConstruccion,
        descripcion: "Conexión entre Gamarra de Línea 1 y 28 de Julio de Línea 2"
    ),

    Conexion(
        origenID: "L2-E13",
        destinoID: "MET-25",
        estado: .enConstruccion,
        descripcion: "Conexión entre Estación Central de Línea 2 y Central del Metropolitano"
    ),

    Conexion(
        origenID: "L2-E05",
        destinoID: "L4-08",
        estado: .enConstruccion,
        descripcion: "Conexión entre Línea 2 y Ramal Línea 4 en Carmen de la Legua"
    )
]

func buscarEstacionPorID(_ id: String) -> Estacion? {
    return todasLasEstaciones.first {
        $0.id == id
    }
}


// RF04 - MOSTRAR PUNTOS DE CONEXIÓN

func mostrarPuntosConexion() {
    print("")
    print("==============================================================")
    print("           PUNTOS DE CONEXIÓN ENTRE SISTEMAS")
    print("==============================================================")

    for (indice, conexion) in conexionesSistemas.enumerated() {

        guard
            let origen = buscarEstacionPorID(conexion.origenID),
            let destino = buscarEstacionPorID(conexion.destinoID)
        else {
            continue
        }

        print("")
        print("Punto \(indice + 1)")
        print("--------------------------------------------------------------")
        print("\(origen.nombre) - \(origen.sistema.rawValue)")
        print("                  ↓")
        print("\(destino.nombre) - \(destino.sistema.rawValue)")
        print("")
        print("Distrito: \(origen.distrito)")
        print("Estado de conexión: \(conexion.estado.rawValue)")
        print("Detalle: \(conexion.descripcion)")
    }

    print("")
    print("==============================================================")
}

// RF05 - CONSULTAR TRANSPORTE COMPLEMENTARIO

func mostrarTransporteComplementario(desde estacion: Estacion) {
    print("")
    print("==============================================================")
    print("              TRANSPORTE COMPLEMENTARIO")
    print("==============================================================")

    if estacion.estado != .operativa {
        print("")
        print("Estación: \(estacion.nombre)")
        print("Sistema: \(estacion.sistema.rawValue)")
        print("Estado: \(estacion.estado.rawValue)")
        print("")
        print("El transporte complementario solo está disponible")
        print("para estaciones que se encuentran operativas.")
        print("")
        print("==============================================================")
        return
    }

    let rutasDisponibles = transportesDesde(estacion.id)

    if rutasDisponibles.isEmpty {
        print("")
        print("Estación: \(estacion.nombre)")
        print("Distrito: \(estacion.distrito)")
        print("")
        print("No hay transporte complementario registrado")
        print("para esta estación.")
        print("")
        print("==============================================================")
        return
    }

    print("")
    print("Estación: \(estacion.nombre)")
    print("Distrito: \(estacion.distrito)")
    print("Sistema: \(estacion.sistema.rawValue)")

    for (indice, transporte) in rutasDisponibles.enumerated() {
        print("")
        print("RUTA \(indice + 1)")
        print("--------------------------------------------------------------")
        print("Servicio: \(transporte.ruta)")
        print("Operador: \(transporte.empresa)")
        print("")
        print("Subida:")
        print("  \(transporte.paraderoSubida)")
        print("  Distrito: \(transporte.distritoSubida)")
        print("")
        print("                  ↓")
        print("")
        print("Bajada:")
        print("  \(transporte.paraderoBajada)")
        print("  Distrito: \(transporte.distritoBajada)")

        if let destino = buscarEstacionPorID(transporte.destinoID) {
            print("")
            print("Conecta con:")
            print("  \(destino.nombre) - \(destino.sistema.rawValue)")
        }

        print("")
        print("Tiempo referencial: ~\(transporte.tiempoReferencial) min")
    }

    print("")
    print("==============================================================")
}
// RF06 - CALCULAR RUTAS

struct PasoRuta {
    let origenID: String
    let destinoID: String
    let medio: String
    let tiempo: Int
    let esFuturo: Bool
    let transporte: TransporteComplementario?
}

struct RutaCalculada {
    let tipo: TipoRuta
    let pasos: [PasoRuta]
    let tiempoTotal: Int
}

func agregarPaso(
    _ paso: PasoRuta,
    al grafo: inout [String: [PasoRuta]],
    bidireccional: Bool = true
) {
    grafo[paso.origenID, default: []].append(paso)

    if bidireccional {
        var transporteInverso: TransporteComplementario? = nil

        if let transporte = paso.transporte {
            transporteInverso = TransporteComplementario(
                ruta: transporte.ruta,
                empresa: transporte.empresa,
                origenID: transporte.destinoID,
                destinoID: transporte.origenID,
                paraderoSubida: transporte.paraderoBajada,
                distritoSubida: transporte.distritoBajada,
                paraderoBajada: transporte.paraderoSubida,
                distritoBajada: transporte.distritoSubida,
                tiempoReferencial: transporte.tiempoReferencial
            )
        }

        let inverso = PasoRuta(
            origenID: paso.destinoID,
            destinoID: paso.origenID,
            medio: paso.medio,
            tiempo: paso.tiempo,
            esFuturo: paso.esFuturo,
            transporte: transporteInverso
        )

        grafo[paso.destinoID, default: []].append(inverso)
    }
}

func conectarSecuencia(
    _ estaciones: [Estacion],
    medio: String,
    minutos: Int,
    grafo: inout [String: [PasoRuta]]
) {
    guard estaciones.count > 1 else {
        return
    }

    for i in 0..<(estaciones.count - 1) {
        let origen = estaciones[i]
        let destino = estaciones[i + 1]

        if origen.estado == .operativa &&
           destino.estado == .operativa {

            let paso = PasoRuta(
                origenID: origen.id,
                destinoID: destino.id,
                medio: medio,
                tiempo: minutos,
                esFuturo: false,
                transporte: nil
            )

            agregarPaso(paso, al: &grafo)
        }
    }
}

func crearGrafoActual() -> [String: [PasoRuta]] {
    var grafo: [String: [PasoRuta]] = [:]

    conectarSecuencia(
        estacionesLinea1,
        medio: SistemaTransporte.linea1.rawValue,
        minutos: 3,
        grafo: &grafo
    )

    conectarSecuencia(
        estacionesLinea2,
        medio: SistemaTransporte.linea2.rawValue,
        minutos: 2,
        grafo: &grafo
    )

    let metNorte = Array(estacionesMetropolitano.prefix(17))

    let metRama1 = estacionesMetropolitano.filter {
        [
            "MET-17",
            "MET-18",
            "MET-19",
            "MET-20",
            "MET-21",
            "MET-25"
        ].contains($0.id)
    }

    let metRama2 = estacionesMetropolitano.filter {
        [
            "MET-17",
            "MET-22",
            "MET-23",
            "MET-24",
            "MET-25"
        ].contains($0.id)
    }

    let metSur = estacionesMetropolitano.filter {
        guard let numero = Int(
            $0.id.replacingOccurrences(
                of: "MET-",
                with: ""
            )
        ) else {
            return false
        }

        return numero >= 25
    }

    conectarSecuencia(
        metNorte,
        medio: SistemaTransporte.metropolitano.rawValue,
        minutos: 4,
        grafo: &grafo
    )

    conectarSecuencia(
        metRama1,
        medio: SistemaTransporte.metropolitano.rawValue,
        minutos: 4,
        grafo: &grafo
    )

    conectarSecuencia(
        metRama2,
        medio: SistemaTransporte.metropolitano.rawValue,
        minutos: 4,
        grafo: &grafo
    )

    conectarSecuencia(
        metSur,
        medio: SistemaTransporte.metropolitano.rawValue,
        minutos: 4,
        grafo: &grafo
    )

    for transporte in transportesComplementarios {
        let paso = PasoRuta(
            origenID: transporte.origenID,
            destinoID: transporte.destinoID,
            medio: transporte.ruta,
            tiempo: transporte.tiempoReferencial,
            esFuturo: false,
            transporte: transporte
        )

        agregarPaso(paso, al: &grafo)
    }

    return grafo
}

func buscarCamino(
    desde origenID: String,
    hasta destinoID: String,
    grafo: [String: [PasoRuta]]
) -> [PasoRuta]? {

    var distancias: [String: Int] = [
        origenID: 0
    ]

    var saltos: [String: Int] = [
        origenID: 0
    ]

    var anteriores: [String: PasoRuta] = [:]

    var visitados = Set<String>()

    while true {
        let pendientes = distancias.keys.filter {
            !visitados.contains($0)
        }

        guard let actual = pendientes.min(by: { a, b in

            let distanciaA = distancias[a] ?? Int.max
            let distanciaB = distancias[b] ?? Int.max

            if distanciaA == distanciaB {
                return (saltos[a] ?? Int.max) <
                       (saltos[b] ?? Int.max)
            }

            return distanciaA < distanciaB

        }) else {
            break
        }

        if actual == destinoID {
            break
        }

        visitados.insert(actual)

        for paso in grafo[actual] ?? [] {

            let nuevaDistancia =
                (distancias[actual] ?? 0) +
                paso.tiempo

            let nuevosSaltos =
                (saltos[actual] ?? 0) + 1

            let distanciaGuardada =
                distancias[paso.destinoID] ?? Int.max

            let saltosGuardados =
                saltos[paso.destinoID] ?? Int.max

            if nuevaDistancia < distanciaGuardada ||
               (
                   nuevaDistancia == distanciaGuardada &&
                   nuevosSaltos < saltosGuardados
               ) {

                distancias[paso.destinoID] =
                    nuevaDistancia

                saltos[paso.destinoID] =
                    nuevosSaltos

                anteriores[paso.destinoID] =
                    paso
            }
        }
    }

    guard distancias[destinoID] != nil else {
        return nil
    }

    var camino: [PasoRuta] = []
    var actual = destinoID

    while actual != origenID {

        guard let paso = anteriores[actual] else {
            return nil
        }

        camino.insert(paso, at: 0)

        actual = paso.origenID
    }

    return camino
}

func calcularRuta(
    desde origen: Estacion,
    hasta destino: Estacion
) -> RutaCalculada? {

    if origen.id == destino.id {
        return RutaCalculada(
            tipo: .directa,
            pasos: [],
            tiempoTotal: 0
        )
    }

    let grafo = crearGrafoActual()

    guard let pasos = buscarCamino(
        desde: origen.id,
        hasta: destino.id,
        grafo: grafo
    ) else {
        return nil
    }

    let usaBus = pasos.contains {
        $0.transporte != nil
    }

    let medios = Set(
        pasos.map {
            $0.medio
        }
    )

    let tipo: TipoRuta =
        (usaBus || medios.count > 1)
        ? .multimodal
        : .directa

    let tiempoTotal = pasos.reduce(0) {
        $0 + $1.tiempo
    }

    return RutaCalculada(
        tipo: tipo,
        pasos: pasos,
        tiempoTotal: tiempoTotal
    )
}

// RF07 - MOSTRAR DETALLE DE LA RUTA

func obtenerListaSistema(_ sistema: SistemaTransporte) -> [Estacion] {
    switch sistema {
    case .linea1:
        return estacionesLinea1
    case .linea2:
        return estacionesLinea2
    case .metropolitano:
        return estacionesMetropolitano
    case .ramalLinea4:
        return estacionesRamalLinea4
    }
}

func cantidadEstaciones(
    desde origenID: String,
    hasta destinoID: String,
    sistema: SistemaTransporte
) -> Int {

    // Cuenta enlaces reales; las posiciones del arreglo no representan las bifurcaciones.
    let grafo = crearGrafoFuturo().mapValues { pasos in
        pasos.filter {
            $0.transporte == nil &&
            buscarEstacionPorID($0.origenID)?.sistema == sistema &&
            buscarEstacionPorID($0.destinoID)?.sistema == sistema
        }
    }
    return buscarCamino(desde: origenID, hasta: destinoID, grafo: grafo)?.count ?? 0
}

func contarTransbordos(_ pasos: [PasoRuta]) -> Int {
    var transbordos = 0
    var medioAnterior: String? = nil

    for paso in pasos {
        if esConexion(paso) {
            // La conexión cuenta una vez, no al entrar y nuevamente al salir.
            transbordos += 1
            medioAnterior = nil
        } else if let anterior = medioAnterior, paso.medio != anterior {
            transbordos += 1
            medioAnterior = paso.medio
        } else {
            medioAnterior = paso.medio
        }
    }

    return transbordos
}

func mostrarDetalleRuta(
    _ ruta: RutaCalculada,
    origen: Estacion,
    destino: Estacion
) {
    print("\n==================================================")
    print("                  TU PLAN DE VIAJE")
    print("==================================================")
    print("SALIDA   \(origen.nombre) | \(origen.sistema.rawValue)")
    print("LLEGADA  \(destino.nombre) | \(destino.sistema.rawValue)")
    print("--------------------------------------------------")
    print("Tiempo estimado: \(ruta.tiempoTotal) min")
    print("Estaciones por recorrer: \(estacionesEnPasos(ruta.pasos))")
    print("Transbordos: \(contarTransbordos(ruta.pasos))")
    print("Tarifa estimada: \(formatearMonto(tarifaEstimada(ruta)))")

    if ruta.pasos.isEmpty {
        print("\nYa estás en tu destino. No necesitas realizar un viaje.")
        return
    }

    print("\nCÓMO LLEGAR")
    for (indice, tramo) in agruparTramos(ruta.pasos).enumerated() {
        guard let primero = tramo.first, let ultimo = tramo.last,
              let salida = buscarEstacionPorID(primero.origenID),
              let llegada = buscarEstacionPorID(ultimo.destinoID) else { continue }
        let minutos = tramo.reduce(0) { $0 + $1.tiempo }
        print("\n\(indice + 1). \(primero.medio.uppercased())")
        if let bus = primero.transporte {
            print("   Toma \(bus.ruta) | \(bus.empresa)")
            print("   Sube en: \(bus.paraderoSubida)")
            print("   Baja en: \(bus.paraderoBajada)")
            print("   Une \(salida.sistema.rawValue) con \(llegada.sistema.rawValue)")
        } else if esConexion(primero) {
            print("   Cambia de \(salida.sistema.rawValue) a \(llegada.sistema.rawValue)")
            print("   \(salida.nombre) → \(llegada.nombre)")
        } else {
            print("   Sube en: \(salida.nombre)")
            print("   Baja en: \(llegada.nombre)")
            let cantidad = tramo.count
            print("   Avanza \(cantidad) \(cantidad == 1 ? "estación" : "estaciones")")
        }
        print("   Tiempo: \(minutos) min")
        if tramo.contains(where: { $0.esFuturo }) {
            print("   NO DISPONIBLE AÚN: incluye estaciones o conexiones futuras.")
        }
    }
    print("\nLlegarás a \(destino.nombre).")
    print("==================================================")
}

// RF08 - DIFERENCIAR RUTAS ACTUALES Y FUTURAS

func conectarSecuenciaFutura(
    _ estaciones: [Estacion],
    medio: String,
    minutos: Int,
    grafo: inout [String: [PasoRuta]]
) {
    guard estaciones.count > 1 else {
        return
    }

    for i in 0..<(estaciones.count - 1) {
        let origen = estaciones[i]
        let destino = estaciones[i + 1]

        let esFuturo =
            origen.estado != .operativa ||
            destino.estado != .operativa

        let paso = PasoRuta(
            origenID: origen.id,
            destinoID: destino.id,
            medio: medio,
            tiempo: minutos,
            esFuturo: esFuturo,
            transporte: nil
        )

        agregarPaso(paso, al: &grafo)
    }
}

func crearGrafoFuturo() -> [String: [PasoRuta]] {
    var grafo: [String: [PasoRuta]] = [:]

    conectarSecuenciaFutura(
        estacionesLinea1,
        medio: SistemaTransporte.linea1.rawValue,
        minutos: 3,
        grafo: &grafo
    )

    conectarSecuenciaFutura(
        estacionesLinea2,
        medio: SistemaTransporte.linea2.rawValue,
        minutos: 2,
        grafo: &grafo
    )

    conectarSecuenciaFutura(
        estacionesRamalLinea4,
        medio: SistemaTransporte.ramalLinea4.rawValue,
        minutos: 3,
        grafo: &grafo
    )

    let metNorte = Array(estacionesMetropolitano.prefix(17))

    let metRama1 = estacionesMetropolitano.filter {
        ["MET-17", "MET-18", "MET-19", "MET-20", "MET-21", "MET-25"]
            .contains($0.id)
    }

    let metRama2 = estacionesMetropolitano.filter {
        ["MET-17", "MET-22", "MET-23", "MET-24", "MET-25"]
            .contains($0.id)
    }

    let metSur = estacionesMetropolitano.filter {
        guard let numero = Int(
            $0.id.replacingOccurrences(of: "MET-", with: "")
        ) else {
            return false
        }

        return numero >= 25
    }

    conectarSecuenciaFutura(
        metNorte,
        medio: SistemaTransporte.metropolitano.rawValue,
        minutos: 4,
        grafo: &grafo
    )

    conectarSecuenciaFutura(
        metRama1,
        medio: SistemaTransporte.metropolitano.rawValue,
        minutos: 4,
        grafo: &grafo
    )

    conectarSecuenciaFutura(
        metRama2,
        medio: SistemaTransporte.metropolitano.rawValue,
        minutos: 4,
        grafo: &grafo
    )

    conectarSecuenciaFutura(
        metSur,
        medio: SistemaTransporte.metropolitano.rawValue,
        minutos: 4,
        grafo: &grafo
    )

    for transporte in transportesComplementarios {
        let paso = PasoRuta(
            origenID: transporte.origenID,
            destinoID: transporte.destinoID,
            medio: transporte.ruta,
            tiempo: transporte.tiempoReferencial,
            esFuturo: false,
            transporte: transporte
        )

        agregarPaso(paso, al: &grafo)
    }

    for conexion in conexionesSistemas {
        let paso = PasoRuta(
            origenID: conexion.origenID,
            destinoID: conexion.destinoID,
            medio: "Conexión entre sistemas",
            tiempo: 5,
            esFuturo: true,
            transporte: nil
        )

        agregarPaso(paso, al: &grafo)
    }

    return grafo
}

func calcularRutaDisponible(
    desde origen: Estacion,
    hasta destino: Estacion
) -> RutaCalculada? {

    if let rutaActual = calcularRuta(
        desde: origen,
        hasta: destino
    ) {
        return rutaActual
    }

    let grafoFuturo = crearGrafoFuturo()

    guard let pasos = buscarCamino(
        desde: origen.id,
        hasta: destino.id,
        grafo: grafoFuturo
    ) else {
        return nil
    }

    let tiempoTotal = pasos.reduce(0) {
        $0 + $1.tiempo
    }

    return RutaCalculada(
        tipo: .futura,
        pasos: pasos,
        tiempoTotal: tiempoTotal
    )
}

func mostrarRutaDisponible(
    _ ruta: RutaCalculada,
    origen: Estacion,
    destino: Estacion
) {
    if ruta.tipo == .futura {
        print("")
        print("⚠️  RUTA FUTURA / REFERENCIAL")
        print("------------------------------------------------------------")
        print("Esta ruta utiliza estaciones o conexiones que todavía")
        print("se encuentran en construcción o proyectadas.")
        print("Actualmente no se encuentra disponible en su totalidad.")
        print("------------------------------------------------------------")
    }

    mostrarDetalleRuta(
        ruta,
        origen: origen,
        destino: destino
    )
}

// RF09 - VALIDAR ENTRADAS Y MANTENER EL MENÚ

func seleccionarEstacion(_ resultados: [Estacion]) -> Estacion? {
    if resultados.isEmpty {
        print("\nNo se encontró la estación.")
        return nil
    }

    if resultados.count == 1 {
        return resultados[0]
    }

    print("\nSe encontraron varias coincidencias:")

    for (indice, estacion) in resultados.enumerated() {
        print(
            "\(indice + 1). \(estacion.nombre) | " +
            "\(estacion.sistema.rawValue) | " +
            "\(estacion.distrito) | " +
            "\(estacion.estado.rawValue)"
        )
    }

    print("\nSeleccione una opción:")

    guard
        let entrada = readLine(),
        let opcion = Int(entrada),
        opcion >= 1,
        opcion <= resultados.count
    else {
        print("Opción no válida.")
        return nil
    }

    return resultados[opcion - 1]
}

func obtenerEstacion(_ texto: String) -> Estacion? {
    let consulta = normalizarTexto(texto)

    let destinosEspeciales: [String: String] = [
        "centro historico": "MET-20",
        "estadio nacional": "MET-26",
        "gamarra": "L1-15",
        "aeropuerto": "L4-04"
    ]

    if let id = destinosEspeciales[consulta] {
        return buscarEstacionPorID(id)
    }

    return seleccionarEstacion(
        buscarEstaciones(texto)
    )
}

func opcionListarEstaciones() {
    var volver = false

    while !volver {
        print("")
        print("==================================================")
        print("           ESTACIONES POR SISTEMA")
        print("==================================================")
        print("1. Línea 1")
        print("2. Línea 2")
        print("3. Metropolitano")
        print("4. Ramal Línea 4")
        print("0. Volver")
        print("==================================================")
        print("Seleccione una opción:")

        let opcion = readLine() ?? ""

        switch opcion {
        case "1":
            mostrarTablaEstaciones(estacionesLinea1)

        case "2":
            mostrarTablaEstaciones(estacionesLinea2)

        case "3":
            mostrarTablaEstaciones(estacionesMetropolitano)

        case "4":
            mostrarTablaEstaciones(estacionesRamalLinea4)

        case "0":
            volver = true

        default:
            print("\nOpción no válida. Intente nuevamente.")
        }
    }
}

func opcionBuscarEstacion() {
    print("\nIngrese nombre, código o distrito de la estación:")

    guard let texto = readLine() else {
        print("Entrada no válida.")
        return
    }

    let resultados = buscarEstaciones(texto)

    guard let estacion = seleccionarEstacion(resultados) else {
        return
    }

    mostrarInformacionEstacion(estacion)
}

func opcionTransporteComplementario() {
    print("\nIngrese una estación:")

    guard
        let texto = readLine(),
        let estacion = obtenerEstacion(texto)
    else {
        return
    }

    mostrarTransporteComplementario(
        desde: estacion
    )
}

func opcionCalcularRuta() {
    print("\n==================================================")
    print("                  PLANIFICAR VIAJE")
    print("==================================================")
    guard let origen = pedirPuntoViaje("PASO 1 DE 2 · ¿Desde dónde sales?"),
          let destino = pedirPuntoViaje("PASO 2 DE 2 · ¿A dónde quieres llegar?") else { return }

    guard let ruta = calcularRutaDisponible(desde: origen, hasta: destino) else {
        print("\nNo hay una ruta que conecte estas estaciones.")
        print("Puedes elegir otro destino o agregar una conexión desde Administración.")
        return
    }
    mostrarRutaDisponible(ruta, origen: origen, destino: destino)
    guard !ruta.pasos.isEmpty else { return }

    if ruta.tipo == .futura {
        print("\nEste recorrido todavía no está disponible en su totalidad.")
        print("El seguimiento permite revisar sus pasos; no indica que esté operativo.")
    }
    guard leerSiNo("\n¿Iniciar el seguimiento del viaje? (s/n)") == true else { return }
    print("\nPAGO DEL VIAJE")
    print("Tarifa: \(formatearMonto(tarifaEstimada(ruta))) | Saldo: \(formatearMonto(tarjeta.saldo))")
    guard let pagar = leerSiNo("¿Pagar con tu tarjeta? (s/n)") else { return }
    if pagar && !cobrarViaje(tarifaEstimada(ruta)) {
        print("No se inició el viaje. Recarga tu tarjeta en la opción 6.")
        return
    }
    if !pagar { print("Seguimiento iniciado sin cobro a la tarjeta.") }
    simularViaje(ruta)
}

func leerEntrada() -> String? {
    return readLine()?.trimmingCharacters(in: .whitespacesAndNewlines)
}

func leerMonto(_ mensaje: String) -> Decimal? {
    while true {
        print(mensaje)
        guard let entrada = leerEntrada() else { return nil }
        let texto = entrada.replacingOccurrences(of: ",", with: ".")
        // Decimal evita errores de redondeo; no se aceptan NaN, infinito ni exponentes.
        if texto.range(of: "^[0-9]{1,7}(\\.[0-9]{1,2})?$", options: .regularExpression) != nil,
           let monto = Decimal(string: texto, locale: Locale(identifier: "en_US_POSIX")),
           monto > 0, monto <= 1_000_000 {
            return monto
        }
        print("Monto inválido. Ingrese un valor positivo de hasta S/ 1000000.00, con máximo 2 decimales.")
    }
}

func formatearMonto(_ monto: Decimal) -> String {
    return "S/ " + String(format: "%.2f", locale: Locale(identifier: "en_US_POSIX"),
                         NSDecimalNumber(decimal: monto).doubleValue)
}

@discardableResult
func cobrarViaje(_ monto: Decimal) -> Bool {
    print("Tarifa: \(formatearMonto(monto))")
    guard tarjeta.saldo >= monto else {
        print("Saldo insuficiente.")
        print("Saldo actual: \(formatearMonto(tarjeta.saldo))")
        return false
    }
    tarjeta.saldo -= monto
    print("Cobro aprobado.")
    print("Saldo restante: \(formatearMonto(tarjeta.saldo))")
    return true
}

func gestionarTarjeta() {
    while true {
        print("\nTARJETA DE TRANSPORTE | \(tarjeta.identificador)")
        print("1. Consultar saldo")
        print("2. Recargar tarjeta")
        print("3. Pagar un viaje")
        print("0. Volver")
        print("Tarifa por viaje: \(formatearMonto(tarifaSimulada))")
        guard let opcion = leerEntrada() else { return }
        switch opcion {
        case "1":
            print("Saldo actual: \(formatearMonto(tarjeta.saldo))")
        case "2":
            guard let monto = leerMonto("Ingrese monto de recarga:") else { return }
            guard tarjeta.saldo + monto <= 1_000_000 else {
                print("La recarga supera el saldo máximo permitido: S/ 1000000.00.")
                continue
            }
            tarjeta.saldo += monto
            print("Recarga realizada.")
            print("Nuevo saldo: \(formatearMonto(tarjeta.saldo))")
        case "3":
            cobrarViaje(tarifaSimulada)
        case "0": return
        default: print("Opción no válida.")
        }
    }
}

func leerSiNo(_ mensaje: String) -> Bool? {
    while true {
        print(mensaje)
        guard let entrada = leerEntrada() else { return nil }
        switch normalizarTexto(entrada) {
        case "s", "si": return true
        case "n", "no": return false
        default: print("Respuesta no válida. Escriba s o n.")
        }
    }
}

func tarifaEstimada(_ ruta: RutaCalculada) -> Decimal {
    return ruta.pasos.isEmpty ? 0 : tarifaSimulada
}

func esConexion(_ paso: PasoRuta) -> Bool {
    return paso.transporte == nil &&
        buscarEstacionPorID(paso.origenID)?.sistema !=
        buscarEstacionPorID(paso.destinoID)?.sistema
}

func estacionesEnPasos(_ pasos: [PasoRuta]) -> Int {
    return pasos.filter { $0.transporte == nil && !esConexion($0) }.count
}

func agruparTramos(_ pasos: [PasoRuta]) -> [[PasoRuta]] {
    var tramos: [[PasoRuta]] = []
    for paso in pasos {
        if let ultimo = tramos.last?.last,
           paso.transporte == nil, ultimo.transporte == nil,
           !esConexion(paso), !esConexion(ultimo),
           paso.medio == ultimo.medio, ultimo.destinoID == paso.origenID {
            tramos[tramos.count - 1].append(paso)
        } else {
            tramos.append([paso])
        }
    }
    return tramos
}

func pedirPuntoViaje(_ mensaje: String) -> Estacion? {
    while true {
        print("\n\(mensaje)")
        print("Escribe nombre, código o distrito. 0 para volver.")
        guard let texto = leerEntrada(), texto != "0" else { return nil }
        if let estacion = obtenerEstacion(texto) {
            print("Seleccionaste: \(estacion.nombre) | \(estacion.sistema.rawValue)")
            return estacion
        }
        print("Intenta nuevamente con otra búsqueda.")
    }
}

func simularViaje(_ ruta: RutaCalculada) {
    guard let primerPaso = ruta.pasos.first,
          let salida = buscarEstacionPorID(primerPaso.origenID),
          let ultimoPaso = ruta.pasos.last,
          let destinoFinal = buscarEstacionPorID(ultimoPaso.destinoID) else { return }
    print("\n==================================================")
    print("                  VIAJE EN CURSO")
    print("==================================================")
    if ruta.tipo == .futura {
        print("RECORRIDO FUTURO · Todavía no disponible en su totalidad.")
    }
    print("Estás en: \(salida.nombre) | \(salida.sistema.rawValue)")
    print("Tu destino: \(destinoFinal.nombre)")
    print("Avanza con Enter al llegar a cada estación o completar una conexión.")
    var tiempoRestante = ruta.tiempoTotal
    var medioAnterior: String? = nil
    for (indice, paso) in ruta.pasos.enumerated() {
        guard let origen = buscarEstacionPorID(paso.origenID),
              let destino = buscarEstacionPorID(paso.destinoID) else { return }
        print("\n--------------------------------------------------")
        if esConexion(paso) {
            print("TRANSBORDO · Cambia de \(origen.sistema.rawValue) a \(destino.sistema.rawValue)")
        } else if let bus = paso.transporte {
            print("\(medioAnterior == nil ? "TOMA EL BUS" : "TRANSBORDO") · \(bus.ruta) | \(bus.empresa)")
            print("Sube en: \(bus.paraderoSubida)")
            print("Baja en: \(bus.paraderoBajada)")
        } else if medioAnterior != paso.medio {
            print("\(medioAnterior == nil ? "SUBE A" : "TRANSBORDO · SUBE A"): \(paso.medio)")
        }
        print("Siguiente parada: \(destino.nombre) | \(destino.sistema.rawValue)")
        print("Tiempo de este paso: \(paso.tiempo) min")
        if paso.esFuturo { print("Este paso aún no está operativo.") }
        while true {
            print("[Enter] Llegué a \(destino.nombre)    [0] Terminar seguimiento")
            guard let entrada = leerEntrada(), entrada != "0" else {
                print("Seguimiento finalizado. Los cobros aprobados se mantienen.")
                return
            }
            if entrada.isEmpty { break }
            print("Presiona Enter para avanzar o escribe 0 para volver al menú.")
        }
        tiempoRestante -= paso.tiempo
        let completados = indice + 1
        let avance = completados * 20 / ruta.pasos.count
        let barra = String(repeating: "#", count: avance) + String(repeating: "-", count: 20 - avance)
        let pendientes = Array(ruta.pasos.dropFirst(completados))
        let estaciones = estacionesEnPasos(pendientes)
        let conexiones = pendientes.filter { esConexion($0) }.count
        let buses = pendientes.filter { $0.transporte != nil }.count
        print("\n[\(barra)] \(completados * 100 / ruta.pasos.count)% del recorrido")
        print("Llegaste a: \(destino.nombre)")
        print("Sistema: \(destino.sistema.rawValue)")
        print("")
        print("Faltan: \(estaciones) \(estaciones == 1 ? "estación" : "estaciones")")
        if conexiones > 0 { print("Conexiones pendientes: \(conexiones)") }
        if buses > 0 { print("Trayectos en bus pendientes: \(buses)") }
        print("Tiempo aproximado restante: \(tiempoRestante) min")
        medioAnterior = esConexion(paso) ? nil : paso.medio
    }
    print("\n==================================================")
    print("                 DESTINO ALCANZADO")
    print("Llegaste a \(destinoFinal.nombre).")
    print("Tiempo estimado del recorrido: \(ruta.tiempoTotal) min")
    print("==================================================")
}

func transportesDesde(_ estacionID: String) -> [TransporteComplementario] {
    // El grafo ya crea el transporte inverso con sus paraderos correctos.
    return (crearGrafoActual()[estacionID] ?? []).compactMap { $0.transporte }
}

func mostrarMenuPrincipal() {
    var continuar = true

    while continuar {
        print("")
        print("==================================================")
        print("                 METRO LIMA GO")
        print("==================================================")
        print("1. Ver estaciones por sistema")
        print("2. Buscar estación")
        print("3. Ver puntos de conexión entre sistemas")
        print("4. Consultar transporte complementario")
        print("5. Planificar un viaje")
        print("6. Mi tarjeta: saldo y recargas")
        print("0. Salir")
        print("==================================================")
        print("Seleccione una opción:")

        guard let opcion = leerEntrada() else { return }

        switch opcion {
        case "1":
            opcionListarEstaciones()

        case "2":
            opcionBuscarEstacion()

        case "3":
            mostrarPuntosConexion()

        case "4":
            opcionTransporteComplementario()

        case "5":
            opcionCalcularRuta()

        case "6":
            gestionarTarjeta()

        case "0":
            print("")
            print("==================================================")
            print("Gracias por utilizar Metro Lima Go.")
            print("==================================================")
            continuar = false

        default:
            print("")
            print("Opción no válida. Intente nuevamente.")
        }
    }
}

mostrarMenuPrincipal()
