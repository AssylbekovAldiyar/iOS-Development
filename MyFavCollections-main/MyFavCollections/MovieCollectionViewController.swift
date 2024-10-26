//
//  MovieCollectionViewController.swift
//  MyFavCollections
//
//  Created by Zholbarys on 25.10.2024.
//

import UIKit

struct Movie {
    let title: String
    let year: Int
    let genre: String
    let posterName: String
}

class MovieCollectionViewController: UIViewController {
    private var collectionView: UICollectionView!
    private let movies: [Movie] = [
        Movie(title: "Inception", year: 2010, genre: "Sci-Fi", posterName: "inception"),
        Movie(title: "The Dark Knight", year: 2008, genre: "Action", posterName: "dark_knight"),
        Movie(title: "Pulp Fiction", year: 1994, genre: "Crime", posterName: "pulp_fiction"),
        Movie(title: "The Matrix", year: 1999, genre: "Sci-Fi", posterName: "matrix"),
        Movie(title: "Forrest Gump", year: 1994, genre: "Drama", posterName: "forrest_gump"),
        Movie(title: "Goodfellas", year: 1990, genre: "Crime", posterName: "goodfellas"),
        Movie(title: "The Shawshank Redemption", year: 1994, genre: "Drama", posterName: "shawshank"),
        Movie(title: "Fight Club", year: 1999, genre: "Drama", posterName: "fight_club"),
        Movie(title: "Interstellar", year: 2014, genre: "Sci-Fi", posterName: "interstellar"),
        Movie(title: "The Godfather", year: 1972, genre: "Crime", posterName: "godfather")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = "My Favorite Movies"
        view.backgroundColor = .systemBackground
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        // Calculate item size based on screen width
        let width = (view.frame.width - 50) / 2 // 2 items per row with spacing
        layout.itemSize = CGSize(width: width, height: width * 1.5) // 3:2 aspect ratio
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "MovieCell")
        
        view.addSubview(collectionView)
    }
}

extension MovieCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCollectionViewCell
        let movie = movies[indexPath.item]
        cell.configure(with: movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.item]
        let alert = UIAlertController(title: movie.title,
                                    message: "Released in \(movie.year)\nGenre: \(movie.genre)",
                                    preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

class MovieCollectionViewCell: UICollectionViewCell {
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let yearLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 8
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 4
        contentView.layer.shadowOpacity = 0.1
        
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(yearLabel)
        contentView.addSubview(genreLabel)
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7),
            
            titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            
            yearLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            yearLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            yearLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            
            genreLabel.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: 2),
            genreLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            genreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            genreLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with movie: Movie) {
        titleLabel.text = movie.title
        yearLabel.text = String(movie.year)
        genreLabel.text = movie.genre
        posterImageView.image = UIImage(named: movie.posterName)
    }
}
