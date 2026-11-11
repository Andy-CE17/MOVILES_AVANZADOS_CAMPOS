import UIKit

enum AppTheme {
    static let primary = UIColor(red: 0.04, green: 0.48, blue: 0.35, alpha: 1)
    static let primaryDark = UIColor(red: 0.02, green: 0.29, blue: 0.23, alpha: 1)
    static let accent = UIColor(red: 0.96, green: 0.56, blue: 0.16, alpha: 1)
    static let background = UIColor { traits in
        traits.userInterfaceStyle == .dark
            ? UIColor(red: 0.05, green: 0.07, blue: 0.08, alpha: 1)
            : UIColor(red: 0.95, green: 0.97, blue: 0.96, alpha: 1)
    }
    static let card = UIColor.secondarySystemGroupedBackground

    static func configure() {
        let navigation = UINavigationBarAppearance()
        navigation.configureWithOpaqueBackground()
        navigation.backgroundColor = background
        navigation.titleTextAttributes = [.foregroundColor: UIColor.label]
        navigation.largeTitleTextAttributes = [.foregroundColor: UIColor.label]
        UINavigationBar.appearance().standardAppearance = navigation
        UINavigationBar.appearance().scrollEdgeAppearance = navigation
        UINavigationBar.appearance().tintColor = primary

        let tab = UITabBarAppearance()
        tab.configureWithOpaqueBackground()
        tab.backgroundColor = .secondarySystemGroupedBackground
        UITabBar.appearance().standardAppearance = tab
        UITabBar.appearance().scrollEdgeAppearance = tab
        UITabBar.appearance().tintColor = primary
    }
}

final class BrandBackgroundView: UIView {
    override class var layerClass: AnyClass { CAGradientLayer.self }
    override init(frame: CGRect) {
        super.init(frame: frame)
        let gradient = layer as! CAGradientLayer
        gradient.colors = [AppTheme.primaryDark.cgColor, AppTheme.primary.cgColor]
        gradient.startPoint = CGPoint(x: 0.1, y: 0)
        gradient.endPoint = CGPoint(x: 0.9, y: 1)
    }
    required init?(coder: NSCoder) { nil }
}

final class CardView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = AppTheme.card
        layer.cornerRadius = 20
        layer.cornerCurve = .continuous
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.08
        layer.shadowRadius = 16
        layer.shadowOffset = CGSize(width: 0, height: 8)
    }
    required init?(coder: NSCoder) { nil }
}

enum FormFactory {
    static func textField(placeholder: String, icon: String? = nil, secure: Bool = false) -> UITextField {
        let field = UITextField()
        field.placeholder = placeholder
        field.isSecureTextEntry = secure
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.backgroundColor = .tertiarySystemGroupedBackground
        field.layer.cornerRadius = 12
        field.layer.cornerCurve = .continuous
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.separator.withAlphaComponent(0.45).cgColor
        field.heightAnchor.constraint(equalToConstant: 52).isActive = true
        field.clearButtonMode = .whileEditing
        field.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 14, height: 1))
        field.rightViewMode = .always
        if let icon {
            let container = UIView(frame: CGRect(x: 0, y: 0, width: 42, height: 48))
            let image = UIImageView(image: UIImage(systemName: icon))
            image.tintColor = AppTheme.primary
            image.frame = CGRect(x: 14, y: 16, width: 20, height: 20)
            container.addSubview(image)
            field.leftView = container
            field.leftViewMode = .always
        }
        return field
    }

    static func label(_ text: String, style: UIFont.TextStyle = .body, weight: UIFont.Weight = .regular, color: UIColor = .label) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = color
        label.font = .systemFont(ofSize: UIFont.preferredFont(forTextStyle: style).pointSize, weight: weight)
        label.numberOfLines = 0
        return label
    }

    static func primaryButton(title: String, action: UIAction) -> UIButton {
        var configuration = UIButton.Configuration.filled()
        configuration.title = title
        configuration.cornerStyle = .large
        configuration.baseBackgroundColor = AppTheme.primary
        configuration.baseForegroundColor = .white
        let button = UIButton(configuration: configuration, primaryAction: action)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        button.heightAnchor.constraint(equalToConstant: 52).isActive = true
        button.layer.shadowColor = AppTheme.primaryDark.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 8
        button.layer.shadowOffset = CGSize(width: 0, height: 5)
        return button
    }
}

extension UIViewController {
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default))
        present(alert, animated: true)
    }
}

extension UITableViewController {
    func applyProfessionalTableStyle() {
        tableView.backgroundColor = AppTheme.background
        tableView.separatorColor = .separator.withAlphaComponent(0.45)
        tableView.keyboardDismissMode = .onDrag
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 72
    }
}
