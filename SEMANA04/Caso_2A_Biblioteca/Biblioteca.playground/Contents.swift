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
    
    // Devuelve un libro si estaba prestado
    func devolver(titulo: String) -> Bool {

        for i in 0..<libros.count {

            if libros[i].titulo == titulo {

                if libros[i].estado == .prestado {
                    libros[i].estado = .disponible
                    print("Devolucion registrada: \(titulo)")
                    return true
                } else {
                    print("Error: \(titulo) ya esta disponible")
                    return false
                }
            }
        }

        print("Error: no existe \(titulo)")
        return false
    }
    // Muestra todos los libros con su estado
    func inventario() {

        print("===== INVENTARIO =====")

        for libro in libros {

            switch libro.estado {
            case .disponible:
                print("\(libro.titulo) (\(libro.autor)) - disponible")

            case .prestado:
                print("\(libro.titulo) (\(libro.autor)) - prestado")
            }
        }
    }
}

// Simulacion final del Caso 2A
let biblioteca = Biblioteca()

let libro1 = Libro(
    titulo: "Cien años de soledad",
    autor: "Gabriel García Márquez"
)

let libro2 = Libro(
    titulo: "La ciudad y los perros",
    autor: "Mario Vargas Llosa"
)

let libro3 = Libro(
    titulo: "El Quijote",
    autor: "Miguel de Cervantes"
)

biblioteca.agregar(libro: libro1)
biblioteca.agregar(libro: libro2)
biblioteca.agregar(libro: libro3)

_ = biblioteca.prestar(titulo: "La ciudad y los perros")
_ = biblioteca.prestar(titulo: "La ciudad y los perros")

_ = biblioteca.devolver(titulo: "La ciudad y los perros")

_ = biblioteca.prestar(titulo: "El Quijote")

_ = biblioteca.prestar(titulo: "El Principito")

biblioteca.inventario()
