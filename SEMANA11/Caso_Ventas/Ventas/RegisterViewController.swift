import UIKit

final class RegisterViewController: UIViewController, UITextFieldDelegate {
    private let authService = AuthService()
    private let nameField = FormFactory.textField(placeholder: "Nombre completo", icon: "person.text.rectangle")
    private let usernameField = FormFactory.textField(placeholder: "Usuario", icon: "at")
    private let passwordField = FormFactory.textField(placeholder: "Contraseña (mínimo 6 caracteres)", icon: "lock", secure: true)
    private let confirmationField = FormFactory.textField(placeholder: "Confirmar contraseña", icon: "lock.rotation", secure: true)
    private let roleControl = UISegmentedControl(items: ["Vendedor", "Supervisor"])
    private let scrollView = UIScrollView()
    private var fields: [UITextField] { [nameField, usernameField, passwordField, confirmationField] }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Crear cuenta"
        view.backgroundColor = AppTheme.background
        roleControl.selectedSegmentIndex = 0
        configureKeyboard()
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
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.keyboardDismissMode = .interactive
        view.addSubview(scrollView)
        scrollView.addSubview(card)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor), scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            card.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 20),
            card.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -28),
            card.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 20),
            card.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -20),
            stack.topAnchor.constraint(equalTo: card.topAnchor, constant: 24),
            stack.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -24),
            stack.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -20)
        ])
    }

    deinit { NotificationCenter.default.removeObserver(self) }

    private func configureKeyboard() {
        for (index, field) in fields.enumerated() {
            field.delegate = self
            field.tag = index
            field.returnKeyType = index == fields.count - 1 ? .done : .next
            let toolbar = UIToolbar(); toolbar.sizeToFit()
            toolbar.items = [
                UIBarButtonItem(title: "Siguiente", style: .plain, target: self, action: #selector(nextField)),
                UIBarButtonItem(systemItem: .flexibleSpace),
                UIBarButtonItem(title: "Listo", style: .done, target: self, action: #selector(dismissKeyboard))
            ]
            field.inputAccessoryView = toolbar
        }
        nameField.textContentType = .name
        usernameField.textContentType = .username
        passwordField.textContentType = .newPassword
        confirmationField.textContentType = .newPassword
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)); tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag < fields.count - 1 { fields[textField.tag + 1].becomeFirstResponder() }
        else { dismissKeyboard() }
        return true
    }

    @objc private func nextField() {
        guard let index = fields.firstIndex(where: { $0.isFirstResponder }) else { return }
        if index < fields.count - 1 { fields[index + 1].becomeFirstResponder() }
        else { dismissKeyboard() }
    }

    @objc private func dismissKeyboard() { view.endEditing(true) }

    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let inset = max(0, view.bounds.maxY - frame.minY)
        scrollView.contentInset.bottom = inset
        scrollView.verticalScrollIndicatorInsets.bottom = inset
        if let field = fields.first(where: { $0.isFirstResponder }) {
            scrollView.scrollRectToVisible(field.convert(field.bounds, to: scrollView).insetBy(dx: 0, dy: -30), animated: true)
        }
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        scrollView.contentInset.bottom = 0
        scrollView.verticalScrollIndicatorInsets.bottom = 0
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
