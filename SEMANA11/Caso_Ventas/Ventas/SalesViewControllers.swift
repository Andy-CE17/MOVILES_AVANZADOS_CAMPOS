import UIKit


final class NewSaleViewController: UIViewController {
    private let catalog = CatalogService()
    private let sales = SaleService()
    private var products: [Producto] = []
    private var clients: [Cliente] = []
    private var selectedProduct: Producto?
    private var selectedClient: Cliente?
    @IBOutlet private weak var productButton: UIButton!
    @IBOutlet private weak var clientButton: UIButton!
    @IBOutlet private weak var quantityField: UITextField!
    @IBOutlet private weak var summaryLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Nueva venta"
        view.backgroundColor = AppTheme.background
        navigationItem.largeTitleDisplayMode = .always
        quantityField.keyboardType = .numberPad
        quantityField.text = "1"
        quantityField.addTarget(self, action: #selector(updateSummary), for: .editingChanged)
        configureButton(productButton, title: "Seleccionar producto")
        configureButton(clientButton, title: "Seleccionar cliente")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        do { products = try catalog.products().filter { $0.stock > 0 }; clients = try catalog.clients() }
        catch { presentAlert(title: "Error", message: error.localizedDescription) }
        updateSummary()
    }

    private func configureButton(_ button: UIButton, title: String) {
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
    }

    @IBAction private func selectProduct() {
        let selector = UIAlertController(title: "Seleccionar producto", message: nil, preferredStyle: .actionSheet)
        for product in products {
            selector.addAction(UIAlertAction(title: "\(product.nombre) · Stock \(product.stock)", style: .default) { [weak self] _ in
                self?.selectedProduct = product
                self?.productButton.configuration?.title = product.nombre
                self?.updateSummary()
            })
        }
        selector.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        present(selector, animated: true)
    }

    @IBAction private func selectClient() {
        let selector = UIAlertController(title: "Seleccionar cliente", message: nil, preferredStyle: .actionSheet)
        for client in clients {
            selector.addAction(UIAlertAction(title: "\(client.nombre) · \(catalog.category(for: client))", style: .default) { [weak self] _ in
                self?.selectedClient = client
                self?.clientButton.configuration?.title = client.nombre
                self?.updateSummary()
            })
        }
        selector.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        present(selector, animated: true)
    }

    @objc private func updateSummary() {
        guard let product = selectedProduct, let client = selectedClient, let quantity = Int64(quantityField.text ?? ""), quantity > 0 else {
            summaryLabel.text = "Selecciona los datos para calcular el total."
            return
        }
        let result = sales.calculate(product: product, client: client, quantity: quantity)
        summaryLabel.text = "Subtotal: \(result.subtotal.soles)\nDescuento: -\(result.discount.soles)\nIGV (18%): \(result.igv.soles)\n\nTOTAL: \(result.total.soles)"
    }

