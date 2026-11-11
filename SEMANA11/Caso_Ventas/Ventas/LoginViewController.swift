import UIKit

final class LoginViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground

        let titleLabel = UILabel()
        titleLabel.text = "🛒"
        titleLabel.font = .systemFont(ofSize: 56)
        titleLabel.textAlignment = .center

        let nameLabel = UILabel()
        nameLabel.text = "Ventas Tecsup"
        nameLabel.font = .boldSystemFont(ofSize: 28)
        nameLabel.textAlignment = .center

        let detailLabel = UILabel()
        detailLabel.text = "Proyecto base del Caso Ventas"
        detailLabel.textColor = .secondaryLabel
        detailLabel.textAlignment = .center

        let stack = UIStackView(arrangedSubviews: [titleLabel, nameLabel, detailLabel])
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -24)
        ])
    }
}
