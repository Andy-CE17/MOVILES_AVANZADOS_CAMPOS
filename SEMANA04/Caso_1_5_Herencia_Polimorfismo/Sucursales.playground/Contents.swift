// Desarrollado por: Andy Luis Campos Escandon
// CASO 1.5: HERENCIA Y POLIMORFISMO - LA CADENA DE SUCURSALES
// Docente: Juan Leon

import Foundation


// ==================================================
// MARK: - MODELOS
// ==================================================

// Categorias de los electrodomesticos
enum CategoriaElectro {
    case lineaBlanca
    case tecnologia
    case pequenos
}

// Datos de cada electrodomestico
struct Electrodomestico {
    let nombre: String
    let marca: String
    let precioLista: Double
    let categoria: CategoriaElectro
}


// ==================================================
// MARK: - CLASE BASE
// ==================================================

class Sucursal {
    let nombre: String
    let ciudad: String

    init(nombre: String, ciudad: String) {
        self.nombre = nombre
        self.ciudad = ciudad
    }

    // Descuento base del 5%
    func descuento() -> Double {
        return 0.05
    }

    // Costo de envio base
    func costoEnvio(monto: Double) -> Double {
        return 30.0
    }

    // Flujo general de la cotizacion
    func cotizar(item: Electrodomestico) {
        let precioConDescuento = item.precioLista * (1 - descuento())
        let envio = costoEnvio(monto: precioConDescuento)
        let total = precioConDescuento + envio

        print("\(nombre): \(item.nombre) -> S/ \(precioConDescuento) + envio S/ \(envio) = S/ \(total)")
    }
}


// ==================================================
// MARK: - TODO 14: SUCURSAL LIMA
// ==================================================

class SucursalLima: Sucursal {

    // Descuento del 10%
    override func descuento() -> Double {
        return 0.10
    }

    // Envio gratis desde 1500 soles
    override func costoEnvio(monto: Double) -> Double {
        if monto >= 1500 {
            return 0.0
        }

        return 30.0
    }
}


// ==================================================
// MARK: - TODO 15: SUCURSAL PROVINCIA
// ==================================================

class SucursalProvincia: Sucursal {

    // Hereda el descuento base del 5%

    // Envio del 8% con un minimo de 50 soles
    override func costoEnvio(monto: Double) -> Double {
        let envio = monto * 0.08

        if envio < 50.0 {
            return 50.0
        }

        return envio
    }
}


// ==================================================
// MARK: - TODO 16: SUCURSAL OUTLET
// ==================================================

class SucursalOutlet: Sucursal {

    // Descuento del 25%
    override func descuento() -> Double {
        return 0.25
    }

    // Recojo en tienda, sin costo de envio
    override func costoEnvio(monto: Double) -> Double {
        return 0.0
    }
}


// ==================================================
// MARK: - TODO 18: SUCURSAL ONLINE
// ==================================================

class SucursalOnline: Sucursal {

    // Envio fijo de 15 soles
    override func costoEnvio(monto: Double) -> Double {
        return 15.0
    }
}


// ==================================================
// MARK: - TODO 17: RECORRIDO POLIMORFICO
// ==================================================

// Productos
let refrigeradora = Electrodomestico(
    nombre: "Refrigeradora",
    marca: "Frost",
    precioLista: 2000.0,
    categoria: .lineaBlanca
)

let licuadora = Electrodomestico(
    nombre: "Licuadora",
    marca: "Mix",
    precioLista: 250.0,
    categoria: .pequenos
)


// Todas las sucursales se manejan como tipo Sucursal
let sucursales: [Sucursal] = [
    SucursalLima(nombre: "Lima Centro", ciudad: "Lima"),
    SucursalProvincia(nombre: "Provincia Cusco", ciudad: "Cusco"),
    SucursalOutlet(nombre: "Outlet Ate", ciudad: "Lima"),
    SucursalOnline(nombre: "Tienda Online", ciudad: "Internet")
]


// Cotizacion de la refrigeradora
print("")
print("==================================================")
print("           COTIZACION DE REFRIGERADORA")
print("==================================================")

for sucursal in sucursales {
    sucursal.cotizar(item: refrigeradora)
}


// Cotizacion de la licuadora
print("")
print("==================================================")
print("             COTIZACION DE LICUADORA")
print("==================================================")

for sucursal in sucursales {
    sucursal.cotizar(item: licuadora)
}


// Para agregar SucursalOnline necesite 6 lineas nuevas:
// 5 para crear la clase y 1 para agregarla al array.


// ==================================================
// MARK: - FIX 7
// ==================================================

class SucursalMall: Sucursal {

    // Se usa override porque descuento() existe en Sucursal
    override func descuento() -> Double {
        return 0.12
    }
}


// ==================================================
// MARK: - FIX 8
// ==================================================

class SucursalExpress: Sucursal {
    let radioKm: Int

    init(nombre: String, ciudad: String, radioKm: Int) {
        self.radioKm = radioKm

        // Se inicializa la clase padre
        super.init(nombre: nombre, ciudad: ciudad)
    }
}


// ==================================================
// MARK: - PREDICT
// ==================================================

print("")
print("==================================================")
print("                 PRUEBAS PREDICT")
print("==================================================")


let misteriosa: Sucursal = SucursalLima(
    nombre: "Lima Centro",
    ciudad: "Lima"
)


// PREDICT 6
print("")
print("PREDICT 6")
print("Descuento aplicado: \(misteriosa.descuento())")


// Calculamos el monto con descuento
let monto = 2000.0 * (1 - misteriosa.descuento())


// PREDICT 7
print("")
print("PREDICT 7")
print("Monto con descuento: S/ \(monto)")
print("Costo de envio: S/ \(misteriosa.costoEnvio(monto: monto))")


print("")
print("==================================================")
print("                 FIN DE LA PRUEBA")
print("==================================================")
