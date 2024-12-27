import FirebaseFirestore
import UIKit

class HomeViewController: UIViewController {
    private let db = Firestore.firestore()

    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to the Home Screen!"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()

    private let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Logout", for: .normal)
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        if let user = UserManager.shared.getUser() {
            CategoryManager.shared.fetchCategories(userId: user.uid) { result in
                switch result {
                case .success(let categories):
                    print(categories)
                case .failure(let error):
                    print("Error fetching categories: \(error.localizedDescription)")
                }
            }
        }
        
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
        view.addSubview(welcomeLabel)
        view.addSubview(logoutButton)

        welcomeLabel.frame = CGRect(
            x: 20, y: 200, width: view.frame.size.width - 40, height: 40)
        logoutButton.frame = CGRect(
            x: 40, y: 300, width: view.frame.size.width - 80, height: 50)

        logoutButton.addTarget(
            self, action: #selector(didTapLogout), for: .touchUpInside)
    }

    @objc private func didTapLogout() {
        AuthManager.shared.logout { [weak self] result in
            switch result {
            case .success():
                self?.transitionToLogin()
            case .failure(let error):
                print("Error signing out: \(error.localizedDescription)")
            }
        }
    }

    private func transitionToLogin() {
        guard
            let sceneDelegate = UIApplication.shared.connectedScenes.first?
                .delegate as? SceneDelegate
        else { return }
        let loginVC = LoginViewController()
        sceneDelegate.window?.rootViewController = UINavigationController(
            rootViewController: loginVC)
    }
}
