import Foundation
import FirebaseFirestore

struct Message: Identifiable {
    let id: String
    let text: String
    let userEmail: String
    let createdAt: Date

    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let text = data["text"] as? String,
              let userEmail = data["userEmail"] as? String else {
            return nil
        }

        id = document.documentID
        self.text = text
        self.userEmail = userEmail
        createdAt = (data["createdAt"] as? Timestamp)?.dateValue() ?? .now
    }
}
