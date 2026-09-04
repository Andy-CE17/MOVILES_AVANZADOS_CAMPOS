// Desarrollado por: Andy Luis Campos Escandón
// Ejercicio 3: Sets

import Foundation

// ===== TODO 8: Eliminar duplicados =====
print("========== NÚMEROS SIN DUPLICADOS ==========")

var numeros: [Int] = []

for i in 1...8 {
    print("Número \(i):")
    let numero = Int(readLine() ?? "") ?? 0
    numeros.append(numero)
}

print("\nCon duplicados: \(numeros)")

let sinDuplicados = Array(Set(numeros)).sorted()

print("Sin duplicados: \(sinDuplicados)")

// ===== TODO 9: Comparar asistencia =====
var asistenciaLunes: Set<String> = []
var asistenciaMartes: Set<String> = []

print("\n========== ASISTENCIA DEL LUNES ==========")

for i in 1...4 {
    print("Alumno \(i):")
    let nombre = readLine() ?? ""
    asistenciaLunes.insert(nombre)
}

print("\n========== ASISTENCIA DEL MARTES ==========")

for i in 1...4 {
    print("Alumno \(i):")
    let nombre = readLine() ?? ""
    asistenciaMartes.insert(nombre)
}

let ambosDias = asistenciaLunes.intersection(asistenciaMartes).sorted()
let soloLunes = asistenciaLunes.subtracting(asistenciaMartes).sorted()
let soloMartes = asistenciaMartes.subtracting(asistenciaLunes).sorted()

print("\n========== RESULTADOS DE ASISTENCIA ==========")
print("Ambos días: \(ambosDias)")
print("Solo lunes: \(soloLunes)")
print("Solo martes: \(soloMartes)")

// ===== PREDICT =====
print("\n========== PREDICT ==========")

let conjuntoA: Set<Int> = [1, 2, 3, 4, 5]
let conjuntoB: Set<Int> = [4, 5, 6, 7, 8]

print(conjuntoA.intersection(conjuntoB))
// PREDICT 1: contiene 4 y 5, el orden puede variar

print(conjuntoA.union(conjuntoB).count)
// PREDICT 2: 8

print(conjuntoA.subtracting(conjuntoB))
// PREDICT 3: contiene 1, 2 y 3, el orden puede variar

let repetidos: Set<String> = ["A", "B", "A", "C", "B"]

print(repetidos.count)
// PREDICT 4: 3

print("\n========== FIN DEL EJERCICIO 3 ==========")
