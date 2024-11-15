import UIKit

class FilmCell: UITableViewCell {
    
    var filmImageView = UIImageView()
    var filmTitleLabel = UILabel()
    var filmDirectorLabel = UILabel()
    var filmGenreLabel = UILabel()
    var filmReleaseYearLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(filmImageView)
        addSubview(filmTitleLabel)
        addSubview(filmDirectorLabel)
        addSubview(filmGenreLabel)
        addSubview(filmReleaseYearLabel)
        
        configureImageView()
        configureTitleLabel()
        configureDirectorLabel()
        configureGenreLabel()
        configureReleaseYearLabel()
        
        setImageConstraints()
        setTitleLabelConstraints()
        setDirectorLabelConstraints()
        setGenreLabelConstraints()
        setReleaseYearLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(film: Film) {
        filmImageView.image = film.image
        filmTitleLabel.text = film.title
        filmDirectorLabel.text = "Режиссер: \(film.director)"
        filmGenreLabel.text = "Жанр: \(film.genre)"
        filmReleaseYearLabel.text = "Год выпуска: \(film.releaseYear)" 
    }
    
    func configureImageView() {
        filmImageView.layer.cornerRadius = 10
        filmImageView.clipsToBounds = true
        filmImageView.contentMode = .scaleAspectFit
    }
    
    func configureTitleLabel() {
        filmTitleLabel.numberOfLines = 0
        filmTitleLabel.adjustsFontSizeToFitWidth = true
    }
    
    func configureDirectorLabel() {
        filmDirectorLabel.font = UIFont.systemFont(ofSize: 14)
        filmDirectorLabel.textColor = .darkGray
    }
    
    func configureGenreLabel() {
        filmGenreLabel.font = UIFont.systemFont(ofSize: 14)
        filmGenreLabel.textColor = .lightGray
    }
    
    func configureReleaseYearLabel() {
        filmReleaseYearLabel.font = UIFont.systemFont(ofSize: 14)
        filmReleaseYearLabel.textColor = .gray
    }
    
    func setImageConstraints() {
        filmImageView.translatesAutoresizingMaskIntoConstraints = false
        filmImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        filmImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        filmImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        filmImageView.widthAnchor.constraint(equalTo: filmImageView.heightAnchor, multiplier: 2/3).isActive = true
    }
    
    func setTitleLabelConstraints() {
        filmTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        filmTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        filmTitleLabel.leadingAnchor.constraint(equalTo: filmImageView.trailingAnchor, constant: 20).isActive = true
        filmTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }
    
    func setDirectorLabelConstraints() {
        filmDirectorLabel.translatesAutoresizingMaskIntoConstraints = false
        filmDirectorLabel.topAnchor.constraint(equalTo: filmTitleLabel.bottomAnchor, constant: 5).isActive = true
        filmDirectorLabel.leadingAnchor.constraint(equalTo: filmImageView.trailingAnchor, constant: 20).isActive = true
        filmDirectorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }
    
    func setGenreLabelConstraints() {
        filmGenreLabel.translatesAutoresizingMaskIntoConstraints = false
        filmGenreLabel.topAnchor.constraint(equalTo: filmDirectorLabel.bottomAnchor, constant: 5).isActive = true
        filmGenreLabel.leadingAnchor.constraint(equalTo: filmImageView.trailingAnchor, constant: 20).isActive = true
        filmGenreLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }
    
    func setReleaseYearLabelConstraints() {
        filmReleaseYearLabel.translatesAutoresizingMaskIntoConstraints = false
        filmReleaseYearLabel.topAnchor.constraint(equalTo: filmGenreLabel.bottomAnchor, constant: 5).isActive = true
        filmReleaseYearLabel.leadingAnchor.constraint(equalTo: filmImageView.trailingAnchor, constant: 20).isActive = true
        filmReleaseYearLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        filmReleaseYearLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }
}
