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
    let tieneTransporte = transportesComplementarios.contains {
        $0.origenID == estacion.id
    }

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

    let rutasDisponibles = transportesComplementarios.filter {
        $0.origenID == estacion.id
    }

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

    let estaciones = obtenerListaSistema(sistema)

    guard
        let indiceOrigen = estaciones.firstIndex(where: { $0.id == origenID }),
        let indiceDestino = estaciones.firstIndex(where: { $0.id == destinoID })
    else {
        return 0
    }

    return abs(indiceDestino - indiceOrigen)
}

func contarTransbordos(_ pasos: [PasoRuta]) -> Int {
    guard pasos.count > 1 else {
        return 0
    }

    var transbordos = 0
    var medioAnterior = pasos[0].medio

    for paso in pasos.dropFirst() {
        if paso.medio != medioAnterior {
            transbordos += 1
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

    print("")
    print("╔════════════════════════════════════════════════════════════╗")
    print("║                    METRO LIMA GO                          ║")
    print("║                    RUTA RECOMENDADA                       ║")
    print("╚════════════════════════════════════════════════════════════╝")

    print("")
    print("ORIGEN")
    print("  \(origen.nombre)")
    print("  \(origen.sistema.rawValue)")

    print("")
    print("DESTINO")
    print("  \(destino.nombre)")
    print("  \(destino.sistema.rawValue)")

    print("")
    print("TIPO DE RUTA")
    print("  \(ruta.tipo.rawValue)")

    if ruta.pasos.isEmpty {
        print("")
        print("Ya te encuentras en el destino seleccionado.")
        return
    }

    print("")
    print("────────────────────────────────────────────────────────────")

    var numeroTramo = 1
    var totalEstaciones = 0

    for paso in ruta.pasos {

        guard
            let estacionOrigen = buscarEstacionPorID(paso.origenID),
            let estacionDestino = buscarEstacionPorID(paso.destinoID)
        else {
            continue
        }

        print("")

        if let transporte = paso.transporte {

            print("TRANSBORDO | TRANSPORTE COMPLEMENTARIO")
            print("")
            print("Ruta: \(transporte.ruta)")
            print("Operador: \(transporte.empresa)")
            print("")
            print("Subida:")
            print("  \(transporte.paraderoSubida)")
            print("")
            print("      ↓")
            print("")
            print("Bajada:")
            print("  \(transporte.paraderoBajada)")
            print("")
            print("Tiempo referencial: ~\(paso.tiempo) min")

        } else {

            print("TRAMO \(numeroTramo) | \(paso.medio)")
            print("")

            let cantidad = cantidadEstaciones(
                desde: paso.origenID,
                hasta: paso.destinoID,
                sistema: estacionOrigen.sistema
            )

            totalEstaciones += cantidad

            print("  \(estacionOrigen.nombre)")
            print("       │")

            if cantidad == 1 {
                print("       │  Avanza 1 estación")
            } else {
                print("       │  Avanza \(cantidad) estaciones")
            }

            print("       ▼")
            print("  \(estacionDestino.nombre)")
            print("")
            print("Tiempo referencial: ~\(paso.tiempo) min")

            numeroTramo += 1
        }

        print("")
        print("────────────────────────────────────────────────────────────")
    }

    let transbordos = contarTransbordos(ruta.pasos)

    print("")
    print("RESUMEN DEL VIAJE")
    print("")
    print("Estaciones recorridas: \(totalEstaciones)")
    print("Transbordos: \(transbordos)")
    print("Tiempo total referencial: ~\(ruta.tiempoTotal) min")

    print("")
    print("╔════════════════════════════════════════════════════════════╗")
    print("║                    FIN DE LA RUTA                         ║")
    print("╚════════════════════════════════════════════════════════════╝")
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
    print("\nIngrese estación de origen:")

    guard
        let textoOrigen = readLine(),
        let origen = obtenerEstacion(textoOrigen)
    else {
        print("No se pudo identificar el origen.")
        return
    }

    print("")
    print("Ingrese estación o destino:")
    print("(Ejemplo: Estadio Nacional, Gamarra, Centro Histórico, Aeropuerto)")

    guard
        let textoDestino = readLine(),
        let destino = obtenerEstacion(textoDestino)
    else {
        print("No se pudo identificar el destino.")
        return
    }

    guard let ruta = calcularRutaDisponible(
        desde: origen,
        hasta: destino
    ) else {
        print("")
        print("No se encontró una ruta disponible")
        print("entre el origen y el destino seleccionados.")
        return
    }

    mostrarRutaDisponible(
        ruta,
        origen: origen,
        destino: destino
    )
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
        print("5. Calcular ruta")
        print("0. Salir")
        print("==================================================")
        print("Seleccione una opción:")

        let opcion = readLine() ?? ""

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
