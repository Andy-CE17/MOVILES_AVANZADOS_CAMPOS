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

var usuario = ""
var diasPermitidos = 0
var tarifaDiaria = 0.0

// Selección del usuario
while true {

    print("\nTipo de usuario:")
    print("1. Alumno")
    print("2. Docente")
    print("3. Administrador")
    print("4. Contador")

    let opcion = readLine() ?? ""

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
        print("Opción no válida. Intente nuevamente.")
        continue
    }

    break
}

// Configuración para trabajar con fechas
let formato = DateFormatter()
formato.dateFormat = "dd/MM/yyyy"
formato.locale = Locale(identifier: "es_PE")
formato.isLenient = false

let calendario = Calendar.current

// Obtengo la fecha actual sin considerar la hora
let fechaActual = calendario.startOfDay(for: Date())

var fechaPrestamo = Date()
var fechaPrometida = Date()

var textoPrestamo = ""
var textoPrometido = ""
var diasSolicitados = 0

// Valido las fechas del préstamo
while true {

    print("\nFecha de préstamo (dd/MM/yyyy):")
    textoPrestamo = readLine() ?? ""

    guard let fechaIngresada = formato.date(from: textoPrestamo) else {
        print("Fecha de préstamo no válida. Intente nuevamente.")
        continue
    }

    fechaPrestamo = calendario.startOfDay(for: fechaIngresada)

    // Valido que el préstamo se realice con la fecha actual
    if fechaPrestamo != fechaActual {

        print("\n==========================================")
        print("          🔒 PRÉSTAMO NO VÁLIDO")
        print("==========================================")
        print("Fecha ingresada: \(textoPrestamo)")
        print("Fecha actual: \(formato.string(from: fechaActual))")
        print("El préstamo debe realizarse con la fecha actual.")
        print("==========================================")

        continue
    }

    print("\nFecha prometida de devolución (dd/MM/yyyy):")
    textoPrometido = readLine() ?? ""

    guard let fechaPrometidaIngresada = formato.date(from: textoPrometido) else {
        print("Fecha prometida no válida. Intente nuevamente.")
        continue
    }

    fechaPrometida = calendario.startOfDay(for: fechaPrometidaIngresada)

    if fechaPrometida < fechaPrestamo {
        print("La fecha prometida no puede ser anterior a la fecha de préstamo.")
        continue
    }

    // Calculo cuántos días está solicitando
    let diferenciaPrestamo = calendario.dateComponents(
        [.day],
        from: fechaPrestamo,
        to: fechaPrometida
    )

    diasSolicitados = diferenciaPrestamo.day ?? 0

    // Valido el máximo permitido
    if diasSolicitados > diasPermitidos {

        let fechaMaxima = calendario.date(
            byAdding: .day,
            value: diasPermitidos,
            to: fechaPrestamo
        )!

        print("\n==========================================")
        print("         🔒 PRÉSTAMO NO PERMITIDO")
        print("==========================================")
        print("Usuario: \(usuario)")
        print("Máximo permitido: \(diasPermitidos) días")
        print("Días solicitados: \(diasSolicitados)")
        print("Fecha máxima permitida: \(formato.string(from: fechaMaxima))")
        print("Debe ingresar nuevamente las fechas.")
        print("==========================================")

        continue
    }

    break
}

print("\n==========================================")
print("          💵 PRÉSTAMO PERMITIDO")
print("==========================================")
print("Libro: \(titulo)")
print("Usuario: \(usuario)")
print("Días solicitados: \(diasSolicitados)")
print("Máximo permitido: \(diasPermitidos)")

var fechaDevolucion = Date()
var textoDevolucion = ""

// Valido la fecha real de devolución
while true {

    print("\nFecha real de devolución (dd/MM/yyyy):")
    textoDevolucion = readLine() ?? ""

    guard let fechaIngresada = formato.date(from: textoDevolucion) else {
        print("Fecha de devolución no válida. Intente nuevamente.")
        continue
    }

    fechaDevolucion = calendario.startOfDay(for: fechaIngresada)

    if fechaDevolucion < fechaPrestamo {
        print("La fecha de devolución no puede ser anterior a la fecha de préstamo.")
        continue
    }

    break
}

// Calculo los días de atraso
let diferenciaAtraso = calendario.dateComponents(
    [.day],
    from: fechaPrometida,
    to: fechaDevolucion
)

let diasAtraso = max(0, diferenciaAtraso.day ?? 0)

// Calculo la multa según los días de atraso
var multaTotal = 0.0

if diasAtraso > 0 {

    for dia in 1...diasAtraso {

        if dia <= 3 {
            multaTotal += 0.0
        } else if dia <= 6 {
            multaTotal += tarifaDiaria * 0.25
        } else if dia <= 10 {
            multaTotal += tarifaDiaria * 0.50
        } else {
            multaTotal += tarifaDiaria
        }
    }
}

// Estado del préstamo
let estado = diasAtraso == 0
    ? "Devuelto a tiempo"
    : "Devuelto con atraso"

// Situación del usuario
var situacion = "✔️ Habilitado"

// Verifico si el usuario queda suspendido
if diasAtraso >= 20 {
    situacion = "🔒 Suspendido"
}

// Detalle del atraso
print("\n================================================================")
print("                     DETALLE DEL ATRASO")
print("================================================================")

if diasAtraso == 0 {

    print("No existen días de atraso.")

} else {

    var acumulado = 0.0

    print("Fecha        Día       Multa         Acumulado")
    print("----------------------------------------------------------------")

    for dia in 1...diasAtraso {

        // Obtengo la fecha correspondiente a cada día de atraso
        let fechaDia = calendario.date(
            byAdding: .day,
            value: dia,
            to: fechaPrometida
        )!

        let fechaTexto = formato.string(from: fechaDia)

        var multaDia = 0.0
        var porcentaje = ""

        if dia <= 3 {
            multaDia = 0.0
            porcentaje = "Sin multa"

        } else if dia <= 6 {
            multaDia = tarifaDiaria * 0.25
            porcentaje = "25%"

        } else if dia <= 10 {
            multaDia = tarifaDiaria * 0.50
            porcentaje = "50%"

        } else {
            multaDia = tarifaDiaria
            porcentaje = "100%"
        }

        acumulado += multaDia

        print(
            "\(fechaTexto)   " +
            "\(String(format: "%2d", dia))      " +
            "S/ \(String(format: "%.2f", multaDia))      " +
            "S/ \(String(format: "%.2f", acumulado))"
        )

        print("             Multa aplicada: \(porcentaje)")
    }
}

print("================================================================")

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

// Muestro el mensaje si el usuario quedó suspendido
if diasAtraso >= 20 {

    print("\n==========================================")
    print("          🔒 USUARIO SUSPENDIDO")
    print("==========================================")
    print("El usuario alcanzó \(diasAtraso) días de atraso.")
    print("No puede realizar nuevos préstamos.")
    print("==========================================")
}
