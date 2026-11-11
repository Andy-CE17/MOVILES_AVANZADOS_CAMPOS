import CoreData
import Foundation

enum SaleError: LocalizedError {
    case missingSelection, invalidQuantity, insufficientStock, noSession

    var errorDescription: String? {
        switch self {
        case .missingSelection: return "Selecciona un producto y un cliente."
        case .invalidQuantity: return "La cantidad debe ser mayor que cero."
        case .insufficientStock: return "No existe stock suficiente para completar la venta."
        case .noSession: return "La sesión actual no es válida."
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
}

extension Double {
    var soles: String { formatted(.currency(code: "PEN")) }
}

extension Date {
    var saleDateText: String { formatted(date: .abbreviated, time: .shortened) }
}
