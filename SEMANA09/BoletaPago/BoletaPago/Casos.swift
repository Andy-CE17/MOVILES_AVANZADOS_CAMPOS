import Foundation

struct CasoBoleta {
    let nombre: String
    let datos: DatosBoleta
}

enum Casos {
    static let todos: [CasoBoleta] = [
        CasoBoleta(nombre: "Caso 1 · ONP completo", datos: DatosBoleta(sueldo: 2500, dias: 30, hijos: false, sistema: .onp, afp: "AFP Guía", horas25: 0, horas35: 0, adelanto: 0)),
        CasoBoleta(nombre: "Caso 2 · ONP 27 días", datos: DatosBoleta(sueldo: 1800, dias: 27, hijos: true, sistema: .onp, afp: "AFP Guía", horas25: 0, horas35: 0, adelanto: 0)),
        CasoBoleta(nombre: "Caso 3 · AFP y horas extra", datos: DatosBoleta(sueldo: 3000, dias: 30, hijos: true, sistema: .afp, afp: "AFP Guía", horas25: 4, horas35: 4, adelanto: 200)),
        CasoBoleta(nombre: "Caso 4 · AFP 24 días", datos: DatosBoleta(sueldo: 4200, dias: 24, hijos: true, sistema: .afp, afp: "AFP Guía", horas25: 2, horas35: 2, adelanto: 100)),
        CasoBoleta(nombre: "Caso propio 1 · Oferta S/ 1600", datos: DatosBoleta(sueldo: 1600, dias: 30, hijos: false, sistema: .onp, afp: "AFP Guía", horas25: 0, horas35: 0, adelanto: 0)),
        CasoBoleta(nombre: "Caso propio 2 · Oferta S/ 4000", datos: DatosBoleta(sueldo: 4000, dias: 30, hijos: false, sistema: .afp, afp: "Habitat", horas25: 0, horas35: 0, adelanto: 0))
    ]
}
