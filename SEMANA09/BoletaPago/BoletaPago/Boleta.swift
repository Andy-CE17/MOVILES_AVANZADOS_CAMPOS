import Foundation

final class Boleta {
    func calcular(_ datos: DatosBoleta) throws -> ResultadoBoleta {
        guard datos.sueldo > 0 else {
            throw ErrorBoleta.dato("El sueldo debe ser mayor que cero.")
        }
        guard (1...30).contains(datos.dias) else {
            throw ErrorBoleta.dato("Los días laborados deben estar entre 1 y 30.")
        }
        guard datos.horas25 >= 0, datos.horas35 >= 0 else {
            throw ErrorBoleta.dato("Las horas extra no pueden ser negativas.")
        }
        guard datos.adelanto >= 0 else {
            throw ErrorBoleta.dato("El adelanto no puede ser negativo.")
        }

        let sueldoComputable = redondear(datos.sueldo / 30 * Decimal(datos.dias))
        let asignacion = redondear(datos.hijos ? Parametros.rmv * Parametros.asignacionFamiliar : 0)
        let valorHora = datos.sueldo / 30 / 8
        let extra25 = redondear(valorHora * Parametros.recargo25 * datos.horas25)
        let extra35 = redondear(valorHora * Parametros.recargo35 * datos.horas35)
        let totalRemuneraciones = redondear(sueldoComputable + asignacion + extra25 + extra35)

        let onp: Decimal
        let fondo: Decimal
        let comision: Decimal
        let seguro: Decimal

        switch datos.sistema {
        case .onp:
            onp = redondear(totalRemuneraciones * Parametros.onp)
            fondo = 0
            comision = 0
            seguro = 0
        case .afp:
            guard let tasas = Parametros.tasasAFP[datos.afp] else {
                throw ErrorBoleta.dato("Selecciona una AFP válida.")
            }
            onp = 0
            fondo = redondear(totalRemuneraciones * tasas.fondo)
            comision = redondear(totalRemuneraciones * tasas.comision)
            seguro = redondear(totalRemuneraciones * tasas.seguro)
        }

        let adelanto = redondear(datos.adelanto)
        let totalDescuentos = redondear(onp + fondo + comision + seguro + adelanto)
        let neto = redondear(totalRemuneraciones - totalDescuentos)
        let essalud = redondear(totalRemuneraciones * Parametros.essalud)
        let costoEmpresa = redondear(totalRemuneraciones + essalud)

        return ResultadoBoleta(
            remuneraciones: [
                Concepto(nombre: "Sueldo computable", monto: sueldoComputable),
                Concepto(nombre: "Asignación familiar", monto: asignacion),
                Concepto(nombre: "Horas extra 25%", monto: extra25),
                Concepto(nombre: "Horas extra 35%", monto: extra35)
            ],
            descuentos: [
                Concepto(nombre: "ONP", monto: onp),
                Concepto(nombre: "AFP fondo", monto: fondo),
                Concepto(nombre: "AFP comisión", monto: comision),
                Concepto(nombre: "AFP seguro", monto: seguro),
                Concepto(nombre: "Adelantos", monto: adelanto)
            ],
            aportaciones: [Concepto(nombre: "EsSalud (9%)", monto: essalud)],
            totalRemuneraciones: totalRemuneraciones,
            totalDescuentos: totalDescuentos,
            neto: neto,
            essalud: essalud,
            costoEmpresa: costoEmpresa
        )
    }

    private func redondear(_ valor: Decimal) -> Decimal {
        var entrada = valor
        var salida = Decimal()
        NSDecimalRound(&salida, &entrada, 2, .plain)
        return salida
    }
}
