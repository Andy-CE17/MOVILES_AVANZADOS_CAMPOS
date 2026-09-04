// Desarrollado por: Andy Luis Campos Escandón
// Ejercicio 4: Combinación de Colecciones

import Foundation

// ===== TODO 10: Inventario =====
print("========== REGISTRO DE INVENTARIO ==========")

print("¿Cuántos productos desea registrar?")
let cantidadProductos = Int(readLine() ?? "") ?? 0

var precios: [String: Double] = [:]
var stocks: [String: Int] = [:]

for i in 1...cantidadProductos {
    print("\n========== PRODUCTO \(i) ==========")

    print("Nombre:")
    let nombre = readLine() ?? ""

    print("Precio:")
    let precio = Double(readLine() ?? "") ?? 0

    print("Stock:")
    let stock = Int(readLine() ?? "") ?? 0

    precios[nombre] = precio
    stocks[nombre] = stock
}

// ===== Mostrar inventario =====
print("\n========== INVENTARIO REGISTRADO ==========")

for (nombre, precio) in precios {
    let stock = stocks[nombre] ?? 0

    print("\(nombre) | Precio: S/. \(precio) | Stock: \(stock)")
}

// ===== Calcular valor total =====
var valorTotal = 0.0

for (nombre, precio) in precios {
    let stock = stocks[nombre] ?? 0
    valorTotal += precio * Double(stock)
}

print("\n========== VALOR TOTAL DEL INVENTARIO ==========")
print("Valor total: S/. \(valorTotal)")

// ===== Productos con stock menor a 5 =====
print("\n========== PRODUCTOS CON STOCK BAJO ==========")

var hayStockBajo = false

for (nombre, stock) in stocks {
    if stock < 5 {
        print("\(nombre) | Stock: \(stock)")
        hayStockBajo = true
    }
}

if !hayStockBajo {
    print("No hay productos con stock menor a 5")
}

print("\n========== FIN DEL EJERCICIO 4 ==========")
