//
//  GameScene.swift
//  StarFighter
//
//  Created by Benjamin Rousval on 04/01/2020.
//  Copyright © 2020 StarFighter. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var spaceshipService: SpaceshipService {
        return SpaceshipMockService()
    }
    
    var enemy:Spaceship!
    
    var starfield:SKEmitterNode!
    
    var player:SKSpriteNode!
    var HealthBarPlayer: SKSpriteNode!
    var lifePlayerLabel:SKLabelNode!
    var lifePlayer:Int = 1
    
    var alien: SKSpriteNode!
    var possibleAliens = ["tie","falcon","starDestroyer"]
    var HealthBarEnemy: SKSpriteNode!
    var lifeAlienLabel:SKLabelNode!
    var lifeAlien:Int = 1
    
    var torpilleNode: SKSpriteNode!
    
    var gameTimer: Timer!
    let alienCategory:UInt32 = 0x1 << 1
    let torpilleCategory:UInt32 = 0x1 << 0
    let playerCategory:UInt32 = 0x1 << 2
    
    var win: SKLabelNode!

    override func didMove(to view: SKView) {
     
    starfield = SKEmitterNode(fileNamed: "Starfield")
    starfield.position = CGPoint(x: 0, y: 1472)
    starfield.advanceSimulationTime(10)
    self.addChild(starfield)
    starfield.zPosition = -1
                    
    
//  Get url from API
    let url = URL(string: "https://webstockreview.net/images1280_/falcon-clipart-millenium-falcon-11.png")
    let data = try! Data(contentsOf: url!)
    let image = UIImage(data: data)
    let Texture = SKTexture(image: image!)
    player = SKSpriteNode(texture: Texture)
       // player = SKSpriteNode(imageNamed: "falcon")
    player.name = "player"
    
    player.position = CGPoint(x: 0, y: -450)
    player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
    player.physicsBody?.isDynamic = true
        //player.size = CGSize(width: player.size.width / 3, height: player.size.height / 3)
    
    player.physicsBody?.categoryBitMask = playerCategory
    player.physicsBody?.contactTestBitMask = torpilleCategory
    player.physicsBody?.collisionBitMask = 0
    
    self.addChild(player)
    self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
    self.physicsWorld.contactDelegate = self
    
    
    HealthBarPlayer = SKSpriteNode(color:SKColor .yellow, size: CGSize(width: lifePlayer, height: 30))
    HealthBarPlayer.position = CGPoint(x: self.frame.width / -4.2, y: self.frame.height / -2.5)
    HealthBarPlayer.zPosition = 1
    self.addChild(HealthBarPlayer)
    
    
    
    addAlien()
    gameTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(enemyFire), userInfo: nil, repeats: true)

}
                
    @objc func enemyFire(){
        //self.run(SKAction.playSoundFileNamed("TIE_fire.mp3", waitForCompletion: false))
        
        torpilleNode = SKSpriteNode(imageNamed: "torpedo")
        torpilleNode.size = CGSize(width: torpilleNode.size.width/3, height: torpilleNode.size.width/3)
        torpilleNode.position = CGPoint(x: 0, y: alien.position.y - alien.size.height)
        torpilleNode.position.y += 5
        torpilleNode.physicsBody = SKPhysicsBody(rectangleOf: torpilleNode!.size)
        torpilleNode.physicsBody?.isDynamic = true
        torpilleNode.physicsBody?.categoryBitMask = torpilleCategory
        torpilleNode.physicsBody?.contactTestBitMask = playerCategory
        torpilleNode.physicsBody?.collisionBitMask = 0
        torpilleNode.physicsBody?.usesPreciseCollisionDetection = true

        self.addChild(torpilleNode)

        let animationDuration:TimeInterval = 1

        var actionArray = [SKAction]()
        actionArray.append(SKAction.move(to: CGPoint(x: alien.position.x, y: player.position.y + 50), duration: animationDuration))
        actionArray.append(SKAction.removeFromParent())
        torpilleNode?.run(SKAction.sequence(actionArray))
        
    }
    
    func addAlien(){
        
        self.spaceshipService.getRandom { (Spaceship) in
            guard let spaceship = Spaceship else {return}
            self.enemy = spaceship
        }
        
        if(self.enemy.img != nil) {
            let data = try! Data(contentsOf: self.enemy.img!)
            let image = UIImage(data: data)
            let Texture = SKTexture(image: image!)
            alien = SKSpriteNode(texture: Texture)
        } else {
            alien = SKSpriteNode(imageNamed: "falcon")
        }
        
        
//        possibleAliens = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: possibleAliens) as! [String]
//        alien = SKSpriteNode(imageNamed: possibleAliens[0])
        
        alien.size = CGSize(width: alien.size.width/3, height: alien.size.width/3)
       
        alien.name = "alien"
        alien.position = CGPoint(x: 0, y: 500)
        alien.physicsBody = SKPhysicsBody(rectangleOf: alien.size)
        alien.physicsBody?.isDynamic = true
        
        alien.physicsBody?.categoryBitMask = alienCategory
        alien.physicsBody?.contactTestBitMask = torpilleCategory
        alien.physicsBody?.collisionBitMask = 0
        self.addChild(alien)
        
        HealthBarEnemy = SKSpriteNode(color:SKColor .green, size: CGSize(width: 100, height: 30))
        HealthBarEnemy.position = CGPoint(x: self.frame.width / 4.2, y: self.frame.height/2.5)
        HealthBarEnemy.zPosition = 1
        self.addChild(HealthBarEnemy)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        fireTorpille()
    }
    
    func fireTorpille(){
        //self.run(SKAction.playSoundFileNamed("XWing_fire.mp3", waitForCompletion: false))
        
        torpilleNode = SKSpriteNode(imageNamed: "laser")
        torpilleNode.size = CGSize(width: torpilleNode.size.width/6, height: torpilleNode.size.width/6)
        torpilleNode.position = CGPoint(x: 0, y: player.position.y + ((player.size.height) / 2) + 30)
        
        torpilleNode.physicsBody = SKPhysicsBody(rectangleOf: torpilleNode!.size)
        torpilleNode.physicsBody?.isDynamic = true
        torpilleNode.physicsBody?.categoryBitMask = torpilleCategory
        torpilleNode.physicsBody?.contactTestBitMask = alienCategory
        torpilleNode.physicsBody?.collisionBitMask = 0
        torpilleNode.physicsBody?.usesPreciseCollisionDetection = true

        self.addChild(torpilleNode)

        let animationDuration:TimeInterval = 1

        var actionArray = [SKAction]( )
        actionArray.append(SKAction.move(to: CGPoint(x: player.position.x, y: self.frame.size.height + 10), duration: animationDuration))
        actionArray.append(SKAction.removeFromParent())
        torpilleNode?.run(SKAction.sequence(actionArray))
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        var firstBody:SKPhysicsBody
        var secondBody:SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask{
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if (firstBody.categoryBitMask & torpilleCategory) != 0 &&  (secondBody.categoryBitMask & alienCategory) != 0 {
            tropilleDidColide(torpille: firstBody.node as! SKSpriteNode, alien: secondBody.node as! SKSpriteNode)
        }
        
        if (firstBody.categoryBitMask & torpilleCategory) != 0 &&  (secondBody.categoryBitMask & playerCategory) != 0 {
            tropilleDidColide(torpille: firstBody.node as! SKSpriteNode, alien: secondBody.node as! SKSpriteNode)
        }

    }
   
    func tropilleDidColide(torpille:SKSpriteNode,alien:SKSpriteNode){
        let explosion = SKEmitterNode(fileNamed: "Explosion")
        explosion!.position = alien.position
        self.addChild(explosion!)
        
//        self.run(SKAction.playSoundFileNamed("explosion.mp3", waitForCompletion: false))
        
        torpille.removeFromParent()
        self.run(SKAction.wait(forDuration: 2)) {
            explosion?.removeFromParent()
        }
        if(alien.name == "player"){
            lifePlayer -= 10
            HealthBarPlayer.size = CGSize(width: lifePlayer, height: 30)
        }else{
            
            lifeAlien -= 10
//            TODOO
//            let percentBar = (player.damage*100) / enemy.hp
//            lifeAlien -= percentBar
            HealthBarEnemy.size = CGSize(width: lifeAlien, height: 30)
            switch lifeAlien {
            case ...0:
                alien.removeFromParent()
                lifeAlien = 100
                addAlien()
                break
            case 1...30:
                HealthBarEnemy.color = SKColor .red
                break
            case 31...50:
                HealthBarEnemy.color = SKColor .yellow
                break
            default:
                HealthBarEnemy.color = SKColor .green
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
