import SwiftUI
import FirebaseAuth

struct MessagesView: View {
    let onSignOut: () -> Void

    @State private var messages: [Message] = []
    @State private var newMessage = ""
    @State private var errorMessage = ""

    private var currentEmail: String {
        Auth.auth().currentUser?.email ?? "Usuario"
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack(spacing: 12) {
                    Image(systemName: "person.crop.circle.fill")
                        .font(.title2)
                        .foregroundStyle(.orange)
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Conectado como")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text(currentEmail)
                            .font(.subheadline.bold())
                            .lineLimit(1)
                            .minimumScaleFactor(0.75)
                    }
                    Spacer()
                }
                .padding()
                .background(.orange.opacity(0.08))

                if messages.isEmpty {
                    ContentUnavailableView(
                        "Aún no hay mensajes",
                        systemImage: "message",
                        description: Text("Escribe el primer mensaje en Firebase.")
                    )
                } else {
                    List(messages) { message in
                        VStack(alignment: .leading, spacing: 5) {
                            Text(message.text)
                                .font(.body)
                            HStack {
                                Text(message.userEmail)
                                Spacer()
                                Text(message.createdAt, style: .time)
                            }
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 4)
                    }
                    .listStyle(.plain)
                }

                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .font(.caption)
                        .foregroundStyle(.red)
                        .padding(.horizontal)
                }

                HStack(spacing: 12) {
                    TextField("Escribe un mensaje", text: $newMessage)
                        .textFieldStyle(.roundedBorder)
                        .submitLabel(.send)
                        .onSubmit(sendMessage)

                    Button(action: sendMessage) {
                        Image(systemName: "paperplane.fill")
                            .font(.title3)
                    }
                    .disabled(newMessage.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                .padding()
                .background(.bar)
            }
            .navigationTitle("Mensajes")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Salir", role: .destructive, action: onSignOut)
                }
            }
        }
        .onAppear {
            DatabaseService.shared.observeMessages { messages, error in
                self.messages = messages
                errorMessage = error?.localizedDescription ?? ""
            }
        }
        .onDisappear {
            DatabaseService.shared.stopObservingMessages()
        }
    }

    private func sendMessage() {
        let text = newMessage.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else { return }

        DatabaseService.shared.sendMessage(text) { error in
            if let error {
                errorMessage = error.localizedDescription
            } else {
                newMessage = ""
                errorMessage = ""
            }
        }
    }
}
