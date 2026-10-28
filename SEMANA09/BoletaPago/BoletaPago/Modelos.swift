import Foundation

enum SistemaPension: String, CaseIterable {
    case onp = "ONP"
    case afp = "AFP"
}

struct DatosBoleta {
    let sueldo: Decimal
    let dias: Int
    let hijos: Bool
    let sistema: SistemaPension
    let afp: String
    let horas25: Decimal
    let horas35: Decimal
    let adelanto: Decimal
}

struct Concepto: Identifiable {
    let id = UUID()
    let nombre: String
    let monto: Decimal
}

struct ResultadoBoleta {
    let remuneraciones: [Concepto]
    let descuentos: [Concepto]
    let aportaciones: [Concepto]
    let totalRemuneraciones: Decimal
    let totalDescuentos: Decimal
    let neto: Decimal
    let essalud: Decimal
    let costoEmpresa: Decimal
}

enum ErrorBoleta: LocalizedError {
    case dato(String)

    var errorDescription: String? {
        switch self {
        case .dato(let mensaje): mensaje
        }
    }
}

enum Entrada {
    static func decimal(_ texto: String, nombre: String) throws -> Decimal {
        let limpio = texto.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: ",", with: ".")
        guard !limpio.isEmpty,
              let valor = Decimal(string: limpio, locale: Locale(identifier: "en_US_POSIX")) else {
            throw ErrorBoleta.dato("\(nombre): escribe un número válido.")
        }
        return valor
    }
}
