import FirebaseAuth
import Hero
import UIKit

class SignupViewController: UIViewController {
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.heroID = "Email"
        return textField
    }()

    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.heroID = "Password"
        return textField
    }()

    private let confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Confirm Password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()

    private let signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.heroID = "loginSignUp"
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Sign Up"
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        enableHero()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        disableHero()
    }

    private func setupUI() {
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(confirmPasswordTextField)
        view.addSubview(signupButton)

        emailTextField.frame = CGRect(
            x: 40, y: 200, width: view.frame.size.width - 80, height: 40)
        passwordTextField.frame = CGRect(
            x: 40, y: 250, width: view.frame.size.width - 80, height: 40)
        confirmPasswordTextField.frame = CGRect(
            x: 40, y: 300, width: view.frame.size.width - 80, height: 40)
        signupButton.frame = CGRect(
            x: 40, y: 360, width: view.frame.size.width - 80, height: 50)

        signupButton.addTarget(
            self, action: #selector(didTapSignUp), for: .touchUpInside)
    }

    @objc private func didTapSignUp() {
        guard
            let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty,
            let confirmPassword = confirmPasswordTextField.text,
            !confirmPassword.isEmpty
        else {
            showAlert(message: "Please fill in all fields.")
            return
        }

        guard password == confirmPassword else {
            showAlert(message: "Passwords do not match.")
            return
        }

        showLoading(withText: "Signing up...")

        AuthManager.shared.createNewUser(
            email: email, password: password
        ) { [weak self] result in
            DispatchQueue.main.async {
                self?.hideLoading()

                switch result {
                case .success():
                    self?.showSuccessAlert(withTitle: "Successefully signed up!", message: "You can now log in.")
                    self?.hero.modalAnimationType = .slide(direction: .right)
                    self?.navigationController?.popViewController(animated: true)
                case .failure(let error):
                    self?.showAlert(message: error.localizedDescription)
                }
            }
        }
    }
}
