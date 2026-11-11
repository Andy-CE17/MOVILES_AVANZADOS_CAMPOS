import UIKit

final class AccountViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cuenta"
        view.backgroundColor = .systemGroupedBackground
        configureLayout()
    }

    private func configureLayout() {
        let icon = UIImageView(image: UIImage(systemName: "person.crop.circle.fill"))
        icon.tintColor = .systemGreen
        icon.contentMode = .scaleAspectFit
        icon.heightAnchor.constraint(equalToConstant: 90).isActive = true

        let name = FormFactory.label(SessionManager.shared.currentUser?.nombre ?? "Usuario", style: .title2, weight: .bold)
        name.textAlignment = .center
        let username = FormFactory.label("@\(SessionManager.shared.currentUser?.usuario ?? "")", color: .secondaryLabel)
        username.textAlignment = .center
        let role = FormFactory.label(SessionManager.shared.currentUser?.rol ?? "", weight: .semibold, color: .systemGreen)
        role.textAlignment = .center

        var configuration = UIButton.Configuration.tinted()
        configuration.title = "Cerrar sesión"
        configuration.image = UIImage(systemName: "rectangle.portrait.and.arrow.right")
        configuration.imagePadding = 8
        configuration.baseForegroundColor = .systemRed
        let logout = UIButton(configuration: configuration, primaryAction: UIAction { [weak self] _ in self?.confirmLogout() })
        logout.heightAnchor.constraint(equalToConstant: 48).isActive = true

        let stack = UIStackView(arrangedSubviews: [icon, name, username, role, logout])
        stack.axis = .vertical
        stack.spacing = 12
        stack.setCustomSpacing(30, after: role)
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28)
        ])
    }

    private func confirmLogout() {
        let alert = UIAlertController(title: "Cerrar sesión", message: "¿Deseas volver al inicio de sesión?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        alert.addAction(UIAlertAction(title: "Cerrar sesión", style: .destructive) { [weak self] _ in self?.logout() })
        present(alert, animated: true)
    }

    private func logout() {
        SessionManager.shared.currentUser = nil
        guard let window = view.window else { return }
        UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve) {
            window.rootViewController = UINavigationController(rootViewController: LoginViewController())
        }
    }
}
