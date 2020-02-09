//
//  StarshipDetailViewController.swift
//  StarFighter
//
//  Created by Fabiana Montiel on 05/01/2020.
//  Copyright © 2020 StarFighter. All rights reserved.
//

import UIKit
import GameKit


class StarshipDetailViewController: UIViewController/*,GKGameCenterControllerDelegate*/ {

    
    let preferences = UserDefaults.standard
    var spaceshipSelected:Spaceship?
    var player: AVAudioPlayer!
    
    @IBOutlet weak var spaceshipImageViewController: UIImageView!
    
    @IBOutlet weak var spaceshipName: UILabel!
    @IBOutlet weak var spaceshipHp: UILabel!
    @IBOutlet weak var spaceshipDamage: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let spaceship = spaceshipSelected else {return}
        
        spaceshipName.text = spaceship.name
        spaceshipHp.text = "Hp: \(spaceship.hp)"
        spaceshipDamage.text = "Damage: \(spaceship.damage)"
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(checkLeaderboard))
        if let pictureURL = spaceship.img {
            if let data = try? Data(contentsOf: pictureURL) {
                self.spaceshipImageViewController.sd_setImage(with:pictureURL , placeholderImage: UIImage(named: "load.png"))
            }
        }
        initAudioPlayer()
    }
    
    /*func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
    override func viewDidAppear(_ animated: Bool) {
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
        guard let musicURL = Bundle.main.url(forResource: "CantinaBis", withExtension: "mp3") else {
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
        
    }*/
    
    
    @IBAction func validButtonAction(_ sender: Any) {
        playerShip = spaceshipSelected
        let game = GameViewController()
        self.navigationController?.pushViewController(game, animated: true)
    }
    

}
