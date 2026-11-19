import Foundation
import FirebaseAuth
import FirebaseFirestore

final class DatabaseService {
    static let shared = DatabaseService()

    private let database = Firestore.firestore()
    private var listener: ListenerRegistration?

    private init() {}

    func sendMessage(_ text: String, completion: @escaping (Error?) -> Void) {
        guard let email = Auth.auth().currentUser?.email else {
            completion(NSError(
                domain: "DatabaseService",
                code: 401,
                userInfo: [NSLocalizedDescriptionKey: "No existe una sesión activa."]
            ))
            return
        }

        database.collection("messages").addDocument(data: [
            "text": text,
            "userEmail": email,
            "createdAt": FieldValue.serverTimestamp()
        ]) { error in
            completion(error)
        }
    }

    func observeMessages(_ completion: @escaping ([Message], Error?) -> Void) {
        listener?.remove()
        listener = database.collection("messages")
            .order(by: "createdAt", descending: false)
            .addSnapshotListener { snapshot, error in
                let messages = snapshot?.documents.compactMap(Message.init(document:)) ?? []
                completion(messages, error)
            }
    }

    func stopObservingMessages() {
        listener?.remove()
        listener = nil
    }
}
