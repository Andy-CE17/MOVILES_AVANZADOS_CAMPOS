import UIKit


final class ProductsViewController: UITableViewController, UISearchResultsUpdating {
    private let service = CatalogService()
    private var products: [Producto] = []
    private let canEdit = SessionManager.shared.currentUser?.rol == "Supervisor"

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Productos"
        applyProfessionalTableStyle()
        tableView.separatorStyle = .none
        tableView.rowHeight = 104
        navigationItem.largeTitleDisplayMode = .always
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
        do {
            products = try service.products(search: search)
            tableView.backgroundView = products.isEmpty
                ? EmptyStateView(icon: "shippingbox", title: "Sin productos", message: canEdit ? "Usa el botón + para registrar el primer producto." : "Aún no existen productos disponibles.")
                : nil
            tableView.reloadData()
        }
        catch { presentAlert(title: "Error", message: error.localizedDescription) }
    }

    private func showEditor(_ product: Producto?) {
        let editor = storyboard!.instantiateViewController(withIdentifier: "ProductFormScreen") as! ProductFormViewController
        editor.product = product
        navigationController?.pushViewController(editor, animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { products.count }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = products[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "product", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = product.nombre
        content.secondaryText = "\(product.categoria) · \(product.precio.soles) · Stock \(product.stock)"
        content.image = UIImage(systemName: product.stock <= 5 ? "exclamationmark.triangle.fill" : "shippingbox.fill")
        content.imageProperties.tintColor = product.stock <= 5 ? AppTheme.accent : AppTheme.primary
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
    var product: Producto?
    @IBOutlet private weak var nameField: UITextField!
    @IBOutlet private weak var categoryField: UITextField!
    @IBOutlet private weak var priceField: UITextField!
    @IBOutlet private weak var stockField: UITextField!

    required init?(coder: NSCoder) { super.init(coder: coder) }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = product == nil ? "Nuevo producto" : "Editar producto"
        priceField.keyboardType = .decimalPad
        stockField.keyboardType = .numberPad
        nameField.text = product?.nombre
        categoryField.text = product?.categoria
        if let product { priceField.text = String(product.precio); stockField.text = String(product.stock) }
    }

    @IBAction private func save() {
        do {
            try service.saveProduct(product, name: nameField.text ?? "", category: categoryField.text ?? "", priceText: priceField.text ?? "", stockText: stockField.text ?? "")
            navigationController?.popViewController(animated: true)
        } catch { presentAlert(title: "Datos inválidos", message: error.localizedDescription) }
    }
}


final class ClientsViewController: UITableViewController, UISearchResultsUpdating {
    private let service = CatalogService()
    private var clients: [Cliente] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Clientes"
        applyProfessionalTableStyle()
        tableView.separatorStyle = .none
        tableView.rowHeight = 100
        navigationItem.largeTitleDisplayMode = .always
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = search
    }

    @IBAction private func addClient() { showEditor(nil) }

    override func viewWillAppear(_ animated: Bool) { super.viewWillAppear(animated); reload() }
    func updateSearchResults(for searchController: UISearchController) { reload(search: searchController.searchBar.text ?? "") }

    private func reload(search: String = "") {
        do {
            clients = try service.clients(search: search)
            tableView.backgroundView = clients.isEmpty
                ? EmptyStateView(icon: "person.2", title: "Sin clientes", message: "Usa el botón + para registrar el primer cliente.")
                : nil
            tableView.reloadData()
        }
        catch { presentAlert(title: "Error", message: error.localizedDescription) }
    }

    private func showEditor(_ client: Cliente?) {
        let editor = storyboard!.instantiateViewController(withIdentifier: "ClientFormScreen") as! ClientFormViewController
        editor.client = client
        navigationController?.pushViewController(editor, animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { clients.count }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let client = clients[indexPath.row]
        let total = service.validTotal(for: client).formatted(.currency(code: "PEN"))
        let category = service.category(for: client)
        let cell = tableView.dequeueReusableCell(withIdentifier: "client", for: indexPath) as! ClientStoryboardCell
        cell.configure(name: client.nombre, document: client.documento, category: category, total: total)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showEditor(clients[indexPath.row])
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let client = clients[indexPath.row]
        let delete = UIContextualAction(style: .destructive, title: "Eliminar") { [weak self] _, _, done in
            do { try self?.service.delete(client); self?.reload(); done(true) }
            catch { self?.presentAlert(title: "No se puede eliminar", message: error.localizedDescription); done(false) }
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

final class ClientStoryboardCell: UITableViewCell {
    @IBOutlet private weak var clientImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var documentLabel: UILabel!
    @IBOutlet private weak var totalLabel: UILabel!
    @IBOutlet private weak var categoryLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        contentView.layer.cornerRadius = 22
        contentView.clipsToBounds = true
    }

    func configure(name: String, document: String, category: String, total: String) {
        nameLabel.text = name
        documentLabel.text = "Documento: \(document)"
        totalLabel.text = "Compras: \(total)"
        categoryLabel.text = category
        clientImageView.image = UIImage(systemName: category == "VIP" ? "star.fill" : "person.fill")
        clientImageView.tintColor = category == "VIP" ? AppTheme.accent : AppTheme.primary
    }
}

final class ClientFormViewController: UIViewController {
    private let service = CatalogService()
    var client: Cliente?
    @IBOutlet private weak var nameField: UITextField!
    @IBOutlet private weak var documentField: UITextField!

    required init?(coder: NSCoder) { super.init(coder: coder) }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = client == nil ? "Nuevo cliente" : "Editar cliente"
        documentField.keyboardType = .numberPad
        nameField.text = client?.nombre
        documentField.text = client?.documento
    }

    @IBAction private func save() {
        do {
            try service.saveClient(client, name: nameField.text ?? "", document: documentField.text ?? "")
            navigationController?.popViewController(animated: true)
        } catch { presentAlert(title: "Datos inválidos", message: error.localizedDescription) }
    }
}
