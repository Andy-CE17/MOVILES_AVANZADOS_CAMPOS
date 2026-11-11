import UIKit

enum FormFactory {
    static func textField(placeholder: String, icon: String? = nil, secure: Bool = false) -> UITextField {
        let field = UITextField()
        field.placeholder = placeholder
        field.isSecureTextEntry = secure
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.backgroundColor = .secondarySystemGroupedBackground
        field.layer.cornerRadius = 10
        field.heightAnchor.constraint(equalToConstant: 48).isActive = true
        field.clearButtonMode = .whileEditing
        field.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 14, height: 1))
        field.rightViewMode = .always
        if let icon {
            let container = UIView(frame: CGRect(x: 0, y: 0, width: 42, height: 48))
            let image = UIImageView(image: UIImage(systemName: icon))
            image.tintColor = .secondaryLabel
            image.frame = CGRect(x: 14, y: 14, width: 20, height: 20)
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
        configuration.cornerStyle = .medium
        configuration.baseBackgroundColor = .systemGreen
        let button = UIButton(configuration: configuration, primaryAction: action)
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
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
