import UIKit

class FilmList: UIViewController {
    
    var tableView = UITableView()
    var Films: [Film] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorite old Films"
        Films = fetchData()
        configureTableView()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 100
        tableView.register(FilmCell.self, forCellReuseIdentifier: "FilmCell") 
        tableView.pin(to: view)
    }

    func setTableViewDelegates(){
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension FilmList: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilmCell") as! FilmCell
        let film = Films[indexPath.row]
        cell.set(film: film)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedFilm = Films[indexPath.row]
        let detailVC = FilmDetails(film: selectedFilm)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension FilmList {
    
    func fetchData() -> [Film] {
        let film1 = Film(image: UIImage.interception, title: "Inception", director: "Кристофер Нолан", genre: "Научная фантастика/Триллер", releaseYear: 2010)
        let film2 = Film(image: UIImage.interstellar, title: "Interstellar", director: "Кристофер Нолан", genre: "Научная фантастика/Драма", releaseYear: 2014)
        let film3 = Film(image: UIImage.theDarkKnight, title: "The Dark Knight", director: "Кристофер Нолан", genre: "Боевик/Криминал", releaseYear: 2008)
        let film4 = Film(image: UIImage.thePrestige, title: "The Prestige", director: "Кристофер Нолан", genre: "Драма/Мистика", releaseYear: 2006)
        let film5 = Film(image: UIImage.pulpFiction, title: "Pulp Fiction", director: "Квентин Тарантино", genre: "Криминал/Драма", releaseYear: 1994)
        let film6 = Film(image: UIImage.fightClub, title: "Fight Club", director: "Дэвид Финчер", genre: "Драма/Триллер", releaseYear: 1999)
        let film7 = Film(image: UIImage.matrix, title: "The Matrix", director: "Лана и Лилли Вачовски", genre: "Научная фантастика/Боевик", releaseYear: 1999)
        let film8 = Film(image: UIImage.lordOfTheRings, title: "The Lord of the Rings: The Return of the King", director: "Питер Джексон", genre: "Фэнтези/Приключения", releaseYear: 2003)
        
        return [film1, film2, film3, film4, film5, film6, film7, film8]
    }
}
