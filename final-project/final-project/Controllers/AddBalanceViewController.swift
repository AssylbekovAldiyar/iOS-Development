import UIKit
import FirebaseAuth

class AddBalanceViewController: UIViewController {
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Balance Name (e.g., Cash, Bank)"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let amountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Initial Amount"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Add Balance"
        setupUI()
    }

    private func setupUI() {
        view.addSubview(nameTextField)
        view.addSubview(amountTextField)
        view.addSubview(saveButton)

        setupConstraints()

        saveButton.addTarget(self, action: #selector(saveBalance), for: .touchUpInside)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Name TextField
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),

            // Amount TextField
            amountTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            amountTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            amountTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            amountTextField.heightAnchor.constraint(equalToConstant: 40),

            // Save Button
            saveButton.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: 30),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc private func saveBalance() {
        guard let userId = Auth.auth().currentUser?.uid,
              let name = nameTextField.text, !name.isEmpty,
              let amountText = amountTextField.text, let amount = Double(amountText) else {
            showAlert(message: "Please fill all fields.")
            return
        }

        let balance = Balance(id: UUID().uuidString, data: ["name": name, "amount": amount])

        BalanceManager.shared.addBalance(userId: userId, balance: balance) { [weak self] result in
            switch result {
            case .success():
                self?.showSuccessAlert(withTitle: "Balance added successfully!")
                NotificationCenter.default.post(name: NSNotification.Name("DataUpdated"), object: nil)
                self?.dismiss(animated: true)
            case .failure(_):
                self?.showAlert(message: "Failed to add balance. Please try again.")
            }
        }
    }

//    private func showAlert(message: String) {
//        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default))
//        present(alert, animated: true)
//    }
}
