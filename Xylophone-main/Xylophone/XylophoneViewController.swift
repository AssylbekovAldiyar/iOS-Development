import UIKit
import AVFoundation

class XylophoneViewController: UIViewController {
    
    let notes = ["C", "D", "E", "F", "G", "A", "B"]
    let colors: [UIColor] = [.red, .orange, .yellow, .green, .blue, .purple, .systemPink]
    var audioPlayers: [String: AVAudioPlayer] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupXylophone()
        preloadSounds()
    }
    
    func setupXylophone() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        for (index, note) in notes.enumerated() {
            let button = UIButton()
            button.backgroundColor = colors[index]
            button.setTitle(note, for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
            button.layer.cornerRadius = 8
            button.addTarget(self, action: #selector(noteTapped(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
    }
    
    func preloadSounds() {
        for note in notes {
            guard let url = Bundle.main.url(forResource: note, withExtension: "wav") else {
                print("Could not find sound file for note: \(note)")
                continue
            }
            
            do {
                let player = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
                audioPlayers[note] = player
            } catch {
                print("Could not create audio player for note: \(note)")
            }
        }
    }
    
    @objc func noteTapped(_ sender: UIButton) {
        guard let note = sender.titleLabel?.text,
              let player = audioPlayers[note] else { return }
        
        player.stop()
        player.currentTime = 0
        player.play()
        
        UIView.animate(withDuration: 0.1, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                sender.transform = .identity
            }
        }
    }
}
