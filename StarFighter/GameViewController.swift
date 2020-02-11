//
//  GameViewController.swift
//  StarFighter
//
//  Created by Benjamin Rousval on 04/01/2020.
//  Copyright © 2020 StarFighter. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import GameKit

class GameViewController: UIViewController,GameViewControllerDelegate{
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var sceneView = SKView()
        sceneView.backgroundColor = .white
        self.view = sceneView
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                
                let gameScene = scene as! GameScene
                gameScene.GameViewControllerDelegate = self
                gameScene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(gameScene)
                
            }
         
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
            
            
        }
        
    }
    
    func end(){
        print("test")
        let test = StarshipTableViewController()
        self.navigationController?.pushViewController(test, animated: true)
        
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    

}
