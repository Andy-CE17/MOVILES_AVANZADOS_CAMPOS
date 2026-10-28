import Foundation

struct TasasAFP {
    let fondo: Decimal
    let comision: Decimal
    let seguro: Decimal
}

enum Parametros {
    static let rmv: Decimal = 1230
    static let asignacionFamiliar: Decimal = decimal("0.10")
    static let onp: Decimal = decimal("0.13")
    static let essalud: Decimal = decimal("0.09")
    static let recargo25: Decimal = decimal("1.25")
    static let recargo35: Decimal = decimal("1.35")
    static let fechaConsulta = "22/10/2026"

    static let tasasAFP: [String: TasasAFP] = [
        "AFP Guía": TasasAFP(fondo: decimal("0.10"), comision: decimal("0.016"), seguro: decimal("0.0135")),
        "Habitat": TasasAFP(fondo: decimal("0.10"), comision: decimal("0.0147"), seguro: decimal("0.0137")),
        "Integra": TasasAFP(fondo: decimal("0.10"), comision: decimal("0.0155"), seguro: decimal("0.0137")),
        "Prima": TasasAFP(fondo: decimal("0.10"), comision: decimal("0.016"), seguro: decimal("0.0137")),
        "Profuturo": TasasAFP(fondo: decimal("0.10"), comision: decimal("0.0169"), seguro: decimal("0.0137"))
    ]

    static let ordenAFP = ["AFP Guía", "Habitat", "Integra", "Prima", "Profuturo"]

    private static func decimal(_ value: String) -> Decimal {
        Decimal(string: value, locale: Locale(identifier: "en_US_POSIX"))!
    }
}
