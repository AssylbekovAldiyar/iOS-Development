import FirebaseAuth
import Hero
import UIKit

class LoginViewController: UIViewController {
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

    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.heroID = "loginSignUp"
        return button
    }()

    private let signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Login"
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
        view.addSubview(loginButton)
        view.addSubview(signupButton)

        emailTextField.frame = CGRect(
            x: 40, y: 200, width: view.frame.size.width - 80, height: 40)
        passwordTextField.frame = CGRect(
            x: 40, y: 250, width: view.frame.size.width - 80, height: 40)
        loginButton.frame = CGRect(
            x: 40, y: 300, width: view.frame.size.width - 80, height: 50)
        signupButton.frame = CGRect(
            x: 40, y: 360, width: view.frame.size.width - 80, height: 30)

        loginButton.addTarget(
            self, action: #selector(didTapLogin), for: .touchUpInside)
        signupButton.addTarget(
            self, action: #selector(didTapSignup), for: .touchUpInside)
    }

    @objc private func didTapLogin() {
        guard let email = emailTextField.text,
            let password = passwordTextField.text,
            !email.isEmpty, !password.isEmpty
        else {
            showAlert(message: "Please enter email and password.")
            return
        }

        showLoading(withText: "Login...")

        AuthManager.shared.login(email: email, password: password) {
            [weak self] result in
            self?.hideLoading()
            switch result {
            case .success():
                self?.showSuccessAlert(withTitle: "Logged In Successfully")
                self?.transitionToHome()
                UserManager.shared.updateUser()
            case .failure(let error):
                self?.showAlert(message: error.localizedDescription)
            }
        }

    }

    @objc private func didTapSignup() {
        let signupVC = SignupViewController()
        signupVC.hero.isEnabled = true
        signupVC.hero.modalAnimationType = .slide(direction: .left)
        showHero(signupVC)

    }

    private func transitionToHome() {
        guard
            let sceneDelegate = UIApplication.shared.connectedScenes.first?
                .delegate as? SceneDelegate
        else { return }
        let homeVC = CustomTabBarController()
        homeVC.hero.isEnabled = true
        homeVC.hero.modalAnimationType = .fade
        sceneDelegate.window?.rootViewController = homeVC
    }

}
