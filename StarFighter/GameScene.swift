//
//  GameScene.swift
//  StarFighter
//
//  Created by Benjamin Rousval on 04/01/2020.
//  Copyright © 2020 StarFighter. All rights reserved.
//

import SpriteKit
import GameplayKit
import  CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var spaceshipService: SpaceshipService {
        return SpaceshipMockService()
//        return SpaceshipAPIService()
    }
    
    var playerSpaceship:Spaceship!
    var enemy:Spaceship!
    
    var starfield:SKEmitterNode!
    
    var player: SKSpriteNode!
    var HealthBarPlayer: SKSpriteNode!
    var lifePlayerLabel:SKLabelNode!
    var lifePlayer:Int = 100
    
    var alien: SKSpriteNode!
    var HealthBarEnemy: SKSpriteNode!
    var lifeAlienLabel:SKLabelNode!
    var lifeAlien:Int = 100
    
    var torpilleNode: SKSpriteNode!
    
    var gameTimer: Timer?
    let alienCategory:UInt32 = 0x1 << 1
    let torpilleCategory:UInt32 = 0x1 << 0
    let playerCategory:UInt32 = 0x1 << 2
    let worldNode = SKNode( )
    let motionManager = CMMotionManager()
    var xAcceleration:CGFloat = 0
    var win: SKLabelNode!
    var pause:SKLabelNode!
    var pauseButton:SKLabelNode!
    var enPause:Bool = false
    
    var scoreLabel: SKLabelNode!
    var score:Int = 0

    override func didMove(to view: SKView) {
    starfield = SKEmitterNode(fileNamed: "Starfield")
    starfield.position = CGPoint(x: 0, y: 1472)
    starfield.advanceSimulationTime(10)
    self.addChild(starfield)
    starfield.zPosition = -1
            
    self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
    self.physicsWorld.contactDelegate = self
        
        pause = SKLabelNode(text: "Continue")
        pause.position = CGPoint(x: 0, y: 0)
        pause.fontName = "Zapfino"
        pause.fontSize = 50
        pause.name = "endpause"
        pause.color = UIColor.white
        
        pauseButton = SKLabelNode(text: "Pause")
        pauseButton.position = CGPoint(x: self.frame.width / -4.2, y: self.frame.height/3)
        pauseButton.fontName = "Zapfino"
        pauseButton.fontSize = 50
        pauseButton.name = "pause"
        pauseButton.color = UIColor.white
        self.addChild(pauseButton)
        
        
    addPlayer()
    addAlien()
    setScore(score)
        self.addChild(worldNode)

        // deplacement tilt du telephone
        motionManager.accelerometerUpdateInterval = 0.1
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data:CMAccelerometerData?, error:Error?) in
            if let accelerometerData = data {
                let acceleration = accelerometerData.acceleration
                self.xAcceleration = CGFloat(acceleration.x) * 0.75 + self.xAcceleration * 0.25
            }
        }
}
    
    
  // deplacement tilt du telephone
    override func didSimulatePhysics() {
        player.position.x += xAcceleration * 80
        if player.position.x < -350 {
            player.position = CGPoint(x: self.size.width/2, y: player.position.y)
        }else if player.position.x > self.size.width/2 {
            player.position = CGPoint(x: -350, y: player.position.y)
        }
    }
                
    @objc func enemyFire(){
        if !worldNode.isPaused {
          self.run(SKAction.playSoundFileNamed("TIE_fire.mp3", waitForCompletion: false))
          
          torpilleNode = SKSpriteNode(imageNamed: "laser")
          torpilleNode.size = CGSize(width: torpilleNode.size.width/6, height: torpilleNode.size.width/6)
          torpilleNode.position = CGPoint(x: alien.position.x, y: alien.position.y - alien.size.height)
          torpilleNode.position.y += 5
          torpilleNode.physicsBody = SKPhysicsBody(rectangleOf: torpilleNode!.size)
          torpilleNode.physicsBody?.isDynamic = true
          torpilleNode.physicsBody?.categoryBitMask = torpilleCategory
          torpilleNode.physicsBody?.contactTestBitMask = playerCategory
          torpilleNode.physicsBody?.collisionBitMask = 0
          torpilleNode.physicsBody?.usesPreciseCollisionDetection = true

          worldNode.addChild(torpilleNode)

          let animationDuration:TimeInterval = 1

          var actionArray = [SKAction]()
          actionArray.append(SKAction.move(to: CGPoint(x: alien.position.x, y: -450), duration: animationDuration))
          actionArray.append(SKAction.removeFromParent())
          torpilleNode?.run(SKAction.sequence(actionArray))
        }
        
        
    }

    
    func addPlayer(){
      
             self.playerSpaceship = playerShip
            if(self.playerSpaceship.img != nil) {
                let data = try! Data(contentsOf: self.playerSpaceship.img!)
                
                let image = UIImage(data: data)
                print(image?.size)
                let Texture = SKTexture(image: image!)
                self.player = SKSpriteNode(texture: Texture)
            } else {
                self.player = SKSpriteNode(imageNamed: "falcon")
            }
         
        if(playerShip!.damage>100000){
            player.size = CGSize(width: 350, height: 350)
        }else{
            player.size = CGSize(width: 150, height: 150)
        }
         
         player.name = "player"
         player.position = CGPoint(x: 0, y: -450)
         player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
         player.physicsBody?.isDynamic = true
         
         player.physicsBody?.categoryBitMask = playerCategory
         player.physicsBody?.contactTestBitMask = torpilleCategory
         player.physicsBody?.collisionBitMask = 0
         

        worldNode.addChild(player)
         
         HealthBarPlayer = SKSpriteNode(color:SKColor .green, size: CGSize(width: lifePlayer, height: 30))
         HealthBarPlayer.position = CGPoint(x: self.frame.width / -4.2, y: self.frame.height / -2.5)
         HealthBarPlayer.zPosition = 1
         self.addChild(HealthBarPlayer)
    }
    
    func addAlien(){
        
        
        let rand = Int.random(in: 0...31)
       
        self.enemy = allShips[rand]
        
        
        if(self.enemy.img != nil) {
            let data = try! Data(contentsOf: self.enemy.img!)
            let image = UIImage(data: data)
            let Texture = SKTexture(image: image!)
            alien = SKSpriteNode(texture: Texture)
        } else {
            alien = SKSpriteNode(imageNamed: "falcon")
        }
        if(enemy!.damage>100000){
            alien.size = CGSize(width: 350, height: 350)
        }else{
            alien.size = CGSize(width: 150, height: 150)
        }
       
        alien.name = "alien"
        alien.position = CGPoint(x: 0, y: 450)
        alien.physicsBody = SKPhysicsBody(rectangleOf: alien.size)
        alien.physicsBody?.isDynamic = true
        
        alien.physicsBody?.categoryBitMask = alienCategory
        alien.physicsBody?.contactTestBitMask = torpilleCategory
        alien.physicsBody?.collisionBitMask = 0
        worldNode.addChild(alien)
        
        let moveLeft = SKAction.move(to: CGPoint(x: -300, y:  500), duration: 5)
        let moveRight = SKAction.move(to: CGPoint(x: 300, y:  500), duration: 5)

        self.gameTimer?.invalidate()
//        let atkSpeed:Double = Double(1/Double(alien.speed)/10)
         let atkSpeed:Double
        if worldNode.isPaused {
           atkSpeed = 0
            print("ENEMY.SPEED \(enemy.speed)")
        }else{
        atkSpeed = Double(10.00 / Float(enemy.speed))
        }
        print(atkSpeed)
        self.gameTimer = Timer.scheduledTimer(timeInterval: atkSpeed + 0.5, target: self, selector: #selector(enemyFire), userInfo: nil, repeats: true)
        
        
        alien?.run(SKAction.repeatForever(SKAction.sequence([moveLeft, moveRight])))
        
        HealthBarEnemy = SKSpriteNode(color:SKColor .green, size: CGSize(width: lifeAlien, height: 30))
        HealthBarEnemy.position = CGPoint(x: self.frame.width / 4.2, y: self.frame.height/3)
        HealthBarEnemy.zPosition = 1
        HealthBarEnemy.isUserInteractionEnabled = false
        
        self.addChild(HealthBarEnemy)
    }
    
    

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !worldNode.isPaused {
            fireTorpille()
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
                let location = touch.location(in: self)
                let node : SKNode = self.atPoint(location)
                if node.name == "pause"{
                    addChild(pause)
                    
                    worldNode.isPaused = true
                    
                    
                }
            if node.name == "endpause"{
                pause.removeFromParent()
                worldNode.isPaused = false
                     
            }
            }
        }
   
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !worldNode.isPaused {
                  for touch in touches {
                      let location = touch.location(in: self)
                      player.position.x = location.x
                     
                  }
              }
        
    }
    

    
    func fireTorpille(){
        self.run(SKAction.playSoundFileNamed("XWing_fire.mp3", waitForCompletion: false))
        
        torpilleNode = SKSpriteNode(imageNamed: "laser")
        torpilleNode.size = CGSize(width: torpilleNode.size.width/6, height: torpilleNode.size.width/6)
        torpilleNode.position = CGPoint(x: player.position.x, y: player.position.y + ((player.size.height) / 2) + 30)
        
        torpilleNode.physicsBody = SKPhysicsBody(rectangleOf: torpilleNode!.size)
        torpilleNode.physicsBody?.isDynamic = true
        torpilleNode.physicsBody?.categoryBitMask = torpilleCategory
        torpilleNode.physicsBody?.contactTestBitMask = alienCategory
        torpilleNode.physicsBody?.collisionBitMask = 0
        torpilleNode.physicsBody?.usesPreciseCollisionDetection = true

        worldNode.addChild(torpilleNode)

        let animationDuration:TimeInterval = 1

        var actionArray = [SKAction]( )
        actionArray.append(SKAction.move(to: CGPoint(x: player.position.x, y: 500), duration: animationDuration))
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
        worldNode.addChild(explosion!)
        
        self.run(SKAction.playSoundFileNamed("explosion.mp3", waitForCompletion: false))
        
        torpille.removeFromParent()
        self.run(SKAction.wait(forDuration: 2)) {
            explosion?.removeFromParent()
        }
        var percentBar = 0
        if(alien.name == "player"){
            percentBar = (enemy.damage*100) / playerSpaceship.hp
            lifePlayer -= percentBar
            HealthBarPlayer.size = CGSize(width: lifePlayer, height: 30)
            switch lifePlayer {
            case ...0:
                win = SKLabelNode(text: "LOSER")
                win.position = CGPoint(x: 0, y: 0)
                win.fontName = "Zapfino"
                win.fontSize = 50
                win.color = UIColor.white
                addChild(win)
                self.scene?.view!.isPaused = true
                break
            case 1...30:
                HealthBarPlayer.color = SKColor .red
                break
            case 31...50:
                HealthBarPlayer.color = SKColor .yellow
                break
            default:
                HealthBarPlayer.color = SKColor .green
            }
        }else{
            //bypass the limit of int (Remember call of duty black ops...)
            guard let scoreValue = UInt64(scoreLabel.text!) else {return}
            scoreLabel.text = String(scoreValue + UInt64(playerSpaceship.damage / 100))
            percentBar = (playerSpaceship.damage*100) / enemy.hp
            lifeAlien -= percentBar
            HealthBarEnemy.size = CGSize(width: lifeAlien, height: 30)
            switch lifeAlien {
            case ...0:
                alien.removeFromParent()
                HealthBarEnemy.removeFromParent()
                
                lifeAlien = 100
                HealthBarEnemy = SKSpriteNode(color:SKColor .green, size: CGSize(width: lifeAlien, height: 30))
                HealthBarEnemy.position = CGPoint(x: self.frame.width / 4.2, y: self.frame.height/2.5)
                HealthBarEnemy.zPosition = 1
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
    
    func setScore(_: Int){
        scoreLabel = SKLabelNode(text: String(score))
        scoreLabel.position = CGPoint(x: 200, y: 0)
        scoreLabel.fontName = "Zapfino"
        scoreLabel.fontSize = 24
        scoreLabel.color = UIColor.white
        addChild(scoreLabel)
    }
    
    var lastUpdateTime:TimeInterval = 0
    var dt: TimeInterval = 0
    let alienMovePointsPerSec: CGFloat =  100
    var velocity = CGPoint.zero
    let direction: Bool = true
    
    func moveAlien(sprite: SKSpriteNode, velocity: CGPoint){
        let amountToMove = CGPoint(x: velocity.x * CGFloat(dt), y: velocity.y * CGFloat(dt))
        sprite.position = CGPoint(x: sprite.position.x + amountToMove.x, y: sprite.position.y + amountToMove.y)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if lastUpdateTime > 0 {
            dt = currentTime - lastUpdateTime
        }else {
            dt = 0
        }
        lastUpdateTime = currentTime
        
//         moveAlien(sprite: alien, velocity: CGPoint(x: alienMovePointsPerSec, y: 0))
//        if (alien.position.x < 310 && alien.position.x > 300 ){
//            moveAlien(sprite: alien, velocity: CGPoint(x: -alienMovePointsPerSec, y: 0))
//
//        }else if(alien.position.x > -310 && alien.position.x < -300 ) {
//            moveAlien(sprite: alien, velocity: CGPoint(x: alienMovePointsPerSec, y: 0))
//        }
        
//        print(alien.position.x)
        
        
    }
}
