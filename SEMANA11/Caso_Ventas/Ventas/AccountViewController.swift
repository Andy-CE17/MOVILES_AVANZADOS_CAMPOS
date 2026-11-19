import UIKit

final class AccountViewController: UIViewController {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var roleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cuenta"
        view.backgroundColor = AppTheme.background
        navigationItem.largeTitleDisplayMode = .always
        nameLabel.text = SessionManager.shared.currentUser?.nombre ?? "Usuario"
        usernameLabel.text = "@\(SessionManager.shared.currentUser?.usuario ?? "")"
        roleLabel.text = SessionManager.shared.currentUser?.rol ?? ""
    }

    @IBAction private func confirmLogout() {
        let alert = UIAlertController(title: "Cerrar sesión", message: "¿Deseas volver al inicio de sesión?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        alert.addAction(UIAlertAction(title: "Cerrar sesión", style: .destructive) { [weak self] _ in self?.logout() })
        present(alert, animated: true)
    }

    private func logout() {
        SessionManager.shared.currentUser = nil
        guard let window = view.window else { return }
        UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve) {
            window.rootViewController = StoryboardRouter.initialViewController()
        }
    }
}
