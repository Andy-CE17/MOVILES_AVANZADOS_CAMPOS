import Foundation
import CoreData


enum AuthError: LocalizedError {
    case incompleteData, shortPassword, passwordsDoNotMatch, duplicateUsername, invalidCredentials

    var errorDescription: String? {
        switch self {
        case .incompleteData: return "Completa todos los campos."
        case .shortPassword: return "La contraseña debe tener al menos 6 caracteres."
        case .passwordsDoNotMatch: return "Las contraseñas no coinciden."
        case .duplicateUsername: return "El nombre de usuario ya está registrado."
        case .invalidCredentials: return "Usuario o contraseña incorrectos."
        }
    }
}

final class AuthService {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.context = context
    }

    func register(name: String, username: String, password: String, confirmation: String, role: String) throws -> Usuario {
        let cleanName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanUsername = username.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !cleanName.isEmpty, !cleanUsername.isEmpty, !password.isEmpty else { throw AuthError.incompleteData }
        guard password.count >= 6 else { throw AuthError.shortPassword }
        guard password == confirmation else { throw AuthError.passwordsDoNotMatch }

        let request = Usuario.fetchRequest()
        request.fetchLimit = 1
        request.predicate = NSPredicate(format: "usuario ==[c] %@", cleanUsername)
        guard try context.count(for: request) == 0 else { throw AuthError.duplicateUsername }

        let user = Usuario(context: context)
        user.nombre = cleanName
        user.usuario = cleanUsername
        user.clave = password
        user.rol = role
        try context.save()
        return user
    }

    func login(username: String, password: String) throws -> Usuario {
        let cleanUsername = username.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !cleanUsername.isEmpty, !password.isEmpty else { throw AuthError.invalidCredentials }
        let request = Usuario.fetchRequest()
        request.fetchLimit = 1
        request.predicate = NSPredicate(format: "usuario ==[c] %@ AND clave == %@", cleanUsername, password)
        guard let user = try context.fetch(request).first else { throw AuthError.invalidCredentials }
        return user
    }
}


enum CatalogError: LocalizedError {
    case incompleteData, invalidPrice, invalidStock, duplicateDocument, relatedSales

    var errorDescription: String? {
        switch self {
        case .incompleteData: return "Completa todos los campos."
        case .invalidPrice: return "El precio debe ser mayor que cero."
        case .invalidStock: return "El stock no puede ser negativo."
        case .duplicateDocument: return "Ya existe un cliente con ese documento."
        case .relatedSales: return "No se puede eliminar porque tiene ventas relacionadas."
        }
    }
}

final class CatalogService {
    let context = PersistenceController.shared.container.viewContext

    func products(search: String = "") throws -> [Producto] {
        let request = Producto.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "nombre", ascending: true)]
        if !search.isEmpty {
            request.predicate = NSPredicate(format: "nombre CONTAINS[cd] %@ OR categoria CONTAINS[cd] %@", search, search)
        }
        return try context.fetch(request)
    }

    func saveProduct(_ product: Producto?, name: String, category: String, priceText: String, stockText: String) throws {
        let cleanName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanCategory = category.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !cleanName.isEmpty, !cleanCategory.isEmpty else { throw CatalogError.incompleteData }
        guard let price = Double(priceText.replacingOccurrences(of: ",", with: ".")), price > 0 else { throw CatalogError.invalidPrice }
        guard let stock = Int64(stockText), stock >= 0 else { throw CatalogError.invalidStock }
        let item = product ?? Producto(context: context)
        item.nombre = cleanName
        item.categoria = cleanCategory
        item.precio = price
        item.stock = stock
        try context.save()
    }

    func clients(search: String = "") throws -> [Cliente] {
        let request = Cliente.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "nombre", ascending: true)]
        if !search.isEmpty {
            request.predicate = NSPredicate(format: "nombre CONTAINS[cd] %@ OR documento CONTAINS[cd] %@", search, search)
        }
        return try context.fetch(request)
    }

    func saveClient(_ client: Cliente?, name: String, document: String) throws {
        let cleanName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanDocument = document.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !cleanName.isEmpty, !cleanDocument.isEmpty else { throw CatalogError.incompleteData }
        let request = Cliente.fetchRequest()
        request.fetchLimit = 1
        request.predicate = NSPredicate(format: "documento ==[c] %@", cleanDocument)
        if let existing = try context.fetch(request).first, existing != client { throw CatalogError.duplicateDocument }
        let item = client ?? Cliente(context: context)
        item.nombre = cleanName
        item.documento = cleanDocument
        try context.save()
    }

    func delete(_ object: NSManagedObject) throws {
        if let product = object as? Producto, !product.ventas.isEmpty { throw CatalogError.relatedSales }
        if let client = object as? Cliente, !client.ventas.isEmpty { throw CatalogError.relatedSales }
        context.delete(object)
        try context.save()
    }

    func validTotal(for client: Cliente) -> Double {
        client.ventas.filter { !$0.anulada }.reduce(0) { $0 + $1.total }
    }

    func category(for client: Cliente) -> String {
        let total = validTotal(for: client)
        if total >= 2_000 { return "VIP" }
        if total >= 500 { return "Frecuente" }
        return "Regular"
    }
}


