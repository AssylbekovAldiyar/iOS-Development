import UIKit

extension UIViewController {
    func showSuccessAlert(withTitle title: String? = nil, message: String? = nil) {
        let alert = UIAlertController(
            title: title ?? "-",
            message:
                message ?? "-",
            preferredStyle: .alert
        )

        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    func showAlert(message: String) {
        let alert = UIAlertController(
            title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

}
