import CoreData
import Foundation

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