enum SaleError: LocalizedError {
    case missingSelection, invalidQuantity, insufficientStock, noSession, missingCancellationReason, alreadyCancelled

    var errorDescription: String? {
        switch self {
        case .missingSelection: return "Selecciona un producto y un cliente."
        case .invalidQuantity: return "La cantidad debe ser mayor que cero."
        case .insufficientStock: return "No existe stock suficiente para completar la venta."
        case .noSession: return "La sesión actual no es válida."
        case .missingCancellationReason: return "Es obligatorio indicar el motivo de la anulación."
        case .alreadyCancelled: return "Esta venta ya se encuentra anulada."
        }
    }
}

struct SaleCalculation {
    let subtotal: Double
    let discount: Double
    let taxableAmount: Double
    let igv: Double
    let total: Double
}

final class SaleService {
    let context = PersistenceController.shared.container.viewContext
    private let catalog = CatalogService()

    func calculate(product: Producto, client: Cliente, quantity: Int64) -> SaleCalculation {
        let subtotal = product.precio * Double(quantity)
        let discount = catalog.category(for: client) == "VIP" ? subtotal * 0.10 : 0
        let taxableAmount = subtotal - discount
        let igv = taxableAmount * 0.18
        return SaleCalculation(subtotal: subtotal, discount: discount, taxableAmount: taxableAmount, igv: igv, total: taxableAmount + igv)
    }

    @discardableResult
    func register(product: Producto?, client: Cliente?, quantity: Int64) throws -> Venta {
        guard let product, let client else { throw SaleError.missingSelection }
        guard quantity > 0 else { throw SaleError.invalidQuantity }
        guard product.stock >= quantity else { throw SaleError.insufficientStock }
        guard let seller = SessionManager.shared.currentUser else { throw SaleError.noSession }
        let calculation = calculate(product: product, client: client, quantity: quantity)
        let sale = Venta(context: context)
        sale.fecha = Date()
        sale.cantidad = quantity
        sale.precioUnitario = product.precio
        sale.descuento = calculation.discount
        sale.igv = calculation.igv
        sale.total = calculation.total
        sale.anulada = false
        sale.vendedor = seller
        sale.producto = product
        sale.cliente = client
        product.stock -= quantity
        try context.save()
        return sale
    }

    func sales(for seller: Usuario? = nil, includeCancelled: Bool = true) throws -> [Venta] {
        let request = Venta.fetchRequest()
        var predicates: [NSPredicate] = []
        if let seller { predicates.append(NSPredicate(format: "vendedor == %@", seller)) }
        if !includeCancelled { predicates.append(NSPredicate(format: "anulada == NO")) }
        if !predicates.isEmpty { request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates) }
        request.sortDescriptors = [NSSortDescriptor(key: "fecha", ascending: false)]
        return try context.fetch(request)
    }

    func cancel(_ sale: Venta, reason: String) throws {
        let cleanReason = reason.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !sale.anulada else { throw SaleError.alreadyCancelled }
        guard !cleanReason.isEmpty else { throw SaleError.missingCancellationReason }
        sale.anulada = true
        sale.motivoAnulacion = cleanReason
        sale.producto.stock += sale.cantidad
        try context.save()
    }
}

extension Double {
    var soles: String { formatted(.currency(code: "PEN")) }
}

extension Date {
    var saleDateText: String { formatted(date: .abbreviated, time: .shortened) }
}
