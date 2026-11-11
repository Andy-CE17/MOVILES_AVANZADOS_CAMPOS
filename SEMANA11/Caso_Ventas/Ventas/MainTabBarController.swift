import UIKit

final class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .systemGreen
        guard let user = SessionManager.shared.currentUser else {
            showLogin()
            return
        }
        viewControllers = user.rol == "Supervisor" ? supervisorTabs() : sellerTabs()
    }

    private func sellerTabs() -> [UIViewController] {
        [
            navigation(title: "Productos", icon: "shippingbox", controller: ProductsViewController()),
            navigation(title: "Clientes", icon: "person.2", controller: ClientsViewController()),
            navigation(title: "Nueva venta", icon: "cart.badge.plus", controller: NewSaleViewController()),
            navigation(title: "Mis ventas", icon: "list.bullet.rectangle", controller: SalesListViewController(onlyCurrentSeller: true)),
            navigation(title: "Cuenta", icon: "person.crop.circle", controller: AccountViewController())
        ]
    }

    private func supervisorTabs() -> [UIViewController] {
        [
            navigation(title: "Resumen", icon: "chart.bar", controller: PlaceholderViewController(title: "Resumen", message: "Indicadores generales del negocio.")),
            navigation(title: "Ventas", icon: "doc.text.magnifyingglass", controller: SalesListViewController(onlyCurrentSeller: false)),
            navigation(title: "Productos", icon: "shippingbox", controller: ProductsViewController()),
            navigation(title: "Clientes", icon: "person.2", controller: ClientsViewController()),
            navigation(title: "Cuenta", icon: "person.crop.circle", controller: AccountViewController())
        ]
    }

    private func navigation(title: String, icon: String, controller: UIViewController) -> UIViewController {
        let navigation = UINavigationController(rootViewController: controller)
        navigation.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: icon), selectedImage: nil)
        return navigation
    }

    private func showLogin() {
        guard let window = view.window else { return }
        window.rootViewController = UINavigationController(rootViewController: LoginViewController())
    }
}

final class PlaceholderViewController: UIViewController {
    private let screenTitle: String
    private let message: String

    init(title: String, message: String) {
        self.screenTitle = title
        self.message = message
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { nil }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = screenTitle
        view.backgroundColor = .systemGroupedBackground
        let label = FormFactory.label(message, style: .title3, color: .secondaryLabel)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 30),
            label.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -30)
        ])
    }
}
