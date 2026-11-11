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
        tableView.tableHeaderView = ScreenHeaderView(
            title: canEdit ? "Gestión de inventario" : "Catálogo de productos",
            subtitle: canEdit ? "Administra precios y existencias" : "Consulta precios y disponibilidad",
            icon: "shippingbox.fill"
        )
        tableView.tableHeaderView?.frame.size.height = 112
        navigationItem.largeTitleDisplayMode = .always
        tableView.register(ProductCardCell.self, forCellReuseIdentifier: "product")
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
        navigationController?.pushViewController(ProductFormViewController(product: product), animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { products.count }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = products[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "product", for: indexPath) as! ProductCardCell
        cell.configure(product: product, editable: canEdit)
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

final class ProductCardCell: UITableViewCell {
    private let card = CardView()
    private let iconView = UIImageView()
    private let nameLabel = FormFactory.label("", weight: .bold)
    private let categoryLabel = FormFactory.label("", style: .subheadline, color: .secondaryLabel)
    private let priceLabel = FormFactory.label("", weight: .bold, color: AppTheme.primary)
    private let stockLabel = PillLabel(text: "", color: AppTheme.primary)
    private let chevron = UIImageView(image: UIImage(systemName: "chevron.right"))

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear; selectionStyle = .none
        card.translatesAutoresizingMaskIntoConstraints = false
        iconView.contentMode = .scaleAspectFit; iconView.tintColor = AppTheme.primary
        iconView.backgroundColor = AppTheme.primary.withAlphaComponent(0.10); iconView.layer.cornerRadius = 22
        iconView.translatesAutoresizingMaskIntoConstraints = false
        let texts = UIStackView(arrangedSubviews: [nameLabel, categoryLabel, priceLabel]); texts.axis = .vertical; texts.spacing = 3
        chevron.tintColor = .tertiaryLabel; chevron.setContentHuggingPriority(.required, for: .horizontal)
        let row = UIStackView(arrangedSubviews: [iconView, texts, stockLabel, chevron]); row.axis = .horizontal; row.alignment = .center; row.spacing = 12
        row.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(card); card.addSubview(row)
        NSLayoutConstraint.activate([
            card.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6), card.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            card.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16), card.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            row.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 14), row.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -14), row.centerYAnchor.constraint(equalTo: card.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 44), iconView.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    required init?(coder: NSCoder) { nil }

    func configure(product: Producto, editable: Bool) {
        nameLabel.text = product.nombre
        categoryLabel.text = product.categoria
        priceLabel.text = product.precio.soles
        let lowStock = product.stock <= 5
        stockLabel.text = "Stock \(product.stock)"
        stockLabel.textColor = lowStock ? AppTheme.accent : AppTheme.primary
        stockLabel.backgroundColor = (lowStock ? AppTheme.accent : AppTheme.primary).withAlphaComponent(0.12)
        iconView.image = UIImage(systemName: lowStock ? "exclamationmark.triangle.fill" : "shippingbox.fill")
        iconView.tintColor = lowStock ? AppTheme.accent : AppTheme.primary
        chevron.isHidden = !editable
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
        view.backgroundColor = AppTheme.background
        priceField.keyboardType = .decimalPad
        stockField.keyboardType = .numberPad
        nameField.text = product?.nombre
        categoryField.text = product?.categoria
        if let product { priceField.text = String(product.precio); stockField.text = String(product.stock) }
        let save = FormFactory.primaryButton(title: "Guardar", action: UIAction { [weak self] _ in self?.save() })
        let stack = UIStackView(arrangedSubviews: [nameField, categoryField, priceField, stockField, save])
        stack.axis = .vertical; stack.spacing = 16; stack.translatesAutoresizingMaskIntoConstraints = false
        let card = CardView(); card.translatesAutoresizingMaskIntoConstraints = false; card.addSubview(stack); view.addSubview(card)
        NSLayoutConstraint.activate([
            card.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            card.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20), card.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stack.topAnchor.constraint(equalTo: card.topAnchor, constant: 22), stack.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -22),
            stack.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 18), stack.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -18)
        ])
    }

    private func save() {
        do {
            try service.saveProduct(product, name: nameField.text ?? "", category: categoryField.text ?? "", priceText: priceField.text ?? "", stockText: stockField.text ?? "")
            navigationController?.popViewController(animated: true)
        } catch { presentAlert(title: "Datos inválidos", message: error.localizedDescription) }
    }
}
