import UIKit

final class SalesListViewController: UITableViewController {
    private let service = SaleService()
    private var sales: [Venta] = []
    private let onlyCurrentSeller: Bool

    init(onlyCurrentSeller: Bool) {
        self.onlyCurrentSeller = onlyCurrentSeller
        super.init(style: .insetGrouped)
    }

    required init?(coder: NSCoder) { nil }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = onlyCurrentSeller ? "Mis ventas" : "Ventas del equipo"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "sale")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reload()
    }

    private func reload() {
        do {
            sales = try service.sales(for: onlyCurrentSeller ? SessionManager.shared.currentUser : nil)
            tableView.reloadData()
        } catch { presentAlert(title: "Error", message: error.localizedDescription) }
    }

    override func numberOfSections(in tableView: UITableView) -> Int { 1 }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { sales.count }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? { "\(sales.count) operaciones" }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sale = sales[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "sale", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = "\(sale.producto.nombre) · \(sale.total.soles)"
        let status = sale.anulada ? "ANULADA" : "Vigente"
        content.secondaryText = "\(sale.cliente.nombre) · \(sale.fecha.saleDateText) · \(status)"
        content.image = UIImage(systemName: sale.anulada ? "xmark.circle.fill" : "checkmark.circle.fill")
        content.imageProperties.tintColor = sale.anulada ? .systemRed : .systemGreen
        cell.contentConfiguration = content
        return cell
    }
}
