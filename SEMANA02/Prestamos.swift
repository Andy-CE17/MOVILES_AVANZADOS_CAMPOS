import Foundation

// Límites de préstamo por tipo de usuario
let limiteAlumno = 7
let limiteDocente = 15
let limiteAdmin = 10
let limiteContador = 15

// Multa base diaria
let tarifaAlumno = 1.50
let tarifaDocente = 2.00
let tarifaAdmin = 3.00
let tarifaContador = 4.00

// Datos del libro
print("==========================================")
print("       SISTEMA DE PRÉSTAMO DE LIBROS")
print("==========================================")

print("\nTítulo del libro:")
let titulo = readLine() ?? ""

// Selección del usuario
print("\nTipo de usuario:")
print("1. Alumno")
print("2. Docente")
print("3. Administrador")
print("4. Contador")

let opcion = readLine() ?? ""

var usuario = ""
var diasPermitidos = 0
var tarifaDiaria = 0.0

switch opcion {
case "1":
    usuario = "Alumno"
    diasPermitidos = limiteAlumno
    tarifaDiaria = tarifaAlumno

case "2":
    usuario = "Docente"
    diasPermitidos = limiteDocente
    tarifaDiaria = tarifaDocente

case "3":
    usuario = "Administrador"
    diasPermitidos = limiteAdmin
    tarifaDiaria = tarifaAdmin

case "4":
    usuario = "Contador"
    diasPermitidos = limiteContador
    tarifaDiaria = tarifaContador

default:
    print("Opción no válida")
    exit(0)
}

// Configuración para trabajar con fechas
let formato = DateFormatter()
formato.dateFormat = "dd/MM/yyyy"
formato.isLenient = false

let calendario = Calendar.current

print("\nFecha de préstamo (dd/MM/yyyy):")
let textoPrestamo = readLine() ?? ""

guard let fechaPrestamo = formato.date(from: textoPrestamo) else {
    print("Fecha de préstamo no válida")
    exit(0)
}

print("Fecha prometida de devolución (dd/MM/yyyy):")
let textoPrometido = readLine() ?? ""

guard let fechaPrometida = formato.date(from: textoPrometido) else {
    print("Fecha prometida no válida")
    exit(0)
}

if fechaPrometida < fechaPrestamo {
    print("La fecha prometida no puede ser anterior a la fecha de préstamo")
    exit(0)
}

// Calculo cuántos días está solicitando
let diferenciaPrestamo = calendario.dateComponents(
    [.day],
    from: fechaPrestamo,
    to: fechaPrometida
)

let diasSolicitados = diferenciaPrestamo.day ?? 0

// Valido el máximo permitido
if diasSolicitados > diasPermitidos {
    print("\n==========================================")
    print("         🔒 PRÉSTAMO NO PERMITIDO")
    print("==========================================")
    print("Usuario: \(usuario)")
    print("Máximo permitido: \(diasPermitidos) días")
    print("Días solicitados: \(diasSolicitados)")
    print("Debe elegir una fecha dentro del límite permitido.")
    exit(0)
}

print("\n==========================================")
print("           💵 PRÉSTAMO PERMITIDO")
print("==========================================")
print("Libro: \(titulo)")
print("Usuario: \(usuario)")
print("Días solicitados: \(diasSolicitados)")
print("Máximo permitido: \(diasPermitidos)")

// Fecha real de devolución
print("\nFecha real de devolución (dd/MM/yyyy):")
let textoDevolucion = readLine() ?? ""

guard let fechaDevolucion = formato.date(from: textoDevolucion) else {
    print("Fecha de devolución no válida")
    exit(0)
}

if fechaDevolucion < fechaPrestamo {
    print("La fecha de devolución no puede ser anterior a la fecha de préstamo")
    exit(0)
}

// Calculo los días de atraso
let diferenciaAtraso = calendario.dateComponents(
    [.day],
    from: fechaPrometida,
    to: fechaDevolucion
)

let diasAtraso = max(0, diferenciaAtraso.day ?? 0)

// Calculo la multa
var multaTotal = 0.0

if diasAtraso > 0 {
    for dia in 1...diasAtraso {
        if dia <= 3 {
            multaTotal += tarifaDiaria
        } else if dia <= 6 {
            multaTotal += tarifaDiaria * 1.50
        } else {
            multaTotal += tarifaDiaria * 2
        }
    }
}

// Estado del préstamo
let estado = diasAtraso == 0
    ? "Devuelto a tiempo"
    : "Devuelto con atraso"

// Situación del usuario
var situacion = " ✔️ Habilitado"
if usuario == "Docente" && diasAtraso >= 10 {
    situacion = "Suspendido"
}

// Detalle de la multa por día
print("\n==========================================")
print("          DETALLE DEL ATRASO")
print("==========================================")

if diasAtraso == 0 {
    print("No existen días de atraso.")
} else {
    var acumulado = 0.0

    for dia in 1...diasAtraso {
        var multaDia = 0.0

        if dia <= 3 {
            multaDia = tarifaDiaria
        } else if dia <= 6 {
            multaDia = tarifaDiaria * 1.50
        } else {
            multaDia = tarifaDiaria * 2
        }

        acumulado += multaDia

        print(
            "Día \(dia) | Multa: S/ \(String(format: "%.2f", multaDia)) | Acumulado: S/ \(String(format: "%.2f", acumulado))"
        )
    }
}

// Resumen final
print("\n==========================================")
print("          RESUMEN DEL PRÉSTAMO")
print("==========================================")

print("Libro: \(titulo)")
print("Usuario: \(usuario)")
print("Fecha de préstamo: \(textoPrestamo)")
print("Fecha prometida: \(textoPrometido)")
print("Fecha real: \(textoDevolucion)")
print("Días permitidos: \(diasPermitidos)")
print("Días solicitados: \(diasSolicitados)")
print("Días de atraso: \(diasAtraso)")
print("Multa por día: S/ \(String(format: "%.2f", tarifaDiaria))")
print("Multa total: S/ \(String(format: "%.2f", multaTotal))")
print("Estado: \(estado)")
print("Situación: \(situacion)")

print("==========================================")

if situacion == "Suspendido" {
    print("El usuario quedó suspendido para nuevos préstamos.")
}
