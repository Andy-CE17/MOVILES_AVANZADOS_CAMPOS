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
        applyProfessionalTableStyle()
        tableView.separatorStyle = .none
        tableView.rowHeight = 112
        navigationItem.largeTitleDisplayMode = .always
        tableView.register(SaleCardCell.self, forCellReuseIdentifier: "sale")
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
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 168))
        let hero = ScreenHeaderView(
            title: onlyCurrentSeller ? "Historial personal" : "Control de operaciones",
            subtitle: onlyCurrentSeller ? "Revisa las ventas que registraste" : "Supervisa las ventas de todo el equipo",
            icon: onlyCurrentSeller ? "receipt.fill" : "chart.line.uptrend.xyaxis"
        )
        hero.translatesAutoresizingMaskIntoConstraints = false
        statusControl.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(hero)
        container.addSubview(statusControl)
        NSLayoutConstraint.activate([
            hero.topAnchor.constraint(equalTo: container.topAnchor), hero.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            hero.trailingAnchor.constraint(equalTo: container.trailingAnchor), hero.heightAnchor.constraint(equalToConstant: 112),
            statusControl.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            statusControl.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            statusControl.topAnchor.constraint(equalTo: hero.bottomAnchor, constant: 8)
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
        tableView.backgroundView = visibleSales.isEmpty
            ? EmptyStateView(icon: "receipt", title: "Sin operaciones", message: "No hay ventas que coincidan con el filtro seleccionado.")
            : nil
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { visibleSales.count }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? { "\(visibleSales.count) operaciones" }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sale = visibleSales[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "sale", for: indexPath) as! SaleCardCell
        cell.configure(sale: sale)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(SaleDetailViewController(sale: visibleSales[indexPath.row], allowsCancellation: !onlyCurrentSeller), animated: true)
    }
}

final class SaleCardCell: UITableViewCell {
    private let card = CardView()
    private let iconView = UIImageView()
    private let productLabel = FormFactory.label("", weight: .bold)
    private let peopleLabel = FormFactory.label("", style: .subheadline, color: .secondaryLabel)
    private let dateLabel = FormFactory.label("", style: .caption1, color: .secondaryLabel)
    private let totalLabel = FormFactory.label("", weight: .bold, color: AppTheme.primary)
    private let statusLabel = PillLabel(text: "", color: AppTheme.primary)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear; selectionStyle = .none
        card.translatesAutoresizingMaskIntoConstraints = false
        iconView.contentMode = .scaleAspectFit; iconView.layer.cornerRadius = 22; iconView.translatesAutoresizingMaskIntoConstraints = false
        let textStack = UIStackView(arrangedSubviews: [productLabel, peopleLabel, dateLabel]); textStack.axis = .vertical; textStack.spacing = 3
        let right = UIStackView(arrangedSubviews: [totalLabel, statusLabel]); right.axis = .vertical; right.alignment = .trailing; right.spacing = 8
        let row = UIStackView(arrangedSubviews: [iconView, textStack, right]); row.axis = .horizontal; row.alignment = .center; row.spacing = 12
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

    func configure(sale: Venta) {
        let cancelled = sale.anulada
        productLabel.text = sale.producto.nombre
        peopleLabel.text = "\(sale.cliente.nombre) · \(sale.vendedor.nombre)"
        dateLabel.text = sale.fecha.saleDateText
        totalLabel.text = sale.total.soles
        statusLabel.text = cancelled ? "ANULADA" : "VIGENTE"
        statusLabel.textColor = cancelled ? .systemRed : AppTheme.primary
        statusLabel.backgroundColor = (cancelled ? UIColor.systemRed : AppTheme.primary).withAlphaComponent(0.12)
        iconView.image = UIImage(systemName: cancelled ? "xmark.circle.fill" : "checkmark.circle.fill")
        iconView.tintColor = cancelled ? .systemRed : AppTheme.primary
        iconView.backgroundColor = (cancelled ? UIColor.systemRed : AppTheme.primary).withAlphaComponent(0.10)
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
        view.backgroundColor = AppTheme.background
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
        statusLabel.textColor = sale.anulada ? .systemRed : AppTheme.primary
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
