import UIKit
import FirebaseAuth

final class AddTransactionViewController: UIViewController {
    private var categories: [Category] = []
    private var balances: [Balance] = []

    private let amountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Amount"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let categoryPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()

    private let balancePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()

    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()

    private let noteTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Note"
        textField.borderStyle = .roundedRect
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
        title = "Add Transaction"
        setupUI()
        fetchData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(dataUpdated), name: NSNotification.Name("DataUpdated"), object: nil)
    }

    private func setupUI() {
        view.addSubview(amountTextField)
        view.addSubview(categoryPicker)
        view.addSubview(balancePicker)
        view.addSubview(datePicker)
        view.addSubview(noteTextField)
        view.addSubview(saveButton)
        
        balancePicker.dataSource = self
        categoryPicker.dataSource = self
        balancePicker.delegate = self
        categoryPicker.delegate = self
        
        categoryPicker.tag = 1
        balancePicker.tag = 2
        
        setupConstraints()

        saveButton.addTarget(self, action: #selector(saveTransaction), for: .touchUpInside)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Amount TextField
            amountTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            amountTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            amountTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            amountTextField.heightAnchor.constraint(equalToConstant: 40),

            // Category Picker
            categoryPicker.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: 20),
            categoryPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            categoryPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            categoryPicker.heightAnchor.constraint(equalToConstant: 150),

            // Balance Picker
            balancePicker.topAnchor.constraint(equalTo: categoryPicker.bottomAnchor, constant: 20),
            balancePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            balancePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            balancePicker.heightAnchor.constraint(equalToConstant: 150),

            // Date Picker
            datePicker.topAnchor.constraint(equalTo: balancePicker.bottomAnchor, constant: 20),
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            datePicker.heightAnchor.constraint(equalToConstant: 60),

            // Note TextField
            noteTextField.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20),
            noteTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            noteTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            noteTextField.heightAnchor.constraint(equalToConstant: 40),

            // Save Button
            saveButton.topAnchor.constraint(equalTo: noteTextField.bottomAnchor, constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }

    private func fetchData() {
        guard let userId = Auth.auth().currentUser?.uid else { return }

        showLoading(withText: "fetching data")
        let dispatchGroup = DispatchGroup()

        dispatchGroup.enter()
        BalanceManager.shared.fetchBalances(userId: userId) { [weak self] result in
            switch result {
            case .success(let balances):
                self?.balances = balances
            case .failure(let error):
                print("Error fetching balances: \(error.localizedDescription)")
            }
            dispatchGroup.leave()
        }

        dispatchGroup.enter()
        CategoryManager.shared.fetchCategories(userId: userId) { [weak self] result in
            switch result {
            case .success(let categories):
                self?.categories = categories
            case .failure(let error):
                print("Error fetching categories: \(error.localizedDescription)")
            }
            dispatchGroup.leave()
        }

        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.hideLoading()
            self?.categoryPicker.reloadAllComponents()
            self?.balancePicker.reloadAllComponents()
        }
    }

    @objc private func saveTransaction() {
        guard let userId = Auth.auth().currentUser?.uid,
              let amountText = amountTextField.text, let amount = Double(amountText),
              categories.indices.contains(categoryPicker.selectedRow(inComponent: 0)),
              balances.indices.contains(balancePicker.selectedRow(inComponent: 0)) else {
            showAlert(message: "Error: Please fill all fields.")
            return
        }

        let category = categories[categoryPicker.selectedRow(inComponent: 0)]
        let balance = balances[balancePicker.selectedRow(inComponent: 0)]

        let transaction = Transaction(
            id: UUID().uuidString,
            data: [
                "amount": amount,
                "categoryId": category.id,
                "balanceId": balance.id,
                "date": datePicker.date,
                "note": noteTextField.text ?? "",
                "type": "expense"
            ]
        )

        showLoading(withText: "adding Transaction")
        TransactionManager.shared.addTransaction(userId: userId, transaction: transaction) { [weak self] result in
            self?.hideLoading()
            switch result {
            case .success():
                self?.showSuccessAlert(withTitle: "Added Transaction", message: "✅")
                NotificationCenter.default.post(name: NSNotification.Name("DataUpdated"), object: nil)
                NotificationCenter.default.post(name: NSNotification.Name("TransactionAdded"), object: nil)
            case .failure(let error):
                print("Error saving transaction: \(error.localizedDescription)")
            }
        }
    }
    
    @objc private func dataUpdated() {
        fetchData()
    }
}

extension AddTransactionViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return categories.count
        case 2:
            return balances.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return categories[row].name
        case 2:
            return "\(balances[row].name): \(balances[row].amount)"
        default:
            return "123"
        }
    }
    
}
