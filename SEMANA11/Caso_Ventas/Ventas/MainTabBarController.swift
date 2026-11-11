import UIKit

final class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let controller = UIViewController()
        controller.view.backgroundColor = .systemGroupedBackground
        controller.title = "Ventas"
        let label = FormFactory.label("Sesión iniciada correctamente", style: .title2, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        controller.view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: controller.view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: controller.view.centerYAnchor)
        ])
        let navigation = UINavigationController(rootViewController: controller)
        navigation.tabBarItem = UITabBarItem(title: "Inicio", image: UIImage(systemName: "house"), selectedImage: nil)
        viewControllers = [navigation]
    }
}
