import FirebaseAuth
import FirebaseFirestore
import UIKit

class DashboardViewController: UIViewController {
    private var categories: [Category] = []
    private var balances: [Balance] = []
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Dashboard"
//        NotificationCenter.default.addObserver(self, selector: #selector(dataUpdated), name: NSNotification.Name("DataUpdated"), object: nil)
        NotificationCenter.default.addObserver(forName: NSNotification.Name("DataUpdated"), object: nil, queue: .main) { [weak self] _ in
            self?.fetchData()
        }
        setupUI()
        fetchData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private func setupUI() {
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }

    private func fetchData() {
        guard let userId = Auth.auth().currentUser?.uid else { return }

        showLoading(withText: "fetching data")
        let dispatchGroup = DispatchGroup()

        dispatchGroup.enter()
        BalanceManager.shared.fetchBalances(userId: userId) {
            [weak self] result in
            switch result {
            case .success(let balances):
                self?.balances = balances
                self?.tableView.reloadData()
            case .failure(let error):
                print("Error fetching balances: \(error.localizedDescription)")
            }
            dispatchGroup.leave()
        }

        dispatchGroup.enter()
        CategoryManager.shared.fetchCategories(userId: userId) {
            [weak self] result in
            switch result {
            case .success(let categories):
                self?.categories = categories
                self?.tableView.reloadData()
            case .failure(let error):
                print(
                    "Error fetching categories: \(error.localizedDescription)")
            }
            dispatchGroup.leave()
        }

        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.hideLoading()
        }
    }
    
    @objc private func dataUpdated() {
        fetchData()
    }
}

extension DashboardViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return section == 0 ? balances.count : categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell", for: indexPath)
        if indexPath.section == 0 {
            let balance = balances[indexPath.row]
            cell.textLabel?.text = "\(balance.name): $\(balance.amount)"
        } else {
            let category = categories[indexPath.row]
            cell.textLabel?.text = category.name
            cell.textLabel?.textColor = UIColor.hexStringToUIColor(hex: category.color)
        }
        return cell
    }

    func tableView(
        _ tableView: UITableView, viewForHeaderInSection section: Int
    ) -> UIView? {
        let view = UIView()

        let option = section == 0 ? "Balances" : "Categories"

        let titleLabel = UILabel()
        titleLabel.frame = CGRect(x: 11, y: 12, width: 170, height: 18)
        titleLabel.text = option
        titleLabel.font = titleLabel.font.withSize(16)

        let button = UIButton(type: .system)
        button.setTitle("Add \(option)", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.frame = CGRect(x: 270, y: 14, width: 120, height: 12)
        button.tag = section
        button.addTarget(
            self, action: #selector(addBalanceOrCetegory), for: .touchUpInside)

        view.addSubview(titleLabel)
        view.addSubview(button)

        return view
    }

    @objc func addBalanceOrCetegory(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            navigationController?.pushViewController(
                AddBalanceViewController(), animated: true)
        case 1:
            navigationController?.pushViewController(
                AddCategoryViewController(), animated: true)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        switch indexPath.section {
        case 0:
            let balance = balances[indexPath.row]
            let vc = BalanceDetailViewController()
            vc.balance = balance
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            let category = categories[indexPath.row]
            let vc = CategoryDetailViewController()
            vc.category = category
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle != .delete {
            return
        }
        guard let userId = UserManager.shared.getUser()?.uid else {
            return
        }
        
        switch indexPath.section {
        case 0:
            let balance = balances[indexPath.row]
            BalanceManager.shared.deleteBalance(userId: userId, balanceId: balance.id, completion: { [weak self] result in
                switch result {
                case .success:
                    self?.fetchData()
                case .failure:
                    self?.showAlert(message: "Error deleting balance")
                }
            })
        case 1:
            let category = categories[indexPath.row]
            CategoryManager.shared.deleteCategory(userId: userId, categoryId: category.id, completion: { [weak self] result in
                switch result {
                case .success:
                    self?.fetchData()
                case .failure:
                    self?.showAlert(message: "Error deleting category")
                }
            })
        default:
            break
        }
    }
}
