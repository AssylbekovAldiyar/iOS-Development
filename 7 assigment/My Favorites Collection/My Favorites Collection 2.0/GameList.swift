//
//  GameList.swift
//  My Favorites Collection
//
//  Created by Aldiyar on 25.10.2024.
//

import UIKit

class GameList: UIViewController {
    
    var tableView = UITableView()
    var games: [Game] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorite old games"
        games = fetchData()
        configureTableView()
        
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
        setTableViewDelegates()
        
        tableView.rowHeight = 100
        
        tableView.register(GameCell.self, forCellReuseIdentifier: "VideoCell")

        tableView.pin(to: view)
    }

    func setTableViewDelegates(){
        tableView.delegate = self
        tableView.dataSource = self
    }
}




extension GameList: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell") as! GameCell
        let game = games[indexPath.row]
        cell.set(game: game)
        
        return cell
    }
}

extension GameList {
    
    func fetchData() -> [Game] {
        let game1 = Game(image: UIImage.warcraft, title: "Warcraft", developer: "Blizzard Entertainment", genre: "Стратегия в реальном времени")
        let game2 = Game(image: UIImage.diablo, title: "Diablo 3", developer: "Blizzard Entertainment", genre: "Экшн-RPG")
        let game3 = Game(image: UIImage.gta, title: "Grand Theft Auto", developer: "Rockstar Games", genre: "Экшн/Приключения")
        let game4 = Game(image: UIImage.NFS, title: "Need For Speed", developer: "Electronic Arts", genre: "Гоночная игра")
        let game5 = Game(image: UIImage.fable, title: "Fable", developer: "Lionhead Studios", genre: "Ролевая игра")
        let game6 = Game(image: UIImage.starcraft, title: "Starcraft", developer: "Blizzard Entertainment", genre: "Стратегия в реальном времени")
        let game7 = Game(image: UIImage.tf2, title: "Team Fortress 2", developer: "Valve", genre: "Шутер от первого лица")
        let game8 = Game(image: UIImage.cs, title: "Counter-Strike 1.6", developer: "Valve", genre: "Шутер от первого лица")
        let game9 = Game(image: UIImage.portal, title: "Portal", developer: "Valve", genre: "Головоломка/Платформер")
                
        return [game3, game1, game9, game5, game7, game2, game4, game8, game6]
    }
}

