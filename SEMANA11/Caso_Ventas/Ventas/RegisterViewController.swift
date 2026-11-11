import UIKit

final class RegisterViewController: UIViewController {
    private let authService = AuthService()
    private let nameField = FormFactory.textField(placeholder: "Nombre completo", icon: "person.text.rectangle")
    private let usernameField = FormFactory.textField(placeholder: "Usuario", icon: "at")
    private let passwordField = FormFactory.textField(placeholder: "Contraseña (mínimo 6 caracteres)", icon: "lock", secure: true)
    private let confirmationField = FormFactory.textField(placeholder: "Confirmar contraseña", icon: "lock.rotation", secure: true)
    private let roleControl = UISegmentedControl(items: ["Vendedor", "Supervisor"])

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Crear cuenta"
        view.backgroundColor = .systemGroupedBackground
        roleControl.selectedSegmentIndex = 0
        let roleLabel = FormFactory.label("Rol", weight: .semibold)
        let registerButton = FormFactory.primaryButton(title: "Registrar", action: UIAction { [weak self] _ in self?.register() })
        let stack = UIStackView(arrangedSubviews: [nameField, usernameField, passwordField, confirmationField, roleLabel, roleControl, registerButton])
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24)
        ])
    }

    private func register() {
        do {
            let user = try authService.register(
                name: nameField.text ?? "", username: usernameField.text ?? "",
                password: passwordField.text ?? "", confirmation: confirmationField.text ?? "",
                role: roleControl.selectedSegmentIndex == 0 ? "Vendedor" : "Supervisor"
            )
            SessionManager.shared.currentUser = user
            guard let window = view.window else { return }
            UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve) {
                window.rootViewController = MainTabBarController()
            }
        } catch {
            presentAlert(title: "No se pudo registrar", message: error.localizedDescription)
        }
    }
}
