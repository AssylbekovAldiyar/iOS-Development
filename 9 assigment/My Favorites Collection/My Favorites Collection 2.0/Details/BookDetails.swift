import UIKit

class BookDetails: UIViewController {
    
    var book: Book
    
    init(book: Book) {
        self.book = book
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var bookImageView: UIImageView!
    var bookTitleLabel: UILabel!
    var bookAuthorLabel: UILabel!
    var bookGenreLabel: UILabel!
    var bookReleaseYearLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        displayBookDetails()
    }
    
    func setupUI() {
        bookImageView = UIImageView()
        bookTitleLabel = UILabel()
        bookAuthorLabel = UILabel()
        bookGenreLabel = UILabel()
        bookReleaseYearLabel = UILabel()
        
        bookImageView.translatesAutoresizingMaskIntoConstraints = false
        bookTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        bookAuthorLabel.translatesAutoresizingMaskIntoConstraints = false
        bookGenreLabel.translatesAutoresizingMaskIntoConstraints = false
        bookReleaseYearLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(bookImageView)
        view.addSubview(bookTitleLabel)
        view.addSubview(bookAuthorLabel)
        view.addSubview(bookGenreLabel)
        view.addSubview(bookReleaseYearLabel)
        
        setConstraints()
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            bookImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            bookImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bookImageView.heightAnchor.constraint(equalToConstant: 200),
            bookImageView.widthAnchor.constraint(equalToConstant: 200),
            
            bookTitleLabel.topAnchor.constraint(equalTo: bookImageView.bottomAnchor, constant: 20),
            bookTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            bookAuthorLabel.topAnchor.constraint(equalTo: bookTitleLabel.bottomAnchor, constant: 10),
            bookAuthorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            bookGenreLabel.topAnchor.constraint(equalTo: bookAuthorLabel.bottomAnchor, constant: 10),
            bookGenreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            bookReleaseYearLabel.topAnchor.constraint(equalTo: bookGenreLabel.bottomAnchor, constant: 10),
            bookReleaseYearLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func displayBookDetails() {
        bookImageView.image = book.image
        bookTitleLabel.text = book.title
        bookAuthorLabel.text = "Author: \(book.author)"
        bookGenreLabel.text = "Genre: \(book.genre)"
        bookReleaseYearLabel.text = "Year of Release: \(book.releaseYear)" 
    }
}
