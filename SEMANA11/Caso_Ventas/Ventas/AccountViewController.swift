import UIKit

final class AccountViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cuenta"
        view.backgroundColor = AppTheme.background
        navigationItem.largeTitleDisplayMode = .always
        configureLayout()
    }

    private func configureLayout() {
        let icon = UIImageView(image: UIImage(systemName: "person.crop.circle.fill"))
        icon.tintColor = AppTheme.primary
        icon.contentMode = .scaleAspectFit
        icon.heightAnchor.constraint(equalToConstant: 90).isActive = true

        let name = FormFactory.label(SessionManager.shared.currentUser?.nombre ?? "Usuario", style: .title2, weight: .bold)
        name.textAlignment = .center
        let username = FormFactory.label("@\(SessionManager.shared.currentUser?.usuario ?? "")", color: .secondaryLabel)
        username.textAlignment = .center
        let role = FormFactory.label(SessionManager.shared.currentUser?.rol ?? "", weight: .semibold, color: AppTheme.primary)
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
        let card = CardView(); card.translatesAutoresizingMaskIntoConstraints = false; card.addSubview(stack); view.addSubview(card)
        NSLayoutConstraint.activate([
            card.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            card.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20), card.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stack.topAnchor.constraint(equalTo: card.topAnchor, constant: 28), stack.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -24),
            stack.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 24), stack.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -24)
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
