// Desarrollado por: Andy Luis Campos Escandon
// CASO 2B: BIBLIOTECA CON IA
// Docente: Juan Leon

import Foundation // Permite usar funciones basicas de Swift

enum EstadoLibro { // Define los estados que puede tener un libro
    case disponible // El libro se puede prestar
    case prestado // El libro ya fue prestado
}

struct Libro { // Guarda los datos de cada libro
    let titulo: String // Guarda el titulo del libro
    let autor: String // Guarda el nombre del autor
    var estado: EstadoLibro = .disponible // El libro inicia disponible
}

class Biblioteca { // Clase que administra los libros
    var libros: [Libro] = [] // Arreglo donde se guardan los libros

    func agregar(libro: Libro) { // Metodo para agregar un libro
        libros.append(libro) // Agrega el libro al arreglo
    }

    func prestar(titulo: String) -> Bool { // Metodo para prestar un libro

        for i in 0..<libros.count { // Recorre el arreglo usando indices

            if libros[i].titulo == titulo { // Compara el titulo buscado

                if libros[i].estado == .disponible { // Verifica si esta disponible
                    libros[i].estado = .prestado // Cambia el estado a prestado
                    print("Préstamo aprobado: \(titulo)") // Muestra mensaje de aprobacion
                    return true // Indica que el prestamo fue realizado
                } else { // Se ejecuta si el libro ya esta prestado
                    print("Error: \(titulo) ya está prestado") // Muestra el error
                    return false // Indica que no se pudo prestar
                }
            }
        }

        print("Error: no existe \(titulo)") // Se muestra si el libro no fue encontrado
        return false // Indica que el prestamo fallo
    }

    func devolver(titulo: String) -> Bool { // Metodo para devolver un libro

        for i in 0..<libros.count { // Recorre los libros por indice

            if libros[i].titulo == titulo { // Busca el libro por su titulo

                if libros[i].estado == .prestado { // Comprueba si estaba prestado
                    libros[i].estado = .disponible // Cambia nuevamente a disponible
                    print("Devolución registrada: \(titulo)") // Confirma la devolucion
                    return true // Indica que se devolvio correctamente
                } else { // Se ejecuta si ya estaba disponible
                    print("Error: \(titulo) ya está disponible") // Muestra el error
                    return false // Indica que no se realizo la devolucion
                }
            }
        }

        print("Error: no existe \(titulo)") // Se muestra si no encuentra el libro
        return false // Indica que la devolucion fallo
    }

    func inventario() { // Metodo para mostrar todos los libros

        print("===== INVENTARIO =====") // Titulo del inventario

        for libro in libros { // Recorre todos los libros

            switch libro.estado { // Evalua el estado del libro

            case .disponible: // Cuando el libro esta disponible
                print("\(libro.titulo) (\(libro.autor)) - disponible") // Muestra sus datos

            case .prestado: // Cuando el libro esta prestado
                print("\(libro.titulo) (\(libro.autor)) - prestado") // Muestra sus datos
            }
        }
    }
}

let biblioteca = Biblioteca() // Crea una biblioteca

let libro1 = Libro( // Crea el primer libro
    titulo: "Cien años de soledad", // Titulo del primer libro
    autor: "Gabriel García Márquez" // Autor del primer libro
)

let libro2 = Libro( // Crea el segundo libro
    titulo: "La ciudad y los perros", // Titulo del segundo libro
    autor: "Mario Vargas Llosa" // Autor del segundo libro
)

let libro3 = Libro( // Crea el tercer libro
    titulo: "El Quijote", // Titulo del tercer libro
    autor: "Miguel de Cervantes" // Autor del tercer libro
)

biblioteca.agregar(libro: libro1) // Agrega el primer libro
biblioteca.agregar(libro: libro2) // Agrega el segundo libro
biblioteca.agregar(libro: libro3) // Agrega el tercer libro

_ = biblioteca.prestar(titulo: "La ciudad y los perros") // Realiza el primer prestamo
_ = biblioteca.prestar(titulo: "La ciudad y los perros") // Intenta prestarlo otra vez
_ = biblioteca.devolver(titulo: "La ciudad y los perros") // Devuelve el libro
_ = biblioteca.prestar(titulo: "El Quijote") // Presta El Quijote
_ = biblioteca.prestar(titulo: "El Principito") // Intenta prestar un libro inexistente

biblioteca.inventario() // Muestra el inventario final
