import UIKit

class BookList: UIViewController {
    
    var tableView = UITableView()
    var books: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Legendary Books"
        books = fetchData()
        configureTableView()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 100
        tableView.register(BookCell.self, forCellReuseIdentifier: "BookCell") 
        tableView.pin(to: view)
    }

    func setTableViewDelegates(){
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension BookList: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell") as! BookCell
        let book = books[indexPath.row]
        cell.set(book: book)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBook = books[indexPath.row]
        let detailVC = BookDetails(book: selectedBook)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension BookList {
    
    func fetchData() -> [Book] {
        let book1 = Book(image: UIImage._1984, title: "1984", author: "Джордж Оруэлл", genre: "Антиутопия, Политическая фантастика", releaseYear: 1949)
        let book2 = Book(image: UIImage.toKillAMockingbird, title: "Убить пересмешника", author: "Харпер Ли", genre: "Южный готик, Драма", releaseYear: 1960)
        let book3 = Book(image: UIImage.theGreatGatsby, title: "Великий Гэтсби", author: "Фрэнсис Скотт Фицджеральд", genre: "Трагедия, Реализм", releaseYear: 1925)
        let book4 = Book(image: UIImage.mobyDick, title: "Моби Дик", author: "Герман Мелвилл", genre: "Приключения, Эпопея", releaseYear: 1851)
        let book5 = Book(image: UIImage.prideAndPrejudice, title: "Гордость и предубеждение", author: "Джейн Остин", genre: "Романтическая фантастика", releaseYear: 1813)
        let book6 = Book(image: UIImage.wardNo6, title: "Палата номер 6", author: "Антон Чехов", genre: "Драма", releaseYear: 1892)
        let book7 = Book(image: UIImage.warAndPeace, title: "Война и мир", author: "Лев Толстой", genre: "Историческая фантастика", releaseYear: 1869)
        let book8 = Book(image: UIImage.crimeAndPunishment, title: "Преступление и наказание", author: "Федор Достоевский", genre: "Философская фантастика, Психологическая фантастика", releaseYear: 1866)
        
        return [book1, book2, book3, book4, book5, book6, book7, book8]
    }
}
