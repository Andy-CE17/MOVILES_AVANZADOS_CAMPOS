import UIKit

final class NewSaleViewController: UIViewController {
    private let catalog = CatalogService()
    private let sales = SaleService()
    private var products: [Producto] = []
    private var clients: [Cliente] = []
    private var selectedProduct: Producto?
    private var selectedClient: Cliente?
    private let productButton = UIButton(type: .system)
    private let clientButton = UIButton(type: .system)
    private let quantityField = FormFactory.textField(placeholder: "Cantidad")
    private let summaryLabel = FormFactory.label("Selecciona los datos para calcular el total.", color: .secondaryLabel)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Nueva venta"
        view.backgroundColor = AppTheme.background
        navigationItem.largeTitleDisplayMode = .always
        quantityField.keyboardType = .numberPad
        quantityField.text = "1"
        quantityField.addTarget(self, action: #selector(updateSummary), for: .editingChanged)
        configureButton(productButton, title: "Seleccionar producto", action: #selector(selectProduct))
        configureButton(clientButton, title: "Seleccionar cliente", action: #selector(selectClient))
        configureLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        do { products = try catalog.products().filter { $0.stock > 0 }; clients = try catalog.clients() }
        catch { presentAlert(title: "Error", message: error.localizedDescription) }
        updateSummary()
    }

    private func configureButton(_ button: UIButton, title: String, action: Selector) {
        var configuration = UIButton.Configuration.gray()
        configuration.title = title
        configuration.image = UIImage(systemName: "chevron.right")
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 8
        configuration.baseForegroundColor = AppTheme.primary
        configuration.cornerStyle = .large
        button.configuration = configuration
        button.contentHorizontalAlignment = .fill
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
        button.addTarget(self, action: action, for: .touchUpInside)
    }

    private func configureLayout() {
        let header = FormFactory.label("Datos de la venta", style: .title2, weight: .bold)
        summaryLabel.font = .monospacedSystemFont(ofSize: 16, weight: .regular)
        summaryLabel.backgroundColor = AppTheme.card
        summaryLabel.layer.cornerRadius = 12
        summaryLabel.clipsToBounds = true
        summaryLabel.textAlignment = .center
        summaryLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 155).isActive = true
        let registerButton = FormFactory.primaryButton(title: "Registrar venta", action: UIAction { [weak self] _ in self?.registerSale() })
        let stack = UIStackView(arrangedSubviews: [header, productButton, clientButton, quantityField, summaryLabel, registerButton])
        stack.axis = .vertical; stack.spacing = 16; stack.translatesAutoresizingMaskIntoConstraints = false
        let card = CardView(); card.translatesAutoresizingMaskIntoConstraints = false; card.addSubview(stack); view.addSubview(card)
        NSLayoutConstraint.activate([
            card.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18),
            card.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16), card.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stack.topAnchor.constraint(equalTo: card.topAnchor, constant: 22), stack.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -22),
            stack.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 18), stack.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -18)
        ])
    }

    @objc private func selectProduct() {
        let selector = ItemSelectionViewController(title: "Producto", items: products.map { "\($0.nombre) · Stock \($0.stock)" }) { [weak self] index in
            guard let self else { return }
            selectedProduct = products[index]
            productButton.configuration?.title = selectedProduct?.nombre
            updateSummary()
        }
        navigationController?.pushViewController(selector, animated: true)
    }

    @objc private func selectClient() {
        let selector = ItemSelectionViewController(title: "Cliente", items: clients.map { "\($0.nombre) · \(catalog.category(for: $0))" }) { [weak self] index in
            guard let self else { return }
            selectedClient = clients[index]
            clientButton.configuration?.title = selectedClient?.nombre
            updateSummary()
        }
        navigationController?.pushViewController(selector, animated: true)
    }

    @objc private func updateSummary() {
        guard let product = selectedProduct, let client = selectedClient, let quantity = Int64(quantityField.text ?? ""), quantity > 0 else {
            summaryLabel.text = "Selecciona los datos para calcular el total."
            return
        }
        let result = sales.calculate(product: product, client: client, quantity: quantity)
        summaryLabel.text = "Subtotal: \(result.subtotal.soles)\nDescuento: -\(result.discount.soles)\nIGV (18%): \(result.igv.soles)\n\nTOTAL: \(result.total.soles)"
    }

    private func registerSale() {
        do {
            let quantity = Int64(quantityField.text ?? "") ?? 0
            let sale = try sales.register(product: selectedProduct, client: selectedClient, quantity: quantity)
            presentAlert(title: "Venta registrada", message: "Total: \(sale.total.soles)\nEl stock fue actualizado correctamente.")
            selectedProduct = nil; selectedClient = nil; quantityField.text = "1"
            productButton.configuration?.title = "Seleccionar producto"
            clientButton.configuration?.title = "Seleccionar cliente"
            products = try catalog.products().filter { $0.stock > 0 }
            updateSummary()
        } catch { presentAlert(title: "No se pudo registrar", message: error.localizedDescription) }
    }
}

final class ItemSelectionViewController: UITableViewController {
    private let screenTitle: String
    private let items: [String]
    private let selection: (Int) -> Void
    init(title: String, items: [String], selection: @escaping (Int) -> Void) {
        self.screenTitle = title; self.items = items; self.selection = selection
        super.init(style: .insetGrouped)
    }
    required init?(coder: NSCoder) { nil }
    override func viewDidLoad() { super.viewDidLoad(); title = screenTitle; applyProfessionalTableStyle(); tableView.register(UITableViewCell.self, forCellReuseIdentifier: "item") }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { items.count }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "item", for: indexPath)
        var content = cell.defaultContentConfiguration(); content.text = items[indexPath.row]; cell.contentConfiguration = content
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { selection(indexPath.row); navigationController?.popViewController(animated: true) }
}
