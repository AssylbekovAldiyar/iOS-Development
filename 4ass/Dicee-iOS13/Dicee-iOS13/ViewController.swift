import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var DiceImageView1: UIImageView!
    @IBOutlet weak var DiceImageView2: UIImageView!

    let diceImages = [
            UIImage(named: "dice1"),
            UIImage(named: "dice2"),
            UIImage(named: "dice3"),
            UIImage(named: "dice4"),
            UIImage(named: "dice5"),
            UIImage(named: "dice6")
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


    @IBAction func RollButtonPressed(_ sender: Any) {
        let randomIndex1 = Int.random(in: 0...5)
        let randomIndex2 = Int.random(in: 0...5)
        
        DiceImageView1.image = diceImages[randomIndex1]
        DiceImageView2.image = diceImages[randomIndex2]
    }
}

