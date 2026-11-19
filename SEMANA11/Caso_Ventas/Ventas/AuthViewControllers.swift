import UIKit


final class LoginViewController: UIViewController, UITextFieldDelegate {
    private let authService = AuthService()
    @IBOutlet private weak var usernameField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    @IBOutlet private weak var contentCenterConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonDisplayMode = .minimal
        navigationController?.navigationBar.standardAppearance.configureWithTransparentBackground()
        navigationController?.navigationBar.scrollEdgeAppearance?.configureWithTransparentBackground()
        configureKeyboard()
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

    @IBAction private func login() {
        do {
            let user = try authService.login(username: usernameField.text ?? "", password: passwordField.text ?? "")
            SessionManager.shared.currentUser = user
            presentMain(user)
        } catch {
            presentAlert(title: "No se pudo ingresar", message: error.localizedDescription)
        }
    }

    @IBAction private func showRegister() {
        performSegue(withIdentifier: "showRegister", sender: self)
    }

    private func presentMain(_ user: Usuario) {
        guard let window = view.window else { return }
        UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve) {
            window.rootViewController = StoryboardRouter.mainViewController(for: user)
        }
    }
}


final class RegisterViewController: UIViewController, UITextFieldDelegate {
    private let authService = AuthService()
    @IBOutlet private weak var nameField: UITextField!
    @IBOutlet private weak var usernameField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    @IBOutlet private weak var confirmationField: UITextField!
    @IBOutlet private weak var roleControl: UISegmentedControl!
    @IBOutlet private weak var contentCenterConstraint: NSLayoutConstraint!
    private var fields: [UITextField] { [nameField, usernameField, passwordField, confirmationField] }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Crear cuenta"
        view.backgroundColor = AppTheme.background
        roleControl.selectedSegmentIndex = 0
        configureKeyboard()
        roleControl.selectedSegmentTintColor = AppTheme.primary
        roleControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
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
        let overlap = max(0, view.bounds.maxY - frame.minY)
        contentCenterConstraint.constant = -min(145, overlap * 0.38)
        UIView.animate(withDuration: 0.25) { self.view.layoutIfNeeded() }
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        contentCenterConstraint.constant = 0
        UIView.animate(withDuration: 0.25) { self.view.layoutIfNeeded() }
    }

    @IBAction private func register() {
        do {
            let user = try authService.register(
                name: nameField.text ?? "", username: usernameField.text ?? "",
                password: passwordField.text ?? "", confirmation: confirmationField.text ?? "",
                role: roleControl.selectedSegmentIndex == 0 ? "Vendedor" : "Supervisor"
            )
            SessionManager.shared.currentUser = user
            guard let window = view.window else { return }
            UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve) {
                window.rootViewController = StoryboardRouter.mainViewController(for: user)
            }
        } catch {
            presentAlert(title: "No se pudo registrar", message: error.localizedDescription)
        }
    }
}
