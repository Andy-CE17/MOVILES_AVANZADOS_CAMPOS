import UIKit

final class SalesListViewController: UITableViewController, UISearchResultsUpdating {
    private let service = SaleService()
    private var allSales: [Venta] = []
    private var visibleSales: [Venta] = []
    private let onlyCurrentSeller: Bool
    private let statusControl = UISegmentedControl(items: ["Todas", "Vigentes", "Anuladas"])
    private var searchText = ""

    init(onlyCurrentSeller: Bool) {
        self.onlyCurrentSeller = onlyCurrentSeller
        super.init(style: .insetGrouped)
    }
    required init?(coder: NSCoder) { nil }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = onlyCurrentSeller ? "Mis ventas" : "Ventas del equipo"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "sale")
        statusControl.selectedSegmentIndex = 0
        statusControl.addTarget(self, action: #selector(applyFilters), for: .valueChanged)
        tableView.tableHeaderView = headerContainer()
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.searchBar.placeholder = "Producto, cliente o vendedor"
        search.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = search
    }

    override func viewWillAppear(_ animated: Bool) { super.viewWillAppear(animated); reload() }
    func updateSearchResults(for searchController: UISearchController) { searchText = searchController.searchBar.text ?? ""; applyFilters() }

    private func headerContainer() -> UIView {
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 52))
        statusControl.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(statusControl)
        NSLayoutConstraint.activate([
            statusControl.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            statusControl.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            statusControl.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])
        return container
    }

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
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { visibleSales.count }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? { "\(visibleSales.count) operaciones" }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sale = visibleSales[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "sale", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = "\(sale.producto.nombre) · \(sale.total.soles)"
        let status = sale.anulada ? "ANULADA" : "Vigente"
        content.secondaryText = "\(sale.cliente.nombre) · \(sale.vendedor.nombre)\n\(sale.fecha.saleDateText) · \(status)"
        content.secondaryTextProperties.numberOfLines = 2
        content.image = UIImage(systemName: sale.anulada ? "xmark.circle.fill" : "checkmark.circle.fill")
        content.imageProperties.tintColor = sale.anulada ? .systemRed : .systemGreen
        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(SaleDetailViewController(sale: visibleSales[indexPath.row], allowsCancellation: !onlyCurrentSeller), animated: true)
    }
}

final class SaleDetailViewController: UIViewController {
    private let service = SaleService()
    private let sale: Venta
    private let allowsCancellation: Bool
    private let statusLabel = FormFactory.label("")
    private let cancellationLabel = FormFactory.label("", color: .systemRed)
    private var cancelButton: UIButton?

    init(sale: Venta, allowsCancellation: Bool) {
        self.sale = sale; self.allowsCancellation = allowsCancellation
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { nil }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detalle de venta"
        view.backgroundColor = .systemGroupedBackground
        configureLayout(); refreshStatus()
    }

    private func configureLayout() {
        let subtotal = sale.precioUnitario * Double(sale.cantidad)
        let rows = [
            detailRow("Fecha", sale.fecha.saleDateText), detailRow("Vendedor", sale.vendedor.nombre),
            detailRow("Cliente", sale.cliente.nombre), detailRow("Producto", sale.producto.nombre),
            detailRow("Cantidad", String(sale.cantidad)), detailRow("Precio unitario", sale.precioUnitario.soles),
            detailRow("Subtotal", subtotal.soles), detailRow("Descuento", sale.descuento.soles),
            detailRow("IGV", sale.igv.soles), detailRow("TOTAL", sale.total.soles, bold: true)
        ]
        let details = UIStackView(arrangedSubviews: rows)
        details.axis = .vertical; details.spacing = 12
        var views: [UIView] = [statusLabel, details, cancellationLabel]
        if allowsCancellation {
            var configuration = UIButton.Configuration.filled()
            configuration.title = "Anular venta"; configuration.baseBackgroundColor = .systemRed
            let button = UIButton(configuration: configuration, primaryAction: UIAction { [weak self] _ in self?.askCancellationReason() })
            button.heightAnchor.constraint(equalToConstant: 48).isActive = true
            cancelButton = button; views.append(button)
        }
        let stack = UIStackView(arrangedSubviews: views)
        stack.axis = .vertical; stack.spacing = 20; stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }

    private func detailRow(_ name: String, _ value: String, bold: Bool = false) -> UIView {
        let left = FormFactory.label(name, weight: bold ? .bold : .regular, color: bold ? .label : .secondaryLabel)
        let right = FormFactory.label(value, weight: bold ? .bold : .semibold)
        right.textAlignment = .right
        let row = UIStackView(arrangedSubviews: [left, right]); row.distribution = .fillEqually
        return row
    }

    private func refreshStatus() {
        statusLabel.text = sale.anulada ? "● VENTA ANULADA" : "● VENTA VIGENTE"
        statusLabel.textColor = sale.anulada ? .systemRed : .systemGreen
        statusLabel.font = .boldSystemFont(ofSize: 18)
        cancellationLabel.text = sale.anulada ? "Motivo: \(sale.motivoAnulacion ?? "No indicado")" : ""
        cancelButton?.isHidden = sale.anulada
    }

    private func askCancellationReason() {
        let alert = UIAlertController(title: "Anular venta", message: "Indica el motivo. El stock será repuesto.", preferredStyle: .alert)
        alert.addTextField { $0.placeholder = "Motivo obligatorio" }
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        alert.addAction(UIAlertAction(title: "Anular", style: .destructive) { [weak self, weak alert] _ in
            guard let self else { return }
            do { try service.cancel(sale, reason: alert?.textFields?.first?.text ?? ""); refreshStatus() }
            catch { presentAlert(title: "No se pudo anular", message: error.localizedDescription) }
        })
        present(alert, animated: true)
    }
}
