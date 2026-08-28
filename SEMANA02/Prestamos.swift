import Foundation

// Límites de préstamo por tipo de usuario
let limiteAlumno = 7
let limiteDocente = 15
let limiteAdmin = 10

// Multa base diaria
let tarifaAlumno = 1.50
let tarifaDocente = 2.00
let tarifaAdmin = 3.00

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

// Verificar que la fecha prometida no sea anterior
if fechaPrometida < fechaPrestamo {
    print("La fecha prometida no puede ser anterior a la fecha de préstamo")
    exit(0)
}

// Calcular cuántos días está solicitando
let diferenciaPrestamo = calendario.dateComponents(
    [.day],
    from: fechaPrestamo,
    to: fechaPrometida
)

let diasSolicitados = diferenciaPrestamo.day ?? 0

// Validar el máximo permitido
if diasSolicitados > diasPermitidos {
    print("\n==========================================")
    print("          PRÉSTAMO NO PERMITIDO")
    print("==========================================")
    print("Usuario: \(usuario)")
    print("Máximo permitido: \(diasPermitidos) días")
    print("Días solicitados: \(diasSolicitados)")
    print("Debe elegir una fecha dentro del límite permitido.")
    exit(0)
}

print("\n==========================================")
print("            PRÉSTAMO PERMITIDO")
print("==========================================")
print("Libro: \(titulo)")
print("Usuario: \(usuario)")
print("Días solicitados: \(diasSolicitados)")
print("Máximo permitido: \(diasPermitidos)")
