import SwiftUI
import FirebaseAuth

struct AuthView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @State private var isRegistering = false
    @State private var isLoading = false
    @State private var currentUser: User?

    var body: some View {
        Group {
            if currentUser != nil {
                MessagesView(onSignOut: signOut)
            } else {
                authenticationForm
            }
        }
        .onAppear {
            currentUser = Auth.auth().currentUser
        }
    }

    private var authenticationForm: some View {
        NavigationStack {
            VStack(spacing: 22) {
                Spacer()

                Image(systemName: "flame.fill")
                    .font(.system(size: 64))
                    .foregroundStyle(.orange)

                VStack(spacing: 6) {
                    Text("Firebase Auth")
                        .font(.largeTitle.bold())
                    Text(isRegistering ? "Crea una cuenta para continuar" : "Ingresa con tu correo y contraseña")
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }

                VStack(spacing: 14) {
                    TextField("Correo electrónico", text: $email)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                        .submitLabel(.next)
                        .padding()
                        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 14))

                    SecureField("Contraseña", text: $password)
                        .textContentType(isRegistering ? .newPassword : .password)
                        .submitLabel(.done)
                        .padding()
                        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 14))
                }

                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .font(.footnote)
                        .foregroundStyle(.red)
                        .multilineTextAlignment(.center)
                }

                Button(action: authenticate) {
                    HStack {
                        if isLoading {
                            ProgressView().tint(.white)
                        }
                        Text(isRegistering ? "Registrarme" : "Iniciar sesión")
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundStyle(.white)
                    .background(.orange, in: RoundedRectangle(cornerRadius: 14))
                }
                .disabled(isLoading || email.isEmpty || password.count < 6)

                Button(isRegistering ? "Ya tengo una cuenta" : "Crear una cuenta") {
                    isRegistering.toggle()
                    errorMessage = ""
                }
                .fontWeight(.medium)

                Spacer()
            }
            .padding(28)
            .navigationTitle(isRegistering ? "Registro" : "Acceso")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func authenticate() {
        errorMessage = ""
        isLoading = true

        let completion: (AuthDataResult?, Error?) -> Void = { result, error in
            isLoading = false
            if let error {
                errorMessage = error.localizedDescription
                return
            }
            currentUser = result?.user
        }

        if isRegistering {
            Auth.auth().createUser(withEmail: email, password: password, completion: completion)
        } else {
            Auth.auth().signIn(withEmail: email, password: password, completion: completion)
        }
    }

    private func signOut() {
        do {
            try Auth.auth().signOut()
            currentUser = nil
            password = ""
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
