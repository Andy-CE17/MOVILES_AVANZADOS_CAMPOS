import UIKit


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        AppTheme.configure()
        return true
    }

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        let configuration = UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
        configuration.delegateClass = SceneDelegate.self
        return configuration
    }
}


final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = StoryboardRouter.initialViewController()
        window.makeKeyAndVisible()
        self.window = window
    }
}


final class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = AppTheme.primary
        guard let user = SessionManager.shared.currentUser else {
            showLogin()
            return
        }
        viewControllers = user.rol == "Supervisor" ? supervisorTabs() : sellerTabs()
    }

    private func sellerTabs() -> [UIViewController] {
        [
            storyboardTab("ProductsScreen", title: "Productos", icon: "shippingbox"),
            storyboardTab("ClientsScreen", title: "Clientes", icon: "person.2"),
            storyboardTab("NewSaleScreen", title: "Nueva venta", icon: "cart.badge.plus"),
            storyboardTab("SalesScreen", title: "Mis ventas", icon: "list.bullet.rectangle"),
            storyboardTab("AccountScreen", title: "Cuenta", icon: "person.crop.circle")
        ]
    }

    private func supervisorTabs() -> [UIViewController] {
        [
            storyboardTab("SummaryScreen", title: "Resumen", icon: "chart.bar"),
            storyboardTab("SalesScreen", title: "Ventas", icon: "doc.text.magnifyingglass"),
            storyboardTab("ProductsScreen", title: "Productos", icon: "shippingbox"),
            storyboardTab("ClientsScreen", title: "Clientes", icon: "person.2"),
            storyboardTab("AccountScreen", title: "Cuenta", icon: "person.crop.circle")
        ]
    }

    private func storyboardTab(_ identifier: String, title: String, icon: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: identifier)
        return navigation(title: title, icon: icon, controller: controller)
    }

    private func navigation(title: String, icon: String, controller: UIViewController) -> UIViewController {
        let navigation = UINavigationController(rootViewController: controller)
        navigation.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: icon), selectedImage: nil)
        return navigation
    }

    private func showLogin() {
        guard let window = view.window else { return }
        window.rootViewController = StoryboardRouter.initialViewController()
    }
}


final class SessionManager {
    static let shared = SessionManager()
    private init() {}
    var currentUser: Usuario?
}


enum StoryboardRouter {
    private static var main: UIStoryboard {
        UIStoryboard(name: "Main", bundle: nil)
    }

    static func initialViewController() -> UIViewController {
        guard let controller = main.instantiateInitialViewController() else {
            fatalError("No se encontro el controlador inicial en Main.storyboard")
        }
        return controller
    }

    static func mainViewController(for user: Usuario) -> UIViewController {
        main.instantiateViewController(withIdentifier: "MainTabBar")
    }
}
