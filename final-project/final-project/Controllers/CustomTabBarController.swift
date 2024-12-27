import UIKit
import FirebaseAuth

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create instances of view controllers
        let dashboardVC = DashboardViewController()
        dashboardVC.title = "Dashboard"
        dashboardVC.tabBarItem = UITabBarItem(title: "Dashboard", image: UIImage(systemName: "house"), tag: 0)

        let transactionsVC = TransactionHistoryViewController()
        transactionsVC.title = "Transactions"
        transactionsVC.tabBarItem = UITabBarItem(title: "Transactions", image: UIImage(systemName: "list.bullet"), tag: 1)

        let addTransactionVC = AddTransactionViewController()
        addTransactionVC.title = "Add"
        addTransactionVC.tabBarItem = UITabBarItem(title: "Add", image: UIImage(systemName: "plus.circle"), tag: 2)
        
        let settingsVC = SettingsViewController()
        settingsVC.title = "Settings"
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gearshape"), tag: 3)
        
        // Add navigation controllers for each view controller
        let dashboardNav = UINavigationController(rootViewController: dashboardVC)
        let transactionsNav = UINavigationController(rootViewController: transactionsVC)
        let addTransactionNav = UINavigationController(rootViewController: addTransactionVC)
        let settingsNav = UINavigationController(rootViewController: settingsVC)

        // Set view controllers for the tab bar
        viewControllers = [dashboardNav, transactionsNav, addTransactionNav, settingsNav]

    }
}
