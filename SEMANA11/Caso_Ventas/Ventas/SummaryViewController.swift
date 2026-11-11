import UIKit

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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "summary")
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
            tableView.tableHeaderView = metricsHeader()
            tableView.reloadData()
        } catch { presentAlert(title: "Error", message: error.localizedDescription) }
    }

    private func metricsHeader() -> UIView {
        let income = validSales.reduce(0) { $0 + $1.total }
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 210))
        let title = FormFactory.label("Indicadores generales", style: .title2, weight: .bold)
        let cards = UIStackView(arrangedSubviews: [
            metricCard(value: income.soles, title: "Ingresos", color: .systemGreen),
            metricCard(value: String(validSales.count), title: "Vigentes", color: .systemBlue),
            metricCard(value: String(cancelledSales.count), title: "Anuladas", color: .systemRed)
        ])
        cards.axis = .horizontal; cards.distribution = .fillEqually; cards.spacing = 8
        let stack = UIStackView(arrangedSubviews: [title, cards])
        stack.axis = .vertical; stack.spacing = 14; stack.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: container.topAnchor, constant: 18),
            stack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            cards.heightAnchor.constraint(equalToConstant: 120)
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
            content.imageProperties.tintColor = indexPath.row == 0 ? .systemOrange : .systemGreen
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
