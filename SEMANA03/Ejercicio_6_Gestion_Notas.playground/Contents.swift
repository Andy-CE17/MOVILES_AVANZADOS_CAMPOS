// Desarrollado por: Andy Luis Campos Escandón
// Ejercicio 6: Gestión de Notas - SE USO IA

// Importo Foundation para usar funciones básicas de Swift
import Foundation

// Creo un diccionario para guardar el nombre del estudiante y sus notas
var estudiantes: [String: [Double]] = [:]

// Creo un diccionario para guardar el promedio de cada estudiante
var promedios: [String: Double] = [:]

// Muestro el título del programa
print("========== GESTIÓN DE NOTAS ==========")

// Pido la cantidad de estudiantes
print("Ingrese la cantidad de estudiantes:")

// Leo la cantidad de estudiantes y la convierto a entero
let cantidadEstudiantes = Int(readLine() ?? "") ?? 0

// Repito el proceso según la cantidad de estudiantes
for i in 1...cantidadEstudiantes {
    
    // Muestro el número del estudiante
    print("\n========== ESTUDIANTE \(i) ==========")
    
    // Pido el nombre del estudiante
    print("Nombre:")
    
    // Leo el nombre ingresado
    let nombre = readLine() ?? ""
    
    // Creo un arreglo para guardar las tres notas
    var notas: [Double] = []
    
    // Repito tres veces para registrar las notas
    for j in 1...3 {
        
        // Pido la nota correspondiente
        print("Nota \(j):")
        
        // Leo la nota y la convierto a Double
        let nota = Double(readLine() ?? "") ?? 0
        
        // Agrego la nota al arreglo
        notas.append(nota)
    }
    
    // Guardo las notas usando el nombre como clave
    estudiantes[nombre] = notas
}

// Muestro el título de resultados
print("\n========== RESULTADOS ==========")

// Recorro todos los estudiantes registrados
for (nombre, notas) in estudiantes {
    
    // Creo una variable para acumular las notas
    var suma = 0.0
    
    // Recorro las notas del estudiante
    for nota in notas {
        
        // Sumo cada nota
        suma += nota
    }
    
    // Calculo el promedio del estudiante
    let promedio = suma / Double(notas.count)
    
    // Guardo el promedio en el diccionario
    promedios[nombre] = promedio
    
    // Creo una variable para guardar la clasificación
    var clasificacion = ""
    
    // Evalúo el promedio usando switch
    switch promedio {
        
    // Si el promedio está entre 18 y 20
    case 18...20:
        
        // Asigno la clasificación Excelente
        clasificacion = "Excelente"
        
    // Si el promedio está entre 15 y menos de 18
    case 15..<18:
        
        // Asigno la clasificación Bueno
        clasificacion = "Bueno"
        
    // Si el promedio está entre 13 y menos de 15
    case 13..<15:
        
        // Asigno la clasificación Aprobado
        clasificacion = "Aprobado"
        
    // Para cualquier promedio menor a 13
    default:
        
        // Asigno la clasificación Desaprobado
        clasificacion = "Desaprobado"
    }
    
    // Muestro el nombre del estudiante
    print("\nEstudiante: \(nombre)")
    
    // Muestro sus notas
    print("Notas: \(notas)")
    
    // Muestro el promedio con dos decimales
    print("Promedio: \(String(format: "%.2f", promedio))")
    
    // Muestro la clasificación obtenida
    print("Clasificación: \(clasificacion)")
}

// Creo una variable para calcular el promedio general
var sumaPromedios = 0.0

// Creo una variable para guardar la nota más alta
var notaMayor = 0.0

// Creo una variable para guardar la nota más baja
var notaMenor = 20.0

// Creo una variable para contar estudiantes aprobados
var aprobados = 0

// Recorro todos los estudiantes
for (_, notas) in estudiantes {
    
    // Recorro todas las notas de cada estudiante
    for nota in notas {
        
        // Compruebo si la nota es mayor a la actual
        if nota > notaMayor {
            
            // Actualizo la nota mayor
            notaMayor = nota
        }
        
        // Compruebo si la nota es menor a la actual
        if nota < notaMenor {
            
            // Actualizo la nota menor
            notaMenor = nota
        }
    }
}

// Recorro todos los promedios
for (_, promedio) in promedios {
    
    // Sumo cada promedio
    sumaPromedios += promedio
    
    // Compruebo si el estudiante aprobó
    if promedio >= 13 {
        
        // Aumento el contador de aprobados
        aprobados += 1
    }
}

// Calculo el promedio general
let promedioGeneral = sumaPromedios / Double(promedios.count)

// Calculo el porcentaje de aprobados
let porcentajeAprobados = Double(aprobados) / Double(promedios.count) * 100

// Muestro el título de estadísticas
print("\n========== ESTADÍSTICAS ==========")

// Muestro el promedio general
print("Promedio general: \(String(format: "%.2f", promedioGeneral))")

// Muestro la nota más alta
print("Nota más alta: \(notaMayor)")

// Muestro la nota más baja
print("Nota más baja: \(notaMenor)")

// Muestro el porcentaje de aprobados
print("Porcentaje de aprobados: \(String(format: "%.2f", porcentajeAprobados))%")

// Ordeno los estudiantes de mayor a menor promedio
let ranking = promedios.sorted { $0.value > $1.value }

// Muestro el título del ranking
print("\n========== RANKING ==========")

// Recorro los estudiantes ordenados
for (nombre, promedio) in ranking {
    
    // Muestro el nombre y promedio de cada estudiante
    print("\(nombre): \(String(format: "%.2f", promedio))")
}