    @IBAction private func registerSale() {
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

final class SalesListViewController: UITableViewController, UISearchResultsUpdating {
    private let service = SaleService()
    private var allSales: [Venta] = []
    private var visibleSales: [Venta] = []
    private var onlyCurrentSeller: Bool
    @IBOutlet private weak var statusControl: UISegmentedControl!
    private var searchText = ""

    init(onlyCurrentSeller: Bool) {
        self.onlyCurrentSeller = onlyCurrentSeller
        super.init(style: .insetGrouped)
    }
    required init?(coder: NSCoder) {
        onlyCurrentSeller = SessionManager.shared.currentUser?.rol != "Supervisor"
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = onlyCurrentSeller ? "Mis ventas" : "Ventas del equipo"
        applyProfessionalTableStyle()
        tableView.separatorStyle = .none
        tableView.rowHeight = 112
        navigationItem.largeTitleDisplayMode = .always
        statusControl.selectedSegmentIndex = 0
        statusControl.addTarget(self, action: #selector(applyFilters), for: .valueChanged)
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.searchBar.placeholder = "Producto, cliente o vendedor"
        search.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = search
    }

    override func viewWillAppear(_ animated: Bool) { super.viewWillAppear(animated); reload() }
    func updateSearchResults(for searchController: UISearchController) { searchText = searchController.searchBar.text ?? ""; applyFilters() }


    private func reload() {
        do { allSales = try service.sales(for: onlyCurrentSeller ? SessionManager.shared.currentUser : nil); applyFilters() }
        catch { presentAlert(title: "Error", message: error.localizedDescription) }
    }

    @objc private func applyFilters() {
        visibleSales = allSales.filter { sale in
            let statusMatches = statusControl.selectedSegmentIndex == 0 ||
                (statusControl.selectedSegmentIndex == 1 && !sale.anulada) ||
                (statusControl.selectedSegmentIndex == 2 && sale.anulada)
            let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
            let textMatches = query.isEmpty || sale.producto.nombre.localizedCaseInsensitiveContains(query) ||
                sale.cliente.nombre.localizedCaseInsensitiveContains(query) || sale.vendedor.nombre.localizedCaseInsensitiveContains(query)
            return statusMatches && textMatches
        }
        tableView.backgroundView = visibleSales.isEmpty
            ? EmptyStateView(icon: "receipt", title: "Sin operaciones", message: "No hay ventas que coincidan con el filtro seleccionado.")
            : nil
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { visibleSales.count }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? { "\(visibleSales.count) operaciones" }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sale = visibleSales[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "sale", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = "\(sale.producto.nombre) · \(sale.total.soles)"
        content.secondaryText = "\(sale.cliente.nombre) · \(sale.vendedor.nombre) · \(sale.fecha.saleDateText) · \(sale.anulada ? "ANULADA" : "VIGENTE")"
        content.image = UIImage(systemName: sale.anulada ? "xmark.circle.fill" : "checkmark.circle.fill")
        content.imageProperties.tintColor = sale.anulada ? .systemRed : AppTheme.primary
        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showSaleDetail(visibleSales[indexPath.row])
    }

    private func showSaleDetail(_ sale: Venta) {
        let subtotal = sale.precioUnitario * Double(sale.cantidad)
        let status = sale.anulada ? "ANULADA" : "VIGENTE"
        let reason = sale.anulada ? "\nMotivo: \(sale.motivoAnulacion ?? "No indicado")" : ""
        let message = """
        Estado: \(status)
        Fecha: \(sale.fecha.saleDateText)
        Vendedor: \(sale.vendedor.nombre)
        Cliente: \(sale.cliente.nombre)
        Producto: \(sale.producto.nombre)
        Cantidad: \(sale.cantidad)
        Precio unitario: \(sale.precioUnitario.soles)
        Subtotal: \(subtotal.soles)
        Descuento: \(sale.descuento.soles)
        IGV: \(sale.igv.soles)
        TOTAL: \(sale.total.soles)\(reason)
        """
        let alert = UIAlertController(title: "Detalle de venta", message: message, preferredStyle: .alert)
        if !onlyCurrentSeller && !sale.anulada {
            alert.addAction(UIAlertAction(title: "Anular venta", style: .destructive) { [weak self] _ in self?.askCancellationReason(for: sale) })
        }
        alert.addAction(UIAlertAction(title: "Cerrar", style: .cancel))
        present(alert, animated: true)
    }

    private func askCancellationReason(for sale: Venta) {
        let alert = UIAlertController(title: "Anular venta", message: "Indica el motivo. El stock será repuesto.", preferredStyle: .alert)
        alert.addTextField { $0.placeholder = "Motivo obligatorio" }
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        alert.addAction(UIAlertAction(title: "Anular", style: .destructive) { [weak self, weak alert] _ in
            guard let self else { return }
            do { try service.cancel(sale, reason: alert?.textFields?.first?.text ?? ""); reload() }
            catch { presentAlert(title: "No se pudo anular", message: error.localizedDescription) }
        })
        present(alert, animated: true)
    }
}

final class SummaryViewController: UITableViewController {
    private let saleService = SaleService()
    private let catalog = CatalogService()
    private var validSales: [Venta] = []
    private var cancelledSales: [Venta] = []
    private var lowStockProducts: [Producto] = []
    private var ranking: [(String, Double)] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Resumen"
        applyProfessionalTableStyle()
        navigationItem.largeTitleDisplayMode = .always
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadSummary()
    }

    private func loadSummary() {
        do {
            let all = try saleService.sales()
            validSales = all.filter { !$0.anulada }
            cancelledSales = all.filter(\.anulada)
            lowStockProducts = try catalog.products().filter { $0.stock <= 5 }
            let grouped = Dictionary(grouping: validSales, by: { $0.vendedor.nombre })
            ranking = grouped.map { ($0.key, $0.value.reduce(0) { $0 + $1.total }) }.sorted { $0.1 > $1.1 }
            tableView.reloadData()
        } catch { presentAlert(title: "Error", message: error.localizedDescription) }
    }

    private func metricsHeader() -> UIView {
        let income = validSales.reduce(0) { $0 + $1.total }
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 278))
        let hero = BrandBackgroundView()
        hero.layer.cornerRadius = 22; hero.layer.cornerCurve = .continuous; hero.clipsToBounds = true
        hero.translatesAutoresizingMaskIntoConstraints = false
        let caption = FormFactory.label("INGRESOS VIGENTES", style: .caption1, weight: .bold, color: UIColor.white.withAlphaComponent(0.72))
        let amount = FormFactory.label(income.soles, style: .largeTitle, weight: .bold, color: .white)
        amount.adjustsFontSizeToFitWidth = true
        let salesIcon = UIImageView(image: UIImage(systemName: "chart.line.uptrend.xyaxis")); salesIcon.tintColor = .white
        let amountRow = UIStackView(arrangedSubviews: [amount, salesIcon]); amountRow.axis = .horizontal; amountRow.alignment = .center; amountRow.spacing = 10
        let heroStack = UIStackView(arrangedSubviews: [caption, amountRow]); heroStack.axis = .vertical; heroStack.spacing = 8; heroStack.translatesAutoresizingMaskIntoConstraints = false
        hero.addSubview(heroStack)

        let cards = UIStackView(arrangedSubviews: [
            metricCard(value: String(validSales.count), title: "Ventas vigentes", color: AppTheme.primary),
            metricCard(value: String(cancelledSales.count), title: "Ventas anuladas", color: .systemRed),
            metricCard(value: String(lowStockProducts.count), title: "Alertas de stock", color: AppTheme.accent)
        ])
        cards.axis = .horizontal; cards.distribution = .fillEqually; cards.spacing = 8; cards.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(hero); container.addSubview(cards)
        NSLayoutConstraint.activate([
            hero.topAnchor.constraint(equalTo: container.topAnchor, constant: 10), hero.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            hero.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16), hero.heightAnchor.constraint(equalToConstant: 130),
            heroStack.leadingAnchor.constraint(equalTo: hero.leadingAnchor, constant: 22), heroStack.trailingAnchor.constraint(equalTo: hero.trailingAnchor, constant: -22), heroStack.centerYAnchor.constraint(equalTo: hero.centerYAnchor),
            salesIcon.widthAnchor.constraint(equalToConstant: 30), salesIcon.heightAnchor.constraint(equalToConstant: 30),
            cards.topAnchor.constraint(equalTo: hero.bottomAnchor, constant: 12), cards.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            cards.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16), cards.heightAnchor.constraint(equalToConstant: 110)
        ])
        return container
    }

    private func metricCard(value: String, title: String, color: UIColor) -> UIView {
        let valueLabel = FormFactory.label(value, style: .title3, weight: .bold, color: color)
        valueLabel.textAlignment = .center; valueLabel.adjustsFontSizeToFitWidth = true
        let titleLabel = FormFactory.label(title, style: .caption1, color: .secondaryLabel); titleLabel.textAlignment = .center
        let stack = UIStackView(arrangedSubviews: [valueLabel, titleLabel]); stack.axis = .vertical; stack.alignment = .center; stack.spacing = 8
        let card = UIView(); card.backgroundColor = .secondarySystemGroupedBackground; card.layer.cornerRadius = 12
        stack.translatesAutoresizingMaskIntoConstraints = false; card.addSubview(stack)
        NSLayoutConstraint.activate([stack.centerXAnchor.constraint(equalTo: card.centerXAnchor), stack.centerYAnchor.constraint(equalTo: card.centerYAnchor), stack.leadingAnchor.constraint(greaterThanOrEqualTo: card.leadingAnchor, constant: 6), stack.trailingAnchor.constraint(lessThanOrEqualTo: card.trailingAnchor, constant: -6)])
        return card
    }

    override func numberOfSections(in tableView: UITableView) -> Int { 2 }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { section == 0 ? ranking.count : lowStockProducts.count }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? { section == 0 ? "Ranking de vendedores" : "Stock bajo (5 o menos)" }
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 0 && ranking.isEmpty { return "Aún no existen ventas vigentes." }
        if section == 1 && lowStockProducts.isEmpty { return "No hay alertas de stock." }
        return nil
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "summary", for: indexPath)
        var content = cell.defaultContentConfiguration()
        if indexPath.section == 0 {
            let seller = ranking[indexPath.row]
            content.text = "\(indexPath.row + 1). \(seller.0)"
            content.secondaryText = seller.1.soles
            content.image = UIImage(systemName: indexPath.row == 0 ? "trophy.fill" : "person.fill")
            content.imageProperties.tintColor = indexPath.row == 0 ? AppTheme.accent : AppTheme.primary
        } else {
            let product = lowStockProducts[indexPath.row]
            content.text = product.nombre
            content.secondaryText = "Quedan \(product.stock) unidades"
            content.image = UIImage(systemName: "exclamationmark.triangle.fill")
            content.imageProperties.tintColor = .systemOrange
        }
        cell.contentConfiguration = content
        return cell
    }
}
