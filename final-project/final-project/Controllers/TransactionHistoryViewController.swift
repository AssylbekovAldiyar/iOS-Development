//
//  TransactionHistoryViewController.swift
//  final-project
//
//  Created by Сабир Глаждин on 25.12.2024.
//


import UIKit
import FirebaseAuth
import FirebaseFirestore

class TransactionHistoryViewController: UIViewController {
    private var transactions: [Transaction] = []
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Transaction History"
        
        NotificationCenter.default.addObserver(self, selector: #selector(dataUpdated), name: NSNotification.Name("TransactionAdded"), object: nil)
        
        setupUI()
        fetchTransactions()
    }

    private func setupUI() {
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "transactionCell")
        view.addSubview(tableView)
    }

    private func fetchTransactions() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        self.showLoading(withText: "Loading transactions...")
        TransactionManager.shared.fetchTransactions(userId: userId) { [weak self] result in
            switch result {
            case .success(let transactions):
                self?.transactions = transactions
                self?.tableView.reloadData()
                self?.hideLoading()
            case .failure(let error):
                print("Error fetching transactions: \(error.localizedDescription)")
            }
        }
    }
    
    @objc private func dataUpdated() {
        fetchTransactions()
    }
}

extension TransactionHistoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transactionCell", for: indexPath)
        let transaction = transactions[indexPath.row]
        cell.textLabel?.text = "\(transaction.note): $\(transaction.amount)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let transaction = transactions[indexPath.row]
        let vc = TransactionDetailViewController()
        vc.transaction = transaction
        navigationController?.pushViewController(vc, animated: true)
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
        
        let transaction = transactions[indexPath.row]
        
        TransactionManager.shared.deleteTransaction(userId: userId, transactionId: transaction.id) { [weak self] result in
            switch result {
            case .success():
                self?.fetchTransactions()
            case .failure(let error):
                self?.showAlert(message: error.localizedDescription)
            }
            
        }
    }
}
