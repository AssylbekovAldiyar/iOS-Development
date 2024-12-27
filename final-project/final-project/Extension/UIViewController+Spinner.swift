import UIKit

private var overlayViewKey: UInt8 = 0

extension UIViewController {
    private var overlayView: UIView {
        get {
            if let view = objc_getAssociatedObject(self, &overlayViewKey) as? UIView {
                return view
            } else {
                let view = UIView()
                view.backgroundColor = UIColor.black.withAlphaComponent(0.5) // Semi-transparent
                view.translatesAutoresizingMaskIntoConstraints = false
                objc_setAssociatedObject(self, &overlayViewKey, view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return view
            }
        }
        set {
            objc_setAssociatedObject(self, &overlayViewKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    func showLoading(withText text: String? = nil) {
        DispatchQueue.main.async {
            if self.overlayView.superview == nil {
                self.view.addSubview(self.overlayView)
                NSLayoutConstraint.activate([
                    self.overlayView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                    self.overlayView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                    self.overlayView.topAnchor.constraint(equalTo: self.view.topAnchor),
                    self.overlayView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
                ])
            }

            let loader = UIActivityIndicatorView(style: .large)
            loader.startAnimating()
            loader.translatesAutoresizingMaskIntoConstraints = false
            self.overlayView.addSubview(loader)

            NSLayoutConstraint.activate([
                loader.centerXAnchor.constraint(equalTo: self.overlayView.centerXAnchor),
                loader.centerYAnchor.constraint(equalTo: self.overlayView.centerYAnchor)
            ])

            if let text = text {
                let label = UILabel()
                label.text = text
                label.textColor = .white
                label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
                label.textAlignment = .center
                label.translatesAutoresizingMaskIntoConstraints = false
                self.overlayView.addSubview(label)

                NSLayoutConstraint.activate([
                    label.topAnchor.constraint(equalTo: loader.bottomAnchor, constant: 10),
                    label.centerXAnchor.constraint(equalTo: self.overlayView.centerXAnchor)
                ])
            }
        }
    }

    func hideLoading() {
        DispatchQueue.main.async {
            self.overlayView.removeFromSuperview()
        }
    }
}
