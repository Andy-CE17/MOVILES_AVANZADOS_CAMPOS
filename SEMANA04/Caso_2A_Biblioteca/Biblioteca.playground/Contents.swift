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
    // Presta un libro si esta disponible
    func prestar(titulo: String) -> Bool {

        for i in 0..<libros.count {

            if libros[i].titulo == titulo {

                if libros[i].estado == .disponible {
                    libros[i].estado = .prestado
                    print("Prestamo aprobado: \(titulo)")
                    return true
                } else {
                    print("Error: \(titulo) ya esta prestado")
                    return false
                }
            }
        }

        print("Error: no existe \(titulo)")
        return false
    }
}
