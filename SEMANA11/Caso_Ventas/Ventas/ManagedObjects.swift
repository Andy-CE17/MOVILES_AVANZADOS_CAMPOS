import CoreData

@objc(Usuario)
final class Usuario: NSManagedObject {
    @NSManaged var nombre: String
    @NSManaged var usuario: String
    @NSManaged var clave: String
    @NSManaged var rol: String
    @NSManaged var ventas: Set<Venta>
}

@objc(Producto)
final class Producto: NSManagedObject {
    @NSManaged var nombre: String
    @NSManaged var categoria: String
    @NSManaged var precio: Double
    @NSManaged var stock: Int64
    @NSManaged var ventas: Set<Venta>
}

@objc(Cliente)
final class Cliente: NSManagedObject {
    @NSManaged var nombre: String
    @NSManaged var documento: String
    @NSManaged var ventas: Set<Venta>
}

@objc(Venta)
final class Venta: NSManagedObject {
    @NSManaged var fecha: Date
    @NSManaged var cantidad: Int64
    @NSManaged var precioUnitario: Double
    @NSManaged var descuento: Double
    @NSManaged var igv: Double
    @NSManaged var total: Double
    @NSManaged var anulada: Bool
    @NSManaged var motivoAnulacion: String?
    @NSManaged var vendedor: Usuario
    @NSManaged var producto: Producto
    @NSManaged var cliente: Cliente
}

extension Usuario {
    static func fetchRequest() -> NSFetchRequest<Usuario> {
        NSFetchRequest<Usuario>(entityName: "Usuario")
    }
}

extension Producto {
    static func fetchRequest() -> NSFetchRequest<Producto> {
        NSFetchRequest<Producto>(entityName: "Producto")
    }
}

extension Cliente {
    static func fetchRequest() -> NSFetchRequest<Cliente> {
        NSFetchRequest<Cliente>(entityName: "Cliente")
    }
}

extension Venta {
    static func fetchRequest() -> NSFetchRequest<Venta> {
        NSFetchRequest<Venta>(entityName: "Venta")
    }
}
