import Foundation

// Docente: Juan León S.

// ==========================================
// EJERCICIO 6: CARRITO MEJORADO CON IA
// ==========================================


// Guarda el nombre del primer producto.
let prod1 = "Laptop"

// Guarda el precio de la Laptop.
let precio1 = 3500.0

// Guarda la cantidad de Laptops compradas.
let cant1 = 1

// Guarda el nombre del segundo producto.
let prod2 = "Mouse"

// Guarda el precio del Mouse.
let precio2 = 45.50

// Guarda la cantidad de Mouse comprados.
let cant2 = 2

// Guarda el nombre del tercer producto.
let prod3 = "Teclado"

// Guarda el precio del Teclado.
let precio3 = 120.00

// Guarda la cantidad de Teclados comprados.
let cant3 = 1

// Guarda el nombre del cuarto producto.
let prod4 = "Monitor"

// Guarda el precio del Monitor.
let precio4 = 890.00

// Guarda la cantidad de Monitores comprados.
let cant4 = 1

// Guarda el nombre del quinto producto.
let prod5 = "USB Cable"

// Guarda el precio del USB Cable.
let precio5 = 15.00

// Guarda la cantidad de cables USB comprados.
let cant5 = 3

//===========================
//  validación de datos,
//============================


// Verifica si alguno de los precios es negativo.
let precioInvalido = precio1 < 0 ||
                     precio2 < 0 ||
                     precio3 < 0 ||
                     precio4 < 0 ||
                     precio5 < 0

// Verifica si alguna cantidad es igual a cero.
let cantidadInvalida = cant1 == 0 ||
                       cant2 == 0 ||
                       cant3 == 0 ||
                       cant4 == 0 ||
                       cant5 == 0

// Comprueba si existe algún dato inválido antes de continuar.
if precioInvalido || cantidadInvalida {
    // Muestra un mensaje si encuentra un precio negativo o una cantidad igual a cero.
    print("Error: existen datos inválidos en el carrito.")
} else {
    // Indica que los datos son correctos y se puede continuar con los cálculos.
    print("Datos del carrito válidos.")
}


//===========================
//  escuento por cantidad,
//============================

// Calcula el subtotal de la Laptop.
var sub1 = precio1 * Double(cant1)

// Calcula el subtotal del Mouse.
var sub2 = precio2 * Double(cant2)

// Calcula el subtotal del Teclado.
var sub3 = precio3 * Double(cant3)

// Calcula el subtotal del Monitor.
var sub4 = precio4 * Double(cant4)

// Calcula el subtotal del USB Cable.
var sub5 = precio5 * Double(cant5)


// Aplica 5% de descuento a la Laptop si se compran 3 o más unidades.
if cant1 >= 3 {
    sub1 = sub1 - (sub1 * 0.05)
}

// Aplica 5% de descuento al Mouse si se compran 3 o más unidades.
if cant2 >= 3 {
    sub2 = sub2 - (sub2 * 0.05)
}

// Aplica 5% de descuento al Teclado si se compran 3 o más unidades.
if cant3 >= 3 {
    sub3 = sub3 - (sub3 * 0.05)
}

// Aplica 5% de descuento al Monitor si se compran 3 o más unidades.
if cant4 >= 3 {
    sub4 = sub4 - (sub4 * 0.05)
}

// Aplica 5% de descuento al USB Cable si se compran 3 o más unidades.
if cant5 >= 3 {
    sub5 = sub5 - (sub5 * 0.05)
}


//===========================
//  Cupon de DESCUENTO20
//============================

// Suma los subtotales de todos los productos después del descuento por cantidad.
let subtotalGeneral = sub1 + sub2 + sub3 + sub4 + sub5

// Guarda el código del cupón que se utilizará en la compra.
let cupon = "DESCUENTO20"

// Guarda inicialmente el descuento del cupón en cero.
var descuentoCupon = 0.0

// Verifica si el cupón ingresado corresponde al cupón válido.
if cupon == "DESCUENTO20" {
    // Calcula el 20% de descuento sobre el subtotal general.
    descuentoCupon = subtotalGeneral * 0.20
}

// Resta el descuento del cupón al subtotal general.
let totalConCupon = subtotalGeneral - descuentoCupon



//===========================
//  costo de envío.
//============================

// Guarda inicialmente el costo normal del envío.
var costoEnvio = 25.0

// Verifica si el total después del cupón supera los S/. 3000.
if totalConCupon > 3000 {
    // Cambia el costo de envío a cero porque la compra supera los S/. 3000.
    costoEnvio = 0.0
}

// Suma el costo de envío al total después de aplicar el cupón.
let totalConEnvio = totalConCupon + costoEnvio


//===========================
//  puntos de fidelidad.
//============================

// Calcula cuántos puntos gana el cliente según el total de la compra.
let puntosFidelidad = Int(totalConEnvio / 100)

// Muestra los puntos obtenidos por el cliente.
print("Puntos de fidelidad ganados: \(puntosFidelidad)")


//===========================
//TiTcket final ordenado
//============================

// Crea una línea separadora para ordenar visualmente el ticket.
let separador = "========================================"

// Muestra la línea inicial del ticket.
print(separador)

// Muestra el título del ticket.
print("        CARRITO MEJORADO")

// Muestra nuevamente la línea separadora.
print(separador)

// Muestra el subtotal final de la Laptop.
print("\(prod1) x\(cant1): S/. \(String(format: "%.2f", sub1))")

// Muestra el subtotal final del Mouse.
print("\(prod2) x\(cant2): S/. \(String(format: "%.2f", sub2))")

// Muestra el subtotal final del Teclado.
print("\(prod3) x\(cant3): S/. \(String(format: "%.2f", sub3))")

// Muestra el subtotal final del Monitor.
print("\(prod4) x\(cant4): S/. \(String(format: "%.2f", sub4))")

// Muestra el subtotal final del USB Cable después del descuento por cantidad.
print("\(prod5) x\(cant5): S/. \(String(format: "%.2f", sub5))")

// Muestra una línea para separar los productos de los cálculos.
print(separador)

// Muestra el subtotal después de aplicar los descuentos por cantidad.
print("Subtotal: S/. \(String(format: "%.2f", subtotalGeneral))")

// Muestra el descuento obtenido por utilizar el cupón.
print("Descuento cupón: -S/. \(String(format: "%.2f", descuentoCupon))")

// Muestra el costo de envío correspondiente a la compra.
print("Envío: S/. \(String(format: "%.2f", costoEnvio))")

// Muestra otra línea separadora antes del total.
print(separador)

// Muestra el total final de la compra incluyendo el envío.
print("TOTAL: S/. \(String(format: "%.2f", totalConEnvio))")

// Muestra los puntos de fidelidad obtenidos.
print("Puntos de fidelidad: \(puntosFidelidad)")

// Muestra la línea final del ticket.
print(separador)

// Muestra un mensaje de agradecimiento al cliente.
print("¡Gracias por su compra!")
