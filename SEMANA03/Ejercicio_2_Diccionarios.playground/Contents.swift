// Desarrollado por: Andy Luis Campos Escandón
// Ejercicio 2: Diccionarios

import Foundation

print("========== CATÁLOGO DE PRODUCTOS ==========")

var catalogo: [String: Double] = [:]

for i in 1...4 {
    print("\nProducto \(i) - Nombre:")
    let nombreProducto = readLine() ?? ""

    print("Precio:")
    let precioProducto = Double(readLine() ?? "") ?? 0

    catalogo[nombreProducto] = precioProducto
}

print("\n========== LISTA DE PRODUCTOS ==========")

for (nombre, precio) in catalogo {
    print("\(nombre): S/. \(precio)")
}

var totalCatalogo = 0.0

for (_, precio) in catalogo {
    totalCatalogo += precio
}

print("\n========== VALOR TOTAL ==========")
print("Valor total: S/. \(totalCatalogo)")

print("\n========== BÚSQUEDA DE PRODUCTO ==========")
print("Ingrese el producto a buscar:")

let buscarProducto = readLine() ?? ""

if let precioEncontrado = catalogo[buscarProducto] {
    print("\(buscarProducto) cuesta S/. \(precioEncontrado)")
} else {
    print("Producto no encontrado")
}

print("\n========== ANALYZE ==========")

var edades: [String: Int] = [
    "Carlos": 20,
    "Andy": 22,
    "olga": 19
]

var mayores: [String] = []

for (nombre, edad) in edades {
    if edad >= 21 {
        mayores.append(nombre)
    }
}

print("Mayores de 21: \(mayores)")

// El código recorre el diccionario de edades y revisa la edad
// de cada persona. Si tiene 21 años o más, agrega su nombre
// al array mayores. En este caso, Luis cumple la condición.
// El orden de un diccionario no está garantizado.

print("\n========== FIN DEL EJERCICIO 2 ==========")
