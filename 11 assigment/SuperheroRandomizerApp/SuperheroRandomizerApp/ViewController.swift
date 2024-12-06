//
//  ViewController.swift
//  SuperheroRandomizerApp
//
//  Created by Nurken on 28.11.2024.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    
    var nameLabel: UILabel!
    var fullNameLabel: UILabel!
    var alterEgosLabel: UILabel!
    var placeOfBirthLabel: UILabel!
    var firstAppearanceLabel: UILabel!
    var publisherLabel: UILabel!
    var intelligenceLabel: UILabel!
    var powerLabel: UILabel!
    var speedLabel: UILabel!
    var durabilityLabel: UILabel!
    var combatLabel: UILabel!
    var imageView: UIImageView!
    var randomizeButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        
        fetchSuperHeroData(id: Int.random(in: 2...655))
        
        
        
    }

    func fetchSuperHeroData(id: Int){
        let url = "https://akabab.github.io/superhero-api/api/id/\(id).json"
        
        
        APIAlamofire.shared.fetchData(from: url) {result in
            switch result {
            case .success(let superHeroResults):
                self.updateUI(with: superHeroResults)
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func updateUI(with hero: SuperHero){
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1, animations: {
                   
                    self.nameLabel.alpha = 0
                    self.fullNameLabel.alpha = 0
                    self.alterEgosLabel.alpha = 0
                    self.placeOfBirthLabel.alpha = 0
                    self.firstAppearanceLabel.alpha = 0
                    self.publisherLabel.alpha = 0
                    self.intelligenceLabel.alpha = 0
                    self.powerLabel.alpha = 0
                    self.speedLabel.alpha = 0
                    self.durabilityLabel.alpha = 0
                    self.combatLabel.alpha = 0
                    self.imageView.alpha = 0
                }, completion: { _ in
                   
                    self.nameLabel.text = "Name: \(hero.name)"
                    self.fullNameLabel.text = "Full Name: \(hero.biography.fullName)"
                    self.alterEgosLabel.text = "Alter Egos: \(hero.biography.alterEgos)"
                    self.placeOfBirthLabel.text = "Place of Birth: \(hero.biography.placeOfBirth)"
                    self.firstAppearanceLabel.text = "First Appearance: \(hero.biography.firstAppearance)"
                    self.publisherLabel.text = "Publisher: \(hero.biography.publisher)"
                    self.intelligenceLabel.text = "Intelligence: \(hero.powerstats.intelligence)"
                    self.powerLabel.text = "Power: \(hero.powerstats.power)"
                    self.speedLabel.text = "Speed: \(hero.powerstats.speed)"
                    self.durabilityLabel.text = "Durability: \(hero.powerstats.durability)"
                    self.combatLabel.text = "Combat: \(hero.powerstats.combat)"
                    
                    if let url = URL(string: hero.images.md) {
                        self.loadImage(from: url)
                    }

                    
                    UIView.animate(withDuration: 1) {
                        self.nameLabel.alpha = 1
                        self.fullNameLabel.alpha = 1
                        self.alterEgosLabel.alpha = 1
                        self.placeOfBirthLabel.alpha = 1
                        self.firstAppearanceLabel.alpha = 1
                        self.publisherLabel.alpha = 1
                        self.intelligenceLabel.alpha = 1
                        self.powerLabel.alpha = 1
                        self.speedLabel.alpha = 1
                        self.durabilityLabel.alpha = 1
                        self.combatLabel.alpha = 1
                        self.imageView.alpha = 1
                    }
                })
        }
        
    }
    
    func configureViews() {
        view.backgroundColor = .white
        
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.boldSystemFont(ofSize: 26)
        nameLabel.numberOfLines = 0

        fullNameLabel = UILabel()
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        fullNameLabel.font = UIFont.systemFont(ofSize: 24)
        fullNameLabel.numberOfLines = 0

        alterEgosLabel = UILabel()
        alterEgosLabel.translatesAutoresizingMaskIntoConstraints = false
        alterEgosLabel.font = UIFont.systemFont(ofSize: 24)
        alterEgosLabel.numberOfLines = 0

        placeOfBirthLabel = UILabel()
        placeOfBirthLabel.translatesAutoresizingMaskIntoConstraints = false
        placeOfBirthLabel.font = UIFont.systemFont(ofSize: 24)
        placeOfBirthLabel.numberOfLines = 0

        firstAppearanceLabel = UILabel()
        firstAppearanceLabel.translatesAutoresizingMaskIntoConstraints = false
        firstAppearanceLabel.font = UIFont.systemFont(ofSize: 24)
        firstAppearanceLabel.numberOfLines = 0

        publisherLabel = UILabel()
        publisherLabel.translatesAutoresizingMaskIntoConstraints = false
        publisherLabel.font = UIFont.systemFont(ofSize: 24)
        publisherLabel.numberOfLines = 0

        intelligenceLabel = UILabel()
        intelligenceLabel.translatesAutoresizingMaskIntoConstraints = false
        intelligenceLabel.font = UIFont.systemFont(ofSize: 24)
        intelligenceLabel.numberOfLines = 0

        powerLabel = UILabel()
        powerLabel.translatesAutoresizingMaskIntoConstraints = false
        powerLabel.font = UIFont.systemFont(ofSize: 24)
        powerLabel.numberOfLines = 0

        speedLabel = UILabel()
        speedLabel.translatesAutoresizingMaskIntoConstraints = false
        speedLabel.font = UIFont.systemFont(ofSize: 24)
        speedLabel.numberOfLines = 0

        durabilityLabel = UILabel()
        durabilityLabel.translatesAutoresizingMaskIntoConstraints = false
        durabilityLabel.font = UIFont.systemFont(ofSize: 24)
        durabilityLabel.numberOfLines = 0

        combatLabel = UILabel()
        combatLabel.translatesAutoresizingMaskIntoConstraints = false
        combatLabel.font = UIFont.systemFont(ofSize: 24)
        combatLabel.numberOfLines = 0

        randomizeButton = UIButton(type: .system)
        randomizeButton.translatesAutoresizingMaskIntoConstraints = false
        randomizeButton.setTitle("Randomize", for: .normal)
        randomizeButton.addTarget(self, action: #selector(randomizeAction), for: .touchUpInside)
        
        view.addSubview(imageView)
        view.addSubview(nameLabel)
        view.addSubview(fullNameLabel)
        view.addSubview(alterEgosLabel)
        view.addSubview(placeOfBirthLabel)
        view.addSubview(firstAppearanceLabel)
        view.addSubview(publisherLabel)
        view.addSubview(intelligenceLabel)
        view.addSubview(powerLabel)
        view.addSubview(speedLabel)
        view.addSubview(durabilityLabel)
        view.addSubview(combatLabel)
        view.addSubview(randomizeButton)
            
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 120),
            imageView.heightAnchor.constraint(equalToConstant: 120),

            nameLabel.topAnchor.constraint(equalTo: imageView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            fullNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            fullNameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20),
            fullNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            alterEgosLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
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

            intelligenceLabel.topAnchor.constraint(equalTo: publisherLabel.bottomAnchor, constant: 20),
            intelligenceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            intelligenceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            powerLabel.topAnchor.constraint(equalTo: intelligenceLabel.bottomAnchor, constant: 10),
            powerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            powerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            speedLabel.topAnchor.constraint(equalTo: powerLabel.bottomAnchor, constant: 10),
            speedLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            speedLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            durabilityLabel.topAnchor.constraint(equalTo: speedLabel.bottomAnchor, constant: 10),
            durabilityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            durabilityLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            combatLabel.topAnchor.constraint(equalTo: durabilityLabel.bottomAnchor, constant: 10),
            combatLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            combatLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            randomizeButton.topAnchor.constraint(equalTo: combatLabel.bottomAnchor, constant: 20),
            randomizeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            randomizeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            randomizeButton.heightAnchor.constraint(equalToConstant: 44)
            ])
        }
    
    @objc func randomizeAction() {
        fetchSuperHeroData(id: Int.random(in: 1...700))
    }
    
    func loadImage(from url: URL) {
        self.imageView.kf.setImage(with: url)
    }

}

