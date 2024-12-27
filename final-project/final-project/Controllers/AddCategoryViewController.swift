import FirebaseAuth
import UIKit

class AddCategoryViewController: UIViewController {
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Category Name (e.g., Food, Rent)"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let colorLabel: UILabel = {
        let label = UILabel()
        label.text = "#FFFFFF"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let colorField: UIColorWell = {
        let colorField = UIColorWell()
        colorField.translatesAutoresizingMaskIntoConstraints = false
        return colorField
    }()

    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Add Category"
        setupUI()
    }

    private func setupUI() {
        view.addSubview(nameTextField)
        view.addSubview(colorField)
        view.addSubview(saveButton)
        view.addSubview(colorLabel)

        setupConstraints()

        saveButton.addTarget(
            self, action: #selector(saveCategory), for: .touchUpInside)
        colorField.addTarget(
            self, action: #selector(colorChanged), for: .valueChanged)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Name TextField
            nameTextField.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(
                equalTo: view.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),

            // ColorLabel
            colorLabel.topAnchor.constraint(
                equalTo: nameTextField.bottomAnchor, constant: 20),
            colorLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: 20),
            colorLabel.trailingAnchor.constraint(
                equalTo: colorField.trailingAnchor, constant: -20),
            colorLabel.heightAnchor.constraint(equalToConstant: 40),

            // Color TextField
            colorField.topAnchor.constraint(
                equalTo: nameTextField.bottomAnchor, constant: 20),
            colorField.leadingAnchor.constraint(
                equalTo: colorLabel.leadingAnchor, constant: 20),
            colorField.trailingAnchor.constraint(
                equalTo: view.trailingAnchor, constant: -20),
            colorField.heightAnchor.constraint(equalToConstant: 40),

            // Save Button
            saveButton.topAnchor.constraint(
                equalTo: colorField.bottomAnchor, constant: 30),
            saveButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }

    @objc private func saveCategory() {

        guard let userId = Auth.auth().currentUser?.uid,
            let name = nameTextField.text, !name.isEmpty
        else {
            showAlert(message: "Please enter a category name.")
            return
        }

        let color = colorLabel.text ?? "#FFFFFF"
        let category = Category(id: UUID().uuidString, data: [
            "name": name, "color": color, "amount": 0.0]
            )

        CategoryManager.shared.addCategory(userId: userId, category: category) {
            [weak self] result in
            switch result {
            case .success():
                self?.showSuccessAlert(withTitle: "Category added successfully!")
                NotificationCenter.default.post(name: NSNotification.Name("DataUpdated"), object: nil)
                self?.dismiss(animated: true)
            case .failure(let error):
                print("Error adding category: \(error.localizedDescription)")
                self?.showAlert(
                    message: "Failed to add category. Please try again.")
            }
        }
    }

    @objc private func colorChanged(_ sender: UIColorWell) {
        self.colorLabel.text = sender.selectedColor?.hexString
        self.colorLabel.textColor = sender.selectedColor
    }
}
