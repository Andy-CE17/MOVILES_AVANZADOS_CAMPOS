// Desarrollado por: Andy Luis Campos Escandón
// Ejercicio 1: Arrays

import Foundation

print("========== REGISTRO DE ALUMNOS ==========")

// ===== TODO 1: Registro de 5 alumnos =====
var alumnos: [String] = []

for i in 1...5 {
    print("Nombre del alumno \(i):")
    let nombre = readLine() ?? ""
    alumnos.append(nombre)
}

print("\n========== LISTA DE ALUMNOS ==========")
print("Alumnos: \(alumnos)")

// ===== TODO 2: Buscar un alumno =====
print("\n========== BÚSQUEDA DE ALUMNO ==========")
print("Ingrese el nombre del alumno a buscar:")
let buscar = readLine() ?? ""

if alumnos.contains(buscar) {
    print("Resultado: \(buscar) está en la lista")
} else {
    print("Resultado: \(buscar) NO está en la lista")
}

// ===== TODO 3: Notas con clasificación =====
print("\n========== REGISTRO DE NOTAS ==========")

var notasClase: [Double] = []

for i in 1...5 {
    print("Nota del alumno \(i):")
    let nota = Double(readLine() ?? "") ?? 0
    notasClase.append(nota)
}

var aprobados = 0
var desaprobados = 0
var sumaNotas = 0.0

for nota in notasClase {
    sumaNotas += nota

    if nota >= 13 {
        aprobados += 1
    } else {
        desaprobados += 1
    }
}

let promedio = sumaNotas / Double(notasClase.count)

print("\n========== RESULTADOS DE NOTAS ==========")
print("Promedio: \(promedio)")
print("Aprobados: \(aprobados)")
print("Desaprobados: \(desaprobados)")

// ===== FIX: 3 errores corregidos =====
print("\n========== FIX: ERRORES CORREGIDOS ==========")

// FIX 1: El array contiene String, por eso agrego una fruta como texto
var frutas = ["Manzana", "Plátano", "Naranja"]
frutas.append("Pera")
print("Frutas: \(frutas)")

// FIX 2: Uso var porque necesito modificar el array
var colores = ["Rojo", "Azul", "Verde"]
colores.append("Amarillo")
print("Colores: \(colores)")

// FIX 3: El último índice válido del array es 4
let numeros = [10, 20, 30, 40, 50]
print("Último número: \(numeros[4])")

// ===== PREDICT =====
print("\n========== PREDICT ==========")

var lista = [1, 2, 3, 4, 5]
lista.remove(at: 0)
lista.append(6)

print("PREDICT 1: \(lista)")       // [2, 3, 4, 5, 6]
print("PREDICT 2: \(lista.count)") // 5

var nombres = ["Ana", "Carlos", "Beto"]

print("PREDICT 3: \(nombres.sorted())") // ["Ana", "Beto", "Carlos"]
print("PREDICT 4: \(nombres)")          // ["Ana", "Carlos", "Beto"]

print("\n========== FIN DEL EJERCICIO 1 ==========")
