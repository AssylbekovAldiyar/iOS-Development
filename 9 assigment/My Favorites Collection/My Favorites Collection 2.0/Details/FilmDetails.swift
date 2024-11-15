import UIKit

class FilmDetails: UIViewController {
    
    var film: Film
    
    init(film: Film) {
        self.film = film
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var filmImageView: UIImageView!
    var filmTitleLabel: UILabel!
    var filmDirectorLabel: UILabel!
    var filmGenreLabel: UILabel!
    var filmReleaseYearLabel: UILabel! // Новый лейбл для года выпуска
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        displayFilmDetails()
    }
    
    func setupUI() {
        filmImageView = UIImageView()
        filmTitleLabel = UILabel()
        filmDirectorLabel = UILabel()
        filmGenreLabel = UILabel()
        filmReleaseYearLabel = UILabel() // Инициализируем новый лейбл
        
        filmImageView.translatesAutoresizingMaskIntoConstraints = false
        filmTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        filmDirectorLabel.translatesAutoresizingMaskIntoConstraints = false
        filmGenreLabel.translatesAutoresizingMaskIntoConstraints = false
        filmReleaseYearLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(filmImageView)
        view.addSubview(filmTitleLabel)
        view.addSubview(filmDirectorLabel)
        view.addSubview(filmGenreLabel)
        view.addSubview(filmReleaseYearLabel)
        
        setConstraints()
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            filmImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            filmImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            filmImageView.heightAnchor.constraint(equalToConstant: 200),
            filmImageView.widthAnchor.constraint(equalToConstant: 200),
            
            filmTitleLabel.topAnchor.constraint(equalTo: filmImageView.bottomAnchor, constant: 20),
            filmTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            filmDirectorLabel.topAnchor.constraint(equalTo: filmTitleLabel.bottomAnchor, constant: 10),
            filmDirectorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            filmGenreLabel.topAnchor.constraint(equalTo: filmDirectorLabel.bottomAnchor, constant: 10),
            filmGenreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            filmReleaseYearLabel.topAnchor.constraint(equalTo: filmGenreLabel.bottomAnchor, constant: 10),
            filmReleaseYearLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func displayFilmDetails() {
        filmImageView.image = film.image
        filmTitleLabel.text = film.title
        filmDirectorLabel.text = "Режиссер: \(film.director)"
        filmGenreLabel.text = "Жанр: \(film.genre)"
        filmReleaseYearLabel.text = "Год выпуска: \(film.releaseYear)" 
    }
}
