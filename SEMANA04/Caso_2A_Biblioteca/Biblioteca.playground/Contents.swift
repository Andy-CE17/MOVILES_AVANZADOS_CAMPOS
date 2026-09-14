// Desarrollado por: Andy Luis Campos Escandon
// CASO 2A: BIBLIOTECA SIN IA
// Docente: Juan Leon

import Foundation

// estados que pued etener un libro

enum EstadoLibro {
    case disponible
    case prestado

}

// Datos principales de un libro
struct Libro {
    let titulo:String
    let autor: String
    var estado: EstadoLibro = .disponible
}

// clase principal de la biblioteca

class Biblioteca {
    var libros: [Libro] = []
    
    // Agrega un libro al arreglo
    func agregar(libro: Libro) {
        libros.append(libro)
    }
}
