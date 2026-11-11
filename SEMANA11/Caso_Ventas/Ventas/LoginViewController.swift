import UIKit

final class LoginViewController: UIViewController {
    private let authService = AuthService()
    private let usernameField = FormFactory.textField(placeholder: "Usuario", icon: "person")
    private let passwordField = FormFactory.textField(placeholder: "Contraseña", icon: "lock", secure: true)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Iniciar sesión"
        view.backgroundColor = .systemGroupedBackground
        configureLayout()
    }

    private func configureLayout() {
        let icon = UIImageView(image: UIImage(systemName: "cart.fill"))
        icon.tintColor = .systemGreen
        icon.contentMode = .scaleAspectFit
        icon.heightAnchor.constraint(equalToConstant: 72).isActive = true
        let titleLabel = FormFactory.label("Ventas", style: .largeTitle, weight: .bold)
        titleLabel.textAlignment = .center
        let subtitle = FormFactory.label("Control de ventas e inventario", color: .secondaryLabel)
        subtitle.textAlignment = .center
        let loginButton = FormFactory.primaryButton(title: "Ingresar", action: UIAction { [weak self] _ in self?.login() })
        let registerButton = UIButton(type: .system)
        registerButton.setTitle("Crear una cuenta", for: .normal)
        registerButton.addAction(UIAction { [weak self] _ in self?.showRegister() }, for: .touchUpInside)

        let stack = UIStackView(arrangedSubviews: [icon, titleLabel, subtitle, usernameField, passwordField, loginButton, registerButton])
        stack.axis = .vertical
        stack.spacing = 14
        stack.setCustomSpacing(30, after: subtitle)
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 28),
            stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -28),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -25)
        ])
    }

    private func login() {
        do {
            let user = try authService.login(username: usernameField.text ?? "", password: passwordField.text ?? "")
            SessionManager.shared.currentUser = user
            presentMain()
        } catch {
            presentAlert(title: "No se pudo ingresar", message: error.localizedDescription)
        }
    }

    private func showRegister() {
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }

    private func presentMain() {
        guard let window = view.window else { return }
        UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve) {
            window.rootViewController = MainTabBarController()
        }
    }
}
