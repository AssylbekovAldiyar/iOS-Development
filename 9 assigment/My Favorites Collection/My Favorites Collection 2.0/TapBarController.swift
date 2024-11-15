import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setUpTabs()
    }
    
    private func setUpTabs() {
        let gameListVC = GameList()
        let nav1 = UINavigationController(rootViewController: gameListVC)
        nav1.tabBarItem = UITabBarItem(title: "Games", image: UIImage(systemName: "gamecontroller"), tag: 1)
        
        let filmListVC = FilmList()
        let nav2 = UINavigationController(rootViewController: filmListVC)
        nav2.tabBarItem = UITabBarItem(title: "Films", image: UIImage(systemName: "film"), tag: 2)
        
        let booklistVC = BookList()
        let nav3 = UINavigationController(rootViewController: booklistVC)
        nav3.tabBarItem = UITabBarItem(title: "Books", image: UIImage(systemName: "book"), tag: 3)
        
        nav1.navigationBar.prefersLargeTitles = false
        nav2.navigationBar.prefersLargeTitles = false
        nav3.navigationBar.prefersLargeTitles = false
        
        setViewControllers([nav1, nav2, nav3], animated: true)
    }
}
