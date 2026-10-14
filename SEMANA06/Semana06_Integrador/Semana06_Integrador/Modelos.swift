import Foundation

class Producto {
    let nombre: String
    let precio: Double
    var stock: Int

    init(nombre: String, precio: Double, stock: Int) {
        self.nombre = nombre
        self.precio = precio
        self.stock = stock
    }
}

class ItemCarrito {
    let producto: Producto
    var cantidad: Int

    init(producto: Producto, cantidad: Int) {
        self.producto = producto
        self.cantidad = cantidad
    }

    func subtotal() -> Double {
        producto.precio * Double(cantidad)
    }
}

class CarritoModel {
    private(set) var items: [ItemCarrito] = []

    func agregar(producto: Producto, cantidad: Int) -> Bool {
        guard cantidad > 0 else { return false }

        if let itemExistente = items.first(where: { $0.producto === producto }) {
            guard itemExistente.cantidad + cantidad <= producto.stock else {
                return false
            }
            itemExistente.cantidad += cantidad
        } else {
            guard cantidad <= producto.stock else { return false }
            items.append(ItemCarrito(producto: producto, cantidad: cantidad))
        }

        return true
    }

    func subtotal() -> Double {
        items.reduce(0) { $0 + $1.subtotal() }
    }

    func porcentajeDescuento() -> Double {
        let subtotalCompra = subtotal()

        if subtotalCompra >= 5000 {
            return 0.15
        } else if subtotalCompra >= 2000 {
            return 0.10
        } else if subtotalCompra >= 500 {
            return 0.05
        }

        return 0.0
    }

    func montoDescuento() -> Double {
        subtotal() * porcentajeDescuento()
    }

    func montoConDescuento() -> Double {
        subtotal() - montoDescuento()
    }

    func igv() -> Double {
        montoConDescuento() * 0.18
    }

    func total() -> Double {
        montoConDescuento() + igv()
    }

    func cantidadTotal() -> Int {
        items.reduce(0) { $0 + $1.cantidad }
    }

    func categoriaCliente() -> String {
        switch Int(subtotal()) {
        case ..<500:
            return "Regular"
        case 500..<2000:
            return "Frecuente"
        case 2000..<5000:
            return "VIP"
        default:
            return "Premium"
        }
    }

    func confirmarCompra() {
        for item in items {
            item.producto.stock -= item.cantidad
        }
        vaciar()
    }

    func vaciar() {
        items.removeAll()
    }
}

class ClienteModel {
    let apellidos: String
    let nombres: String
    let dni: String

    init(apellidos: String, nombres: String, dni: String) {
        self.apellidos = apellidos
        self.nombres = nombres
        self.dni = dni
    }

    var nombreCompleto: String {
        "\(nombres) \(apellidos)"
    }
}

