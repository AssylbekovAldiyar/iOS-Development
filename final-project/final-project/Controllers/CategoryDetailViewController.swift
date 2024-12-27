import UIKit

class CategoryDetailViewController: UIViewController {
    var category: Category?

    private let nameLabel = UILabel()
    private let colorLabel = UILabel()
    private let editCategoryButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Category Details"
        setupUI()
        displayCategoryDetails()
    }

    private func setupUI() {
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        nameLabel.textAlignment = .center
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        colorLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        colorLabel.textAlignment = .center
        colorLabel.translatesAutoresizingMaskIntoConstraints = false

        editCategoryButton.setTitle("Edit Category", for: .normal)
        editCategoryButton.backgroundColor = .systemBlue
        editCategoryButton.setTitleColor(.white, for: .normal)
        editCategoryButton.layer.cornerRadius = 8
        editCategoryButton.translatesAutoresizingMaskIntoConstraints = false
        editCategoryButton.addTarget(self, action: #selector(editCategoryTapped), for: .touchUpInside)

        view.addSubview(nameLabel)
        view.addSubview(colorLabel)
        view.addSubview(editCategoryButton)

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            colorLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            colorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            colorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            editCategoryButton.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 40),
            editCategoryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            editCategoryButton.widthAnchor.constraint(equalToConstant: 200),
            editCategoryButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func displayCategoryDetails() {
        guard let category = category else { return }
        nameLabel.text = "Category Name: \(category.name)"
        colorLabel.text = "Color: \(category.color)"
    }

    @objc private func editCategoryTapped() {
        let alert = UIAlertController(title: "Edit Category", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.text = self.category?.name
            textField.placeholder = "Category Name"
        }
        alert.addTextField { textField in
            textField.text = self.category?.color
            textField.placeholder = "Category Color"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            guard let self = self,
                  let newName = alert.textFields?[0].text,
                  let newColor = alert.textFields?[1].text else { return }
            self.updateCategoryDetails(name: newName, color: newColor)
        })

        present(alert, animated: true)
    }

    private func updateCategoryDetails(name: String, color: String) {
        guard let category = category else { return }
        guard let userId = UserManager.shared.getUser()?.uid else {
            return
        }
        
        let updatedCategory = Category(id: category.id, data: [
            "name": name,
            "color": color
        ])
        CategoryManager.shared.updateCategory(userId: userId, category: updatedCategory) { [weak self] result in
            switch result {
            case .success:
                self?.category?.name = name
                self?.category?.color = color
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DataUpdated"), object: nil)
                self?.displayCategoryDetails()
            case .failure(let error):
                print("Error updating category: \(error.localizedDescription)")
            }
        }
    }
}
