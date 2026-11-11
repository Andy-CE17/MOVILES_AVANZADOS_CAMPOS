import UIKit

final class LoginViewController: UIViewController, UITextFieldDelegate {
    private let authService = AuthService()
    private let usernameField = FormFactory.textField(placeholder: "Usuario", icon: "person")
    private let passwordField = FormFactory.textField(placeholder: "Contraseña", icon: "lock", secure: true)
    private var contentCenterConstraint: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonDisplayMode = .minimal
        navigationController?.navigationBar.standardAppearance.configureWithTransparentBackground()
        navigationController?.navigationBar.scrollEdgeAppearance?.configureWithTransparentBackground()
        configureKeyboard()
        configureLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .black
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.barStyle = .default
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private func configureKeyboard() {
        usernameField.delegate = self
        passwordField.delegate = self
        usernameField.returnKeyType = .next
        passwordField.returnKeyType = .done
        usernameField.textContentType = .username
        passwordField.textContentType = .password

        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.items = [
            UIBarButtonItem(title: "Siguiente", style: .plain, target: self, action: #selector(focusPassword)),
            UIBarButtonItem(systemItem: .flexibleSpace),
            UIBarButtonItem(title: "Listo", style: .done, target: self, action: #selector(dismissKeyboard))
        ]
        usernameField.inputAccessoryView = toolbar
        passwordField.inputAccessoryView = toolbar

        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func configureLayout() {
        let background = BrandBackgroundView()
        background.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(background)

        let icon = UIImageView(image: UIImage(systemName: "cart.fill"))
        icon.tintColor = .white
        icon.contentMode = .scaleAspectFit
        icon.heightAnchor.constraint(equalToConstant: 58).isActive = true
        let iconCircle = UIView()
        iconCircle.backgroundColor = UIColor.white.withAlphaComponent(0.16)
        iconCircle.layer.cornerRadius = 42
        iconCircle.translatesAutoresizingMaskIntoConstraints = false
        icon.translatesAutoresizingMaskIntoConstraints = false
        iconCircle.addSubview(icon)
        NSLayoutConstraint.activate([
            iconCircle.widthAnchor.constraint(equalToConstant: 84), iconCircle.heightAnchor.constraint(equalToConstant: 84),
            icon.centerXAnchor.constraint(equalTo: iconCircle.centerXAnchor), icon.centerYAnchor.constraint(equalTo: iconCircle.centerYAnchor),
            icon.widthAnchor.constraint(equalToConstant: 52)
        ])

        let titleLabel = FormFactory.label("Ventas", style: .largeTitle, weight: .bold, color: .white)
        titleLabel.textAlignment = .center
        let subtitle = FormFactory.label("Control de ventas e inventario", color: UIColor.white.withAlphaComponent(0.82))
        subtitle.textAlignment = .center
        let welcome = FormFactory.label("Bienvenido", style: .title2, weight: .bold)
        let instruction = FormFactory.label("Ingresa tus credenciales para continuar", style: .subheadline, color: .secondaryLabel)
        let loginButton = FormFactory.primaryButton(title: "Ingresar", action: UIAction { [weak self] _ in self?.login() })
        let registerButton = UIButton(type: .system)
        registerButton.setTitle("Crear una cuenta", for: .normal)
        registerButton.setTitleColor(AppTheme.primary, for: .normal)
        registerButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        registerButton.addAction(UIAction { [weak self] _ in self?.showRegister() }, for: .touchUpInside)

        let brandStack = UIStackView(arrangedSubviews: [iconCircle, titleLabel, subtitle])
        brandStack.axis = .vertical; brandStack.alignment = .center; brandStack.spacing = 10

        let formStack = UIStackView(arrangedSubviews: [welcome, instruction, usernameField, passwordField, loginButton, registerButton])
        formStack.axis = .vertical; formStack.spacing = 14
        formStack.setCustomSpacing(6, after: welcome)
        formStack.setCustomSpacing(24, after: instruction)
        formStack.translatesAutoresizingMaskIntoConstraints = false
        let card = CardView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(formStack)

        let stack = UIStackView(arrangedSubviews: [brandStack, card])
        stack.axis = .vertical; stack.spacing = 30; stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        let centerConstraint = stack.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        contentCenterConstraint = centerConstraint
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.topAnchor), background.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor), background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 22),
            stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -22),
            centerConstraint,
            formStack.topAnchor.constraint(equalTo: card.topAnchor, constant: 24),
            formStack.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -20),
            formStack.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 20),
            formStack.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -20)
        ])
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField === usernameField {
            passwordField.becomeFirstResponder()
        } else {
            dismissKeyboard()
            login()
        }
        return true
    }

    @objc private func focusPassword() {
        passwordField.becomeFirstResponder()
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let overlap = max(0, view.bounds.maxY - frame.minY)
        contentCenterConstraint?.constant = -min(170, overlap * 0.42)
        animateKeyboardChange(notification)
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        contentCenterConstraint?.constant = 0
        animateKeyboardChange(notification)
    }

    private func animateKeyboardChange(_ notification: Notification) {
        let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0.25
        UIView.animate(withDuration: duration) { self.view.layoutIfNeeded() }
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
