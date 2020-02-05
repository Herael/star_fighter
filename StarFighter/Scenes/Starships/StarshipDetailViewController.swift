//
//  StarshipDetailViewController.swift
//  StarFighter
//
//  Created by Fabiana Montiel on 05/01/2020.
//  Copyright © 2020 StarFighter. All rights reserved.
//

import UIKit


class StarshipDetailViewController: UIViewController {

    
    let preferences = UserDefaults.standard
    var spaceshipSelected:Spaceship?
    
    @IBOutlet weak var spaceshipImageViewController: UIImageView!
    
    @IBOutlet weak var spaceshipName: UILabel!
    @IBOutlet weak var spaceshipHp: UILabel!
    @IBOutlet weak var spaceshipDamage: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let spaceship = spaceshipSelected else {return}
        
        spaceshipName.text = spaceship.name
        spaceshipHp.text = String(spaceship.hp)
        spaceshipDamage.text = String(spaceship.damage)
        if let pictureURL = spaceship.img {
                            if let data = try? Data(contentsOf: pictureURL) {
               
                        self.spaceshipImageViewController.sd_setImage(with:pictureURL , placeholderImage: UIImage(named: "load.png"))
                    
                
            }
        }
    }
    
    
    @IBAction func validButtonAction(_ sender: Any) {
        playerShip = spaceshipSelected
        let game = GameViewController()
        self.navigationController?.pushViewController(game, animated: true)
    }
    

}
