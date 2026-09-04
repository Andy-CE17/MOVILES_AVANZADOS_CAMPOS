// Desarrollado por: Andy Luis Campos Escandón
// Ejercicio 5: Carrito 2.0

import Foundation

print("========== CARRITO 2.0 ==========")

// ===== TODO 11: Registrar productos =====

print("¿Cuántos productos desea comprar?")
let cantidadProductos = Int(readLine() ?? "") ?? 0

var nombresProductos: [String] = []
var preciosProductos: [Double] = []
var cantidadesProductos: [Int] = []

for i in 1...cantidadProductos {
    print("\n========== PRODUCTO \(i) ==========")

    print("Nombre:")
    let nombre = readLine() ?? ""

    print("Precio:")
    let precio = Double(readLine() ?? "") ?? 0

    print("Cantidad:")
    let cantidad = Int(readLine() ?? "") ?? 0

    nombresProductos.append(nombre)
    preciosProductos.append(precio)
    cantidadesProductos.append(cantidad)
}

// ===== TODO 12: Calcular subtotales =====

var subtotales: [Double] = []

for i in 0..<nombresProductos.count {
    let subtotal = preciosProductos[i] * Double(cantidadesProductos[i])
    subtotales.append(subtotal)
}

// ===== TODO 13: Calcular total del carrito =====

var totalCarrito = 0.0

for subtotal in subtotales {
    totalCarrito += subtotal
}

// ===== TODO 14: Registrar cliente =====

print("\n========== DATOS DEL CLIENTE ==========")

print("Nombre del cliente:")
let cliente = readLine() ?? ""

// ===== TODO 15: Aplicar descuento =====

var porcentajeDescuento = 0.0

if totalCarrito >= 5000 {
    porcentajeDescuento = 0.15
} else if totalCarrito >= 2000 {
    porcentajeDescuento = 0.10
} else if totalCarrito >= 500 {
    porcentajeDescuento = 0.05
} else {
    porcentajeDescuento = 0.0
}

let descuento = totalCarrito * porcentajeDescuento
let totalConDescuento = totalCarrito - descuento

// ===== TODO 16: Calcular IGV =====

let igv = totalConDescuento * 0.18
let totalFinal = totalConDescuento + igv

// ===== TODO 17: Categoría del cliente =====

var categoria = ""

switch totalCarrito {
case 0..<500:
    categoria = "Regular"

case 500..<2000:
    categoria = "Frecuente"

case 2000..<5000:
    categoria = "VIP"

default:
    categoria = "Premium"
}

// ===== TODO 18: Mostrar ticket completo =====

print("\n========== TICKET DE COMPRA ==========")

print("Cliente: \(cliente)")
print("Categoría: \(categoria)")

print("\n========== DETALLE DE PRODUCTOS ==========")

for i in 0..<nombresProductos.count {
    print("\nProducto: \(nombresProductos[i])")
    print("Precio: S/. \(String(format: "%.2f", preciosProductos[i]))")
    print("Cantidad: \(cantidadesProductos[i])")
    print("Subtotal: S/. \(String(format: "%.2f", subtotales[i]))")
}

print("\n========== RESUMEN DE COMPRA ==========")

print("Total del carrito: S/. \(String(format: "%.2f", totalCarrito))")
print("Descuento: \(Int(porcentajeDescuento * 100))%")
print("Monto descontado: S/. \(String(format: "%.2f", descuento))")
print("Total con descuento: S/. \(String(format: "%.2f", totalConDescuento))")
print("IGV (18%): S/. \(String(format: "%.2f", igv))")
print("TOTAL FINAL: S/. \(String(format: "%.2f", totalFinal))")

print("\n========== FIN DEL EJERCICIO 5 ==========")
