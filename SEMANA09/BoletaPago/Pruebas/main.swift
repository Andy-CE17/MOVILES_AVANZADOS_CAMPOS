import Foundation

struct Esperado {
    let ingresos: Decimal
    let descuentos: Decimal
    let neto: Decimal
    let essalud: Decimal
    let costoEmpresa: Decimal
}

let esperados = [
    Esperado(ingresos: 2500, descuentos: 325, neto: 2175, essalud: 225, costoEmpresa: 2725),
    Esperado(ingresos: 1743, descuentos: Decimal(string: "226.59")!, neto: Decimal(string: "1516.41")!, essalud: Decimal(string: "156.87")!, costoEmpresa: Decimal(string: "1899.87")!),
    Esperado(ingresos: 3253, descuentos: Decimal(string: "621.27")!, neto: Decimal(string: "2631.73")!, essalud: Decimal(string: "292.77")!, costoEmpresa: Decimal(string: "3545.77")!),
    Esperado(ingresos: 3574, descuentos: Decimal(string: "562.83")!, neto: Decimal(string: "3011.17")!, essalud: Decimal(string: "321.66")!, costoEmpresa: Decimal(string: "3895.66")!),
    Esperado(ingresos: 1600, descuentos: 208, neto: 1392, essalud: 144, costoEmpresa: 1744),
    Esperado(ingresos: 4000, descuentos: Decimal(string: "513.60")!, neto: Decimal(string: "3486.40")!, essalud: 360, costoEmpresa: 4360)
]

func texto(_ numero: Decimal) -> String {
    NSDecimalNumber(decimal: numero).stringValue
}

func comprobar(_ nombre: String, _ obtenido: Decimal, _ esperado: Decimal) -> Bool {
    if obtenido == esperado { return true }
    print("ERROR \(nombre): se obtuvo \(texto(obtenido)); se esperaba \(texto(esperado))")
    return false
}

var correcto = true
var salida: [[String: Any]] = []

for (indice, caso) in Casos.todos.enumerated() {
    do {
        let resultado = try Boleta().calcular(caso.datos)
        let esperado = esperados[indice]
        correcto = comprobar("\(caso.nombre) ingresos", resultado.totalRemuneraciones, esperado.ingresos) && correcto
        correcto = comprobar("\(caso.nombre) descuentos", resultado.totalDescuentos, esperado.descuentos) && correcto
        correcto = comprobar("\(caso.nombre) neto", resultado.neto, esperado.neto) && correcto
        correcto = comprobar("\(caso.nombre) EsSalud", resultado.essalud, esperado.essalud) && correcto
        correcto = comprobar("\(caso.nombre) costo", resultado.costoEmpresa, esperado.costoEmpresa) && correcto
        salida.append([
            "caso": caso.nombre,
            "ingresos": texto(resultado.totalRemuneraciones),
            "descuentos": texto(resultado.totalDescuentos),
            "neto": texto(resultado.neto),
            "essalud": texto(resultado.essalud),
            "costoEmpresa": texto(resultado.costoEmpresa)
        ])
    } catch {
        correcto = false
        print("ERROR \(caso.nombre): \(error.localizedDescription)")
    }
}

do {
    let invalido = DatosBoleta(sueldo: 2500, dias: 31, hijos: false, sistema: .onp, afp: "AFP Guía", horas25: 0, horas35: 0, adelanto: 0)
    _ = try Boleta().calcular(invalido)
    print("ERROR: el cálculo aceptó 31 días")
    correcto = false
} catch {
    print("Validación correcta: \(error.localizedDescription)")
}

let json = try JSONSerialization.data(withJSONObject: salida, options: [.prettyPrinted, .sortedKeys])
print(String(data: json, encoding: .utf8)!)

if correcto {
    print("RESULTADO: los seis casos coinciden con el Excel al centavo.")
} else {
    exit(1)
}
