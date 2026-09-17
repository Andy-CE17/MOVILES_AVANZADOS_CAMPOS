// Desarrollado por: Andy Luis Campos Escandon
// ACTIVIDAD PROPUESTA 02 - HERENCIA DE CLIENTES
// Docente: Juan Leon

import Foundation

// Clase padre Cliente
class Cliente {
    var codigo: String
    var direccion: String
    var fechaDeRegistro: String
    var numeroCuenta: String
    var montoMinimoApertura: Double

    // Constructor de Cliente
    init(
        codigo: String,
        direccion: String,
        fechaDeRegistro: String,
        numeroCuenta: String,
        montoMinimoApertura: Double
    ) {
        self.codigo = codigo
        self.direccion = direccion
        self.fechaDeRegistro = fechaDeRegistro
        self.numeroCuenta = numeroCuenta
        self.montoMinimoApertura = montoMinimoApertura
    }

    // Metodo para mostrar los datos comunes
    func mostrarDatos() {
        print("Código: \(codigo)")
        print("Dirección: \(direccion)")
        print("Fecha de registro: \(fechaDeRegistro)")
        print("N° Cuenta: \(numeroCuenta)")
        print("Monto mínimo de apertura: S/ \(montoMinimoApertura)")
    }
}


// Clase ClienteNatural hereda de Cliente
class ClienteNatural: Cliente {
    var nombreCompleto: String
    var dni: String

    // Constructor
    init(
        nombreCompleto: String,
        dni: String,
        codigo: String,
        direccion: String,
        fechaDeRegistro: String,
        numeroCuenta: String,
        montoMinimoApertura: Double
    ) {
        self.nombreCompleto = nombreCompleto
        self.dni = dni

        // Enviamos los datos a la clase padre
        super.init(
            codigo: codigo,
            direccion: direccion,
            fechaDeRegistro: fechaDeRegistro,
            numeroCuenta: numeroCuenta,
            montoMinimoApertura: montoMinimoApertura
        )
    }

    // Sobrescribimos el metodo mostrarDatos
    override func mostrarDatos() {
        print("===== CLIENTE NATURAL =====")
        print("Nombre: \(nombreCompleto)")
        print("DNI: \(dni)")

        // Mostramos los datos heredados
        super.mostrarDatos()
    }
}


// Clase ClienteJuridico hereda de Cliente
class ClienteJuridico: Cliente {
    var razonSocial: String
    var ruc: String
    var representanteLegal: String

    // Constructor
    init(
        razonSocial: String,
        ruc: String,
        representanteLegal: String,
        codigo: String,
        direccion: String,
        fechaDeRegistro: String,
        numeroCuenta: String,
        montoMinimoApertura: Double
    ) {
        self.razonSocial = razonSocial
        self.ruc = ruc
        self.representanteLegal = representanteLegal

        // Enviamos los datos a la clase padre
        super.init(
            codigo: codigo,
            direccion: direccion,
            fechaDeRegistro: fechaDeRegistro,
            numeroCuenta: numeroCuenta,
            montoMinimoApertura: montoMinimoApertura
        )
    }

    // Sobrescribimos el metodo mostrarDatos
    override func mostrarDatos() {
        print("===== CLIENTE JURIDICO =====")
        print("Razón Social: \(razonSocial)")
        print("RUC: \(ruc)")
        print("Representante Legal: \(representanteLegal)")

        // Mostramos los datos heredados
        super.mostrarDatos()
    }
}


// Creamos un cliente natural
let clienteNatural = ClienteNatural(
    nombreCompleto: "Andy Campos",
    dni: "12345678",
    codigo: "C001",
    direccion: "Av. Lima 123",
    fechaDeRegistro: "2025-04-03",
    numeroCuenta: "001-2025-000123",
    montoMinimoApertura: 500.00
)


// Creamos un cliente juridico
let clienteJuridico = ClienteJuridico(
    razonSocial: "Soluciones SAC",
    ruc: "20123456789",
    representanteLegal: "María León",
    codigo: "C002",
    direccion: "Jr. Empresas 456",
    fechaDeRegistro: "2025-05-01",
    numeroCuenta: "001-2025-000456",
    montoMinimoApertura: 3000.00
)


// Mostramos los datos
clienteNatural.mostrarDatos()

print()

clienteJuridico.mostrarDatos()
