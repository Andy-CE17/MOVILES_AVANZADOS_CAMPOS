import CoreData
import Foundation

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
