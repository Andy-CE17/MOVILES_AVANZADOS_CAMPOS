import UIKit

final class ProductsViewController: UITableViewController, UISearchResultsUpdating {
    private let service = CatalogService()
    private var products: [Producto] = []
    private let canEdit = SessionManager.shared.currentUser?.rol == "Supervisor"

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Productos"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "product")
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = search
        if canEdit {
            navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: UIAction { [weak self] _ in self?.showEditor(nil) })
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reload()
    }

    func updateSearchResults(for searchController: UISearchController) {
        reload(search: searchController.searchBar.text ?? "")
    }

    private func reload(search: String = "") {
        do { products = try service.products(search: search); tableView.reloadData() }
        catch { presentAlert(title: "Error", message: error.localizedDescription) }
    }

    private func showEditor(_ product: Producto?) {
        navigationController?.pushViewController(ProductFormViewController(product: product), animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { products.count }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = products[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "product", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = product.nombre
        content.secondaryText = "\(product.categoria)  ·  S/ \(product.precio.formatted(.number.precision(.fractionLength(2))))  ·  Stock: \(product.stock)"
        content.image = UIImage(systemName: product.stock <= 5 ? "exclamationmark.triangle.fill" : "shippingbox.fill")
        content.imageProperties.tintColor = product.stock <= 5 ? .systemOrange : .systemGreen
        cell.contentConfiguration = content
        cell.accessoryType = canEdit ? .disclosureIndicator : .none
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if canEdit { showEditor(products[indexPath.row]) }
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard canEdit else { return nil }
        let product = products[indexPath.row]
        let delete = UIContextualAction(style: .destructive, title: "Eliminar") { [weak self] _, _, done in
            do { try self?.service.delete(product); self?.reload(); done(true) }
            catch { self?.presentAlert(title: "No se puede eliminar", message: error.localizedDescription); done(false) }
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

final class ProductFormViewController: UIViewController {
    private let service = CatalogService()
    private let product: Producto?
    private let nameField = FormFactory.textField(placeholder: "Nombre")
    private let categoryField = FormFactory.textField(placeholder: "Categoría")
    private let priceField = FormFactory.textField(placeholder: "Precio")
    private let stockField = FormFactory.textField(placeholder: "Stock")

    init(product: Producto?) { self.product = product; super.init(nibName: nil, bundle: nil) }
    required init?(coder: NSCoder) { nil }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = product == nil ? "Nuevo producto" : "Editar producto"
        view.backgroundColor = .systemGroupedBackground
        priceField.keyboardType = .decimalPad
        stockField.keyboardType = .numberPad
        nameField.text = product?.nombre
        categoryField.text = product?.categoria
        if let product { priceField.text = String(product.precio); stockField.text = String(product.stock) }
        let save = FormFactory.primaryButton(title: "Guardar", action: UIAction { [weak self] _ in self?.save() })
        let stack = UIStackView(arrangedSubviews: [nameField, categoryField, priceField, stockField, save])
        stack.axis = .vertical; stack.spacing = 16; stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }

    private func save() {
        do {
            try service.saveProduct(product, name: nameField.text ?? "", category: categoryField.text ?? "", priceText: priceField.text ?? "", stockText: stockField.text ?? "")
            navigationController?.popViewController(animated: true)
        } catch { presentAlert(title: "Datos inválidos", message: error.localizedDescription) }
    }
}
