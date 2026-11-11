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
        view.backgroundColor = AppTheme.background
        roleControl.selectedSegmentIndex = 0
        roleControl.selectedSegmentTintColor = AppTheme.primary
        roleControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        let headerIcon = UIImageView(image: UIImage(systemName: "person.crop.circle.badge.plus"))
        headerIcon.tintColor = AppTheme.primary
        headerIcon.contentMode = .scaleAspectFit
        headerIcon.heightAnchor.constraint(equalToConstant: 58).isActive = true
        let intro = FormFactory.label("Completa tus datos", style: .title2, weight: .bold)
        intro.textAlignment = .center
        let detail = FormFactory.label("Elige el rol con el que usarás la aplicación", style: .subheadline, color: .secondaryLabel)
        detail.textAlignment = .center
        let roleLabel = FormFactory.label("Rol", weight: .semibold)
        let registerButton = FormFactory.primaryButton(title: "Registrar", action: UIAction { [weak self] _ in self?.register() })
        let stack = UIStackView(arrangedSubviews: [headerIcon, intro, detail, nameField, usernameField, passwordField, confirmationField, roleLabel, roleControl, registerButton])
        stack.axis = .vertical
        stack.spacing = 14
        stack.setCustomSpacing(6, after: intro)
        stack.setCustomSpacing(24, after: detail)
        stack.translatesAutoresizingMaskIntoConstraints = false
        let card = CardView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(stack)
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.keyboardDismissMode = .interactive
        view.addSubview(scroll)
        scroll.addSubview(card)
        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor), scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            card.topAnchor.constraint(equalTo: scroll.contentLayoutGuide.topAnchor, constant: 20),
            card.bottomAnchor.constraint(equalTo: scroll.contentLayoutGuide.bottomAnchor, constant: -28),
            card.leadingAnchor.constraint(equalTo: scroll.frameLayoutGuide.leadingAnchor, constant: 20),
            card.trailingAnchor.constraint(equalTo: scroll.frameLayoutGuide.trailingAnchor, constant: -20),
            stack.topAnchor.constraint(equalTo: card.topAnchor, constant: 24),
            stack.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -24),
            stack.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -20)
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
