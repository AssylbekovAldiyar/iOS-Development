
import UIKit

class ViewController: UIViewController {
    
    var nameLabel: UILabel!
    var fullNameLabel: UILabel!
    var alterEgosLabel: UILabel!
    var placeOfBirthLabel: UILabel!
    var firstAppearanceLabel: UILabel!
    var publisherLabel: UILabel!
    var powerLabel: UILabel!
    var speedLabel: UILabel!
    var intelligenceLabel: UILabel!
    var imageView: UIImageView!
    var randomizeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        fetchSuperHeroData(id: Int.random(in: 1...700))
    }
    
    func fetchSuperHeroData(id: Int) {
        let url = "https://akabab.github.io/superhero-api/api/id/\(id).json"
        
        fetchData(from: url) { [weak self] result, error in
            if let error = error {
                print("Ошибка при получении данных: \(error.localizedDescription)")
            } else if let result = result {
                self?.updateUI(with: result)
            }
        }
    }
    
    func updateUI(with hero: SuperHero) {
        UIView.animate(withDuration: 1, animations: {
            self.setUIElementsAlpha(to: 0)
        }) { _ in
            self.nameLabel.text = "Name: \(hero.name)"
            self.fullNameLabel.text = "Full Name: \(hero.biography.fullName)"
            self.alterEgosLabel.text = "Alter Egos: \(hero.biography.alterEgos)"
            self.placeOfBirthLabel.text = "Place of Birth: \(hero.biography.placeOfBirth)"
            self.firstAppearanceLabel.text = "First Appearance: \(hero.biography.firstAppearance)"
            self.publisherLabel.text = "Publisher: \(hero.biography.publisher)"
            self.powerLabel.text = "Power: \(hero.powerstats.power)"
            self.speedLabel.text = "Speed: \(hero.powerstats.speed)"
            self.intelligenceLabel.text = "Intelligence: \(hero.powerstats.intelligence)"
            
            if let url = URL(string: hero.images.md) {
                self.loadImage(from: url)
            }
            
            UIView.animate(withDuration: 1) {
                self.setUIElementsAlpha(to: 1)
            }
        }
    }
    
    func setUIElementsAlpha(to alpha: CGFloat) {
        nameLabel.alpha = alpha
        fullNameLabel.alpha = alpha
        alterEgosLabel.alpha = alpha
        placeOfBirthLabel.alpha = alpha
        firstAppearanceLabel.alpha = alpha
        publisherLabel.alpha = alpha
        powerLabel.alpha = alpha
        speedLabel.alpha = alpha
        intelligenceLabel.alpha = alpha
        imageView.alpha = alpha
    }
    
    func configureViews() {
        view.backgroundColor = .white
        
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.boldSystemFont(ofSize: 28)
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        
        fullNameLabel = UILabel()
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        fullNameLabel.font = UIFont.systemFont(ofSize: 22)
        fullNameLabel.numberOfLines = 0
        fullNameLabel.textAlignment = .center
        
        alterEgosLabel = UILabel()
        alterEgosLabel.translatesAutoresizingMaskIntoConstraints = false
        alterEgosLabel.font = UIFont.systemFont(ofSize: 22)
        alterEgosLabel.numberOfLines = 0
        
        placeOfBirthLabel = UILabel()
        placeOfBirthLabel.translatesAutoresizingMaskIntoConstraints = false
        placeOfBirthLabel.font = UIFont.systemFont(ofSize: 22)
        placeOfBirthLabel.numberOfLines = 0
        
        firstAppearanceLabel = UILabel()
        firstAppearanceLabel.translatesAutoresizingMaskIntoConstraints = false
        firstAppearanceLabel.font = UIFont.systemFont(ofSize: 22)
        firstAppearanceLabel.numberOfLines = 0
        
        publisherLabel = UILabel()
        publisherLabel.translatesAutoresizingMaskIntoConstraints = false
        publisherLabel.font = UIFont.systemFont(ofSize: 22)
        publisherLabel.numberOfLines = 0
        
        powerLabel = UILabel()
        powerLabel.translatesAutoresizingMaskIntoConstraints = false
        powerLabel.font = UIFont.systemFont(ofSize: 22)
        powerLabel.numberOfLines = 0
        
        speedLabel = UILabel()
        speedLabel.translatesAutoresizingMaskIntoConstraints = false
        speedLabel.font = UIFont.systemFont(ofSize: 22)
        speedLabel.numberOfLines = 0
        
        intelligenceLabel = UILabel()
        intelligenceLabel.translatesAutoresizingMaskIntoConstraints = false
        intelligenceLabel.font = UIFont.systemFont(ofSize: 22)
        intelligenceLabel.numberOfLines = 0
        
        randomizeButton = UIButton(type: .system)
        randomizeButton.translatesAutoresizingMaskIntoConstraints = false
        randomizeButton.setTitle("Get New Hero", for: .normal)
        randomizeButton.backgroundColor = .systemBlue
        randomizeButton.setTitleColor(.white, for: .normal)
        randomizeButton.layer.cornerRadius = 8
        randomizeButton.addTarget(self, action: #selector(randomizeAction), for: .touchUpInside)
        
        view.addSubview(imageView)
        view.addSubview(nameLabel)
        view.addSubview(fullNameLabel)
        view.addSubview(alterEgosLabel)
        view.addSubview(placeOfBirthLabel)
        view.addSubview(firstAppearanceLabel)
        view.addSubview(publisherLabel)
        view.addSubview(powerLabel)
        view.addSubview(speedLabel)
        view.addSubview(intelligenceLabel)
        view.addSubview(randomizeButton)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 120),
            imageView.heightAnchor.constraint(equalToConstant: 120),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            fullNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            fullNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            fullNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            alterEgosLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 10),
            alterEgosLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            alterEgosLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            placeOfBirthLabel.topAnchor.constraint(equalTo: alterEgosLabel.bottomAnchor, constant: 10),
            placeOfBirthLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            placeOfBirthLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            firstAppearanceLabel.topAnchor.constraint(equalTo: placeOfBirthLabel.bottomAnchor, constant: 10),
            firstAppearanceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            firstAppearanceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            publisherLabel.topAnchor.constraint(equalTo: firstAppearanceLabel.bottomAnchor, constant: 10),
            publisherLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            publisherLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            powerLabel.topAnchor.constraint(equalTo: publisherLabel.bottomAnchor, constant: 10),
            powerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            powerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            speedLabel.topAnchor.constraint(equalTo: powerLabel.bottomAnchor, constant: 10),
            speedLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            speedLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            intelligenceLabel.topAnchor.constraint(equalTo: speedLabel.bottomAnchor, constant: 10),
            intelligenceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            intelligenceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            randomizeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            randomizeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            randomizeButton.widthAnchor.constraint(equalToConstant: 200),
            randomizeButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func randomizeAction() {
        fetchSuperHeroData(id: Int.random(in: 1...700))
    }
    
    func loadImage(from url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
                
            }
        }
    }
}
