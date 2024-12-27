import UIKit

class TransactionDetailViewController: UIViewController {
    var transaction: Transaction?

    private let amountLabel = UILabel()
    private let categoryLabel = UILabel()
    private let balanceLabel = UILabel()
    private let dateLabel = UILabel()
    private let noteLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Transaction Details"
        setupUI()
        displayTransactionDetails()
    }

    private func setupUI() {
        let labels = [amountLabel, categoryLabel, balanceLabel, dateLabel, noteLabel]
        labels.forEach { label in
            label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
            label.textAlignment = .left
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(label)
        }

        // Layout constraints
        NSLayoutConstraint.activate([
            // Amount Label
            amountLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            amountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            amountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            // Category Label
            categoryLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 16),
            categoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            categoryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            // Balance Label
            balanceLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 16),
            balanceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            balanceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            // Date Label
            dateLabel.topAnchor.constraint(equalTo: balanceLabel.bottomAnchor, constant: 16),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            // Note Label
            noteLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 16),
            noteLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            noteLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

    private func displayTransactionDetails() {
        guard let transaction = transaction else { return }

        amountLabel.text = "Amount: \(transaction.amount)"
        categoryLabel.text = "Category: \(transaction.categoryId)"
        balanceLabel.text = "Balance: \(transaction.balanceId)"
        dateLabel.text = "Date: \(formattedDate(transaction.date))"
        noteLabel.text = "Note: \(transaction.note.isEmpty ? "No Note" : transaction.note)"
    }

    private func formattedDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: date)
    }
}
