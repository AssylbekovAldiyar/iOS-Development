import UIKit
import FirebaseAuth

class BalanceDetailViewController: UIViewController {
    var balance: Balance?
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name:"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.text = "Amount:"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let amountTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.keyboardType = .decimalPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save Changes", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Balance Details"
        
        setupUI()
        displayBalanceDetails()
    }
    
    private func setupUI() {
        // Add subviews
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(amountLabel)
        view.addSubview(amountTextField)
        view.addSubview(saveButton)
        
        // Layout constraints
        NSLayoutConstraint.activate([
            // Name label
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            // Name textField
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // Amount label
            amountLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            amountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            // Amount textField
            amountTextField.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 8),
            amountTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            amountTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            amountTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // Save button
            saveButton.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: 40),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 200),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        saveButton.addTarget(self, action: #selector(saveChangesTapped), for: .touchUpInside)
    }
    
    private func displayBalanceDetails() {
        guard let balance = balance else { return }
        nameTextField.text = balance.name
        amountTextField.text = "\(balance.amount)"
    }
    
    @objc private func saveChangesTapped() {
        guard let balance = balance else { return }
        guard let newName = nameTextField.text, !newName.isEmpty,
              let amountText = amountTextField.text, let newAmount = Double(amountText) else {
            showAlert(message: "Please fill in all fields correctly.")
            return
        }
        
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        let newBalance = Balance(id: balance.id, data: [
            "name": newName,
            "amount": newAmount
        ])
        
        // Update the balance in the database
        BalanceManager.shared.updateBalance(userId: userId, balance: newBalance) { [weak self] result in
            switch result {
            case .success:
                print("Balance updated successfully!")
                self?.balance?.name = newName
                self?.balance?.amount = newAmount
                NotificationCenter.default.post(name: NSNotification.Name("DataUpdated"), object: nil)
            case .failure(let error):
                print("Error updating balance: \(error.localizedDescription)")
                self?.showAlert(message: "Failed to update balance.")
            }
        }
    }
}

//import UIKit
//import FirebaseAuth
//
//class BalanceDetailViewController: UIViewController {
//    var balance: Balance?
//
//    private let nameLabel = UILabel()
//    private let amountLabel = UILabel()
//    private let updateAmountButton = UIButton()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        title = "Balance Details"
//        setupUI()
//        displayBalanceDetails()
//    }
//
//    private func setupUI() {
//        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
//        nameLabel.textAlignment = .center
//        nameLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        amountLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
//        amountLabel.textAlignment = .center
//        amountLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        updateAmountButton.setTitle("Update Amount", for: .normal)
//        updateAmountButton.backgroundColor = .systemBlue
//        updateAmountButton.setTitleColor(.white, for: .normal)
//        updateAmountButton.layer.cornerRadius = 8
//        updateAmountButton.translatesAutoresizingMaskIntoConstraints = false
//        updateAmountButton.addTarget(self, action: #selector(updateAmountTapped), for: .touchUpInside)
//
//        view.addSubview(nameLabel)
//        view.addSubview(amountLabel)
//        view.addSubview(updateAmountButton)
//
//        NSLayoutConstraint.activate([
//            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
//            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//
//            amountLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
//            amountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            amountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//
//            updateAmountButton.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 40),
//            updateAmountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            updateAmountButton.widthAnchor.constraint(equalToConstant: 200),
//            updateAmountButton.heightAnchor.constraint(equalToConstant: 50)
//        ])
//    }
//
//    private func displayBalanceDetails() {
//        guard let balance = balance else { return }
//        nameLabel.text = "Balance Name: \(balance.name)"
//        amountLabel.text = "Amount: \(balance.amount)"
//    }
//
//    @objc private func updateAmountTapped() {
//        let alert = UIAlertController(title: "Update Amount", message: "Enter new amount", preferredStyle: .alert)
//        alert.addTextField { textField in
//            textField.keyboardType = .decimalPad
//            textField.placeholder = "New Amount"
//        }
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
//        alert.addAction(UIAlertAction(title: "Update", style: .default) { [weak self] _ in
//            guard let self = self,
//                  let text = alert.textFields?.first?.text,
//                  let newAmount = Double(text) else { return }
//            self.updateBalanceAmount(to: newAmount)
//        })
//
//        present(alert, animated: true)
//    }
//
//    private func updateBalanceAmount(to newAmount: Double) {
//        guard let balance = balance else { return }
//        guard let userId = Auth.auth().currentUser?.uid else { return }
//        // Update balance in database
//        BalanceManager.shared.updateBalanceAmount(userId: userId, balanceId: balance.id, newAmount: newAmount) { [weak self] result in
//            switch result {
//            case .success:
//                self?.balance?.amount = newAmount
//
//                self?.displayBalanceDetails()
//            case .failure(let error):
//                print("Error updating balance: \(error.localizedDescription)")
//            }
//        }
//    }
//}
