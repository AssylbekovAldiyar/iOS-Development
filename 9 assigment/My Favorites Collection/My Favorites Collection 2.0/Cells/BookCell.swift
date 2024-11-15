import UIKit

class BookCell: UITableViewCell {
    
    var bookImageView = UIImageView()
    var bookTitleLabel = UILabel()
    var bookAuthorLabel = UILabel()
    var bookGenreLabel = UILabel()
    var bookReleaseYearLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(bookImageView)
        addSubview(bookTitleLabel)
        addSubview(bookAuthorLabel)
        addSubview(bookGenreLabel)
        addSubview(bookReleaseYearLabel)
        
        configureImageView()
        configureTitleLabel()
        configureAuthorLabel()
        configureGenreLabel()
        configureReleaseYearLabel()
        
        setImageConstraints()
        setTitleLabelConstraints()
        setAuthorLabelConstraints()
        setGenreLabelConstraints()
        setReleaseYearLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(book: Book) {
        bookImageView.image = book.image
        bookTitleLabel.text = book.title
        bookAuthorLabel.text = "Автор: \(book.author)"
        bookGenreLabel.text = "Жанр: \(book.genre)"
        bookReleaseYearLabel.text = "Год: \(book.releaseYear)"
    }
    
    func configureImageView() {
        bookImageView.layer.cornerRadius = 10
        bookImageView.clipsToBounds = true
        bookImageView.contentMode = .scaleAspectFit
    }
    
    func configureTitleLabel() {
        bookTitleLabel.numberOfLines = 0
        bookTitleLabel.adjustsFontSizeToFitWidth = true
    }
    
    func configureAuthorLabel() {
        bookAuthorLabel.font = UIFont.systemFont(ofSize: 14)
        bookAuthorLabel.textColor = .darkGray
    }
    
    func configureGenreLabel() {
        bookGenreLabel.font = UIFont.systemFont(ofSize: 14)
        bookGenreLabel.textColor = .lightGray
    }

    func configureReleaseYearLabel() {
        bookReleaseYearLabel.font = UIFont.systemFont(ofSize: 14)
        bookReleaseYearLabel.textColor = .darkGray
    }
    
    func setImageConstraints() {
        bookImageView.translatesAutoresizingMaskIntoConstraints = false
        bookImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        bookImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        bookImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        bookImageView.widthAnchor.constraint(equalTo: bookImageView.heightAnchor, multiplier: 2/3).isActive = true
    }
    
    func setTitleLabelConstraints() {
        bookTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        bookTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        bookTitleLabel.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: 20).isActive = true
        bookTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }
    
    func setAuthorLabelConstraints() {
        bookAuthorLabel.translatesAutoresizingMaskIntoConstraints = false
        bookAuthorLabel.topAnchor.constraint(equalTo: bookTitleLabel.bottomAnchor, constant: 5).isActive = true
        bookAuthorLabel.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: 20).isActive = true
        bookAuthorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }
    
    func setGenreLabelConstraints() {
        bookGenreLabel.translatesAutoresizingMaskIntoConstraints = false
        bookGenreLabel.topAnchor.constraint(equalTo: bookAuthorLabel.bottomAnchor, constant: 5).isActive = true
        bookGenreLabel.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: 20).isActive = true
        bookGenreLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }
    
    func setReleaseYearLabelConstraints() {
        bookReleaseYearLabel.translatesAutoresizingMaskIntoConstraints = false
        bookReleaseYearLabel.topAnchor.constraint(equalTo: bookGenreLabel.bottomAnchor, constant: 5).isActive = true
        bookReleaseYearLabel.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: 20).isActive = true
        bookReleaseYearLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        bookReleaseYearLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }
}
