// Desarrollado por: Andy Luis Campos Escandon
// ACTIVIDAD PROPUESTA 01 - CURSOS LIBRES TECSUP
// Docente: Juan Leon

import Foundation

// Datos del estudiante
let nombreEstudiante = "Andy Luis"
let dni = "60008025"
let esAlumnoTecsup = true

// Precios de los cursos
let swiftAvanzado = 450.00
let iaConPython = 1300.00
let disenoUXUI = 600.00

// Nombres de los cursos
let nombresCursos = [
    "Swift Avanzado",
    "IA con Python",
    "Diseño UX/UI"
]

// Lista de precios
let cursos = [
    swiftAvanzado,
    iaConPython,
    disenoUXUI
]

// Calculamos el subtotal
var subtotal = 0.0

for precio in cursos {
    subtotal += precio
}

// Calculamos el IGV
let igv = subtotal * 0.18

// Total incluyendo IGV
let totalConIGV = subtotal + igv

// Variables para los descuentos
var descuentoCursos = 0.0
var descuentoTecsup = 0.0

// Si lleva 3 o mas cursos aplica descuento
if cursos.count >= 3 {
    descuentoCursos = totalConIGV * 0.10

    // Descuento adicional si es alumno Tecsup
    if esAlumnoTecsup {
        descuentoTecsup = 400.0
    }
}

// Calculamos el total final
let totalFinal = totalConIGV - descuentoCursos - descuentoTecsup

// Mostramos la boleta
print("========================================")
print("       BOLETA DE MATRICULA TECSUP")
print("========================================")
print("Estudiante: \(nombreEstudiante)")
print("DNI: \(dni)")
print("Alumno Tecsup: \(esAlumnoTecsup ? "Si" : "No")")
print("----------------------------------------")
print("CURSOS INSCRITOS")

for i in 0..<cursos.count {
    print("\(i + 1). \(nombresCursos[i]) - S/ \(cursos[i])")
}

print("----------------------------------------")
print("Subtotal: S/ \(subtotal)")
print("IGV (18%): S/ \(igv)")
print("Total con IGV: S/ \(totalConIGV)")
print("Descuento 10%: S/ \(descuentoCursos)")
print("Descuento Tecsup: S/ \(descuentoTecsup)")
print("----------------------------------------")
print("TOTAL A PAGAR: S/ \(totalFinal)")
print("========================================")
