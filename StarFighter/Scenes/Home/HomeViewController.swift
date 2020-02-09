//
//  HomeViewController.swift
//  StarFighter
//
//  Created by Fabiana Montiel on 05/01/2020.
//  Copyright © 2020 StarFighter. All rights reserved.
//

import UIKit
import GameKit
let LEADERBOARD_ID = "com.esgi.findout"
class HomeViewController: UIViewController/*, GKGameCenterControllerDelegate*/ {
    
    @IBOutlet var label_score: UILabel!
    
    /* Variables */
    var gcEnabled = Bool() // Check if the user has Game Center enabled
    var gcDefaultLeaderBoard = String() // Check the default leaderboardID
         
    var score = 0
         
    // IMPORTANT: replace the red string below with your own Leaderboard ID (the one you've set in iTunes Connect)
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
         self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        // Show initial sco
        
        // Call the GC authentication controller
        //authenticateLocalPlayer()
        
        // Do any additional setup after loading the view.
    }
    
    
    /*func authenticateLocalPlayer() {
        let localPlayer = GKLocalPlayer()// = GKLocalPlayer.localPlayer()
        
        localPlayer.authenticateHandler = {(ViewController, error) -> Void in
            if((ViewController) != nil) {
                // 1 Show login if player is not logged in
                self.present(ViewController!, animated: true, completion: nil)
            } else if (localPlayer.isAuthenticated) {
                // 2 Player is already euthenticated & logged in, load game center
                self.gcEnabled = true
                    
                // Get the default leaderboard ID
                localPlayer.loadDefaultLeaderboardIdentifier(completionHandler: { (leaderboardIdentifer, error) in
                    if error != nil { print(error as Any)
                    } else { self.gcDefaultLeaderBoard = leaderboardIdentifer! }
                })
                
            } else {
                // 3 Game center is not enabled on the users device
                self.gcEnabled = false
                print("Local player could not be authenticated!")
                print(error as Any)
            }
        }
    }*/
    
    // Delegate to dismiss the GC controller
    /*func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }*/
    
    

    
    @IBAction func touchButton(_ sender: Any) {
        let spaceshipList = StarshipTableViewController()
        self.navigationController?.pushViewController(spaceshipList, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
}
