import UIKit

final class ClientsViewController: UITableViewController, UISearchResultsUpdating {
    private let service = CatalogService()
    private var clients: [Cliente] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Clientes"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "client")
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = search
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: UIAction { [weak self] _ in self?.showEditor(nil) })
    }

    override func viewWillAppear(_ animated: Bool) { super.viewWillAppear(animated); reload() }
    func updateSearchResults(for searchController: UISearchController) { reload(search: searchController.searchBar.text ?? "") }

    private func reload(search: String = "") {
        do { clients = try service.clients(search: search); tableView.reloadData() }
        catch { presentAlert(title: "Error", message: error.localizedDescription) }
    }

    private func showEditor(_ client: Cliente?) {
        navigationController?.pushViewController(ClientFormViewController(client: client), animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { clients.count }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let client = clients[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "client", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = client.nombre
        let total = service.validTotal(for: client).formatted(.currency(code: "PEN"))
        content.secondaryText = "Doc. \(client.documento)  ·  \(service.category(for: client))  ·  \(total)"
        content.image = UIImage(systemName: service.category(for: client) == "VIP" ? "star.circle.fill" : "person.crop.circle")
        content.imageProperties.tintColor = service.category(for: client) == "VIP" ? .systemOrange : .systemGreen
        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator
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
        view.backgroundColor = .systemGroupedBackground
        documentField.keyboardType = .numberPad
        nameField.text = client?.nombre
        documentField.text = client?.documento
        let save = FormFactory.primaryButton(title: "Guardar", action: UIAction { [weak self] _ in self?.save() })
        let stack = UIStackView(arrangedSubviews: [nameField, documentField, save])
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
            try service.saveClient(client, name: nameField.text ?? "", document: documentField.text ?? "")
            navigationController?.popViewController(animated: true)
        } catch { presentAlert(title: "Datos inválidos", message: error.localizedDescription) }
    }
}
