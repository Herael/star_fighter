//
//  StarshipTableViewController.swift
//  StarFighter
//
//  Created by Benjamin Rousval on 01/02/2020.
//  Copyright © 2020 StarFighter. All rights reserved.
//

import UIKit
import SDWebImage
import GameKit


var allShips:[Spaceship] = [ ]
var playerShip:Spaceship? = nil


class StarshipTableViewController: UITableViewController,GKGameCenterControllerDelegate {
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView(style: .gray)
    
    var player: AVAudioPlayer!
    
    @IBOutlet var starshipTableView: UITableView!
    public static let spaceshipCellId = "STARSHIP_ID"
    var spaceships: [Spaceship] = [] {
        didSet {
            self.starshipTableView.reloadData()
        }
    }
    
    
    
    
    
    var spaceshipService: SpaceshipService {
        //        return SpaceshipMockService()
        return SpaceshipAPIService()
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.starshipTableView.dataSource = self
        self.starshipTableView.delegate = self
        self.starshipTableView.rowHeight = 120
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(checkLeaderboard))
        self.navigationItem.setHidesBackButton(true, animated: true);      self.starshipTableView.register(UINib(nibName: "StarshipTableViewCell", bundle: nil), forCellReuseIdentifier:StarshipTableViewController.spaceshipCellId)
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        initAudioPlayer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.spaceshipService.getAll { (spaceships) in
            self.spaceships = spaceships
            allShips = spaceships
        }
        if self.player != nil {
            self.player.play()
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.player.pause()
    }
    
    @discardableResult
       func initAudioPlayer() -> Bool {
           guard self.player == nil else {
               return true
           }
           guard let musicURL = Bundle.main.url(forResource: "Cantina", withExtension: "mp3") else {
               return false
           }
           if let player = try? AVAudioPlayer(contentsOf: musicURL) {
               self.player = player
               self.player.numberOfLoops = -1
               self.player.prepareToPlay()
               return true
           }
           return false
       }
       
    
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
           gameCenterViewController.dismiss(animated: true, completion: nil)
       }
    
    @objc func checkLeaderboard() {
        
        let gcVC = GKGameCenterViewController()
    gcVC.gameCenterDelegate = self as! GKGameCenterControllerDelegate
        gcVC.viewState = .leaderboards
        gcVC.leaderboardIdentifier = LEADERBOARD_ID
        present(gcVC, animated: true, completion: nil)
        
    }
    
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.spaceships.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = starshipTableView.dequeueReusableCell(withIdentifier:StarshipTableViewController.spaceshipCellId, for: indexPath) as? StarshipTableViewCell
            else{ return UITableViewCell() }
        let spaceship = self.spaceships[indexPath.row]
        cell.starshipName.text = spaceship.name
        cell.damage.text = "Damage: \(spaceship.damage)"
        if let pictureURL = spaceship.img {
            cell.starshipImage.sd_setImage(with:pictureURL , placeholderImage: UIImage(named: "load.png"))
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let spaceshipDetail = StarshipDetailViewController()
        spaceshipDetail.spaceshipSelected = self.spaceships[indexPath.row]
        self.navigationController?.pushViewController(spaceshipDetail, animated: true)
    }
}
