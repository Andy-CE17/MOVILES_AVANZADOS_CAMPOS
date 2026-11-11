import UIKit

final class ClientsViewController: UITableViewController, UISearchResultsUpdating {
    private let service = CatalogService()
    private var clients: [Cliente] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Clientes"
        applyProfessionalTableStyle()
        tableView.separatorStyle = .none
        tableView.rowHeight = 100
        tableView.tableHeaderView = ScreenHeaderView(title: "Cartera de clientes", subtitle: "Consulta su categoría y compras acumuladas", icon: "person.2.fill")
        tableView.tableHeaderView?.frame.size.height = 112
        navigationItem.largeTitleDisplayMode = .always
        tableView.register(ClientCardCell.self, forCellReuseIdentifier: "client")
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = search
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: UIAction { [weak self] _ in self?.showEditor(nil) })
    }

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
        navigationController?.pushViewController(ClientFormViewController(client: client), animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { clients.count }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let client = clients[indexPath.row]
        let total = service.validTotal(for: client).formatted(.currency(code: "PEN"))
        let cell = tableView.dequeueReusableCell(withIdentifier: "client", for: indexPath) as! ClientCardCell
        cell.configure(client: client, category: service.category(for: client), total: total)
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

final class ClientCardCell: UITableViewCell {
    private let card = CardView()
    private let iconView = UIImageView()
    private let nameLabel = FormFactory.label("", weight: .bold)
    private let documentLabel = FormFactory.label("", style: .subheadline, color: .secondaryLabel)
    private let totalLabel = FormFactory.label("", style: .subheadline, weight: .semibold, color: AppTheme.primary)
    private let categoryLabel = PillLabel(text: "", color: AppTheme.primary)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear; selectionStyle = .none
        card.translatesAutoresizingMaskIntoConstraints = false
        iconView.contentMode = .scaleAspectFit; iconView.backgroundColor = AppTheme.primary.withAlphaComponent(0.10); iconView.layer.cornerRadius = 22
        iconView.translatesAutoresizingMaskIntoConstraints = false
        let texts = UIStackView(arrangedSubviews: [nameLabel, documentLabel, totalLabel]); texts.axis = .vertical; texts.spacing = 3
        let row = UIStackView(arrangedSubviews: [iconView, texts, categoryLabel]); row.axis = .horizontal; row.alignment = .center; row.spacing = 12
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

    func configure(client: Cliente, category: String, total: String) {
        let vip = category == "VIP"
        nameLabel.text = client.nombre
        documentLabel.text = "Documento: \(client.documento)"
        totalLabel.text = "Compras: \(total)"
        categoryLabel.text = category
        categoryLabel.textColor = vip ? AppTheme.accent : AppTheme.primary
        categoryLabel.backgroundColor = (vip ? AppTheme.accent : AppTheme.primary).withAlphaComponent(0.12)
        iconView.image = UIImage(systemName: vip ? "star.fill" : "person.fill")
        iconView.tintColor = vip ? AppTheme.accent : AppTheme.primary
    }
}

final class ClientFormViewController: UIViewController {
    private let service = CatalogService()
    private let client: Cliente?
    private let nameField = FormFactory.textField(placeholder: "Nombre completo")
    private let documentField = FormFactory.textField(placeholder: "Documento")

    init(client: Cliente?) { self.client = client; super.init(nibName: nil, bundle: nil) }
    required init?(coder: NSCoder) { nil }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = client == nil ? "Nuevo cliente" : "Editar cliente"
        view.backgroundColor = AppTheme.background
        documentField.keyboardType = .numberPad
        nameField.text = client?.nombre
        documentField.text = client?.documento
        let save = FormFactory.primaryButton(title: "Guardar", action: UIAction { [weak self] _ in self?.save() })
        let stack = UIStackView(arrangedSubviews: [nameField, documentField, save])
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
            try service.saveClient(client, name: nameField.text ?? "", document: documentField.text ?? "")
            navigationController?.popViewController(animated: true)
        } catch { presentAlert(title: "Datos inválidos", message: error.localizedDescription) }
    }
}
