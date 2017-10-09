//
//  GameScene.swift
//  Gravinaut
//
//  Created by Adrian on 18/03/2017.
//  Copyright © 2017 AdrianNP57. All rights reserved.
//

import UIKit
import Foundation
import SpriteKit

struct PhysicsCategory
{
    static let None      : UInt32 = 0
    static let All       : UInt32 = UInt32.max
    static let Borders   : UInt32 = 1
    static let Astronaut : UInt32 = 2
    static let Meteorite : UInt32 = 3
}

class GameScene: SKScene, SKPhysicsContactDelegate
{
    // Control vars
    var controlSpawn = 0
    var dead = 0
    
    var MainBackground1 = SKSpriteNode(imageNamed: "MainBackground")
    var MainBackground2 = SKSpriteNode(imageNamed: "MainBackground")
    
    var tutorialLabel = SKLabelNode(fontNamed: "PressStart2P")
    var hand = SKSpriteNode(imageNamed: "handIcon")
    
    // Astronaut node
    var astronaut = SKSpriteNode(imageNamed: "M10")
    
    // Astronaut textures
    
    var S10 = SKTexture(imageNamed: "S10")
    var S20 = SKTexture(imageNamed: "S20")
    var S30 = SKTexture(imageNamed: "S30")
    
    var M11 = SKTexture(imageNamed: "M11")
    var M21 = SKTexture(imageNamed: "M21")
    
    var B11 = SKTexture(imageNamed: "B11")
    var B21 = SKTexture(imageNamed: "B21")
    var B31 = SKTexture(imageNamed: "B31")
    
    // Meteorite textures
    var M1 = SKTexture(imageNamed: "meteorite1")
    var M2 = SKTexture(imageNamed: "meteorite2")
    var M3 = SKTexture(imageNamed: "meteorite3")
    var M4 = SKTexture(imageNamed: "meteorite4")
    
    let Small = SKAction.repeatForever(SKAction.animate(with: [SKTexture(imageNamed: "S10"), SKTexture(imageNamed: "S20"), SKTexture(imageNamed: "S30"), SKTexture(imageNamed: "S20")], timePerFrame: 0.1))
    
    let Medium = SKAction.repeatForever(SKAction.animate(with: [SKTexture(imageNamed: "M11"), SKTexture(imageNamed: "M21")], timePerFrame: 0.1))

    let Big = SKAction.repeatForever(SKAction.animate(with: [SKTexture(imageNamed: "B11"), SKTexture(imageNamed: "B21"), SKTexture(imageNamed: "B31"), SKTexture(imageNamed: "B21")], timePerFrame: 0.1))

    let gravityNodeDown = SKFieldNode.linearGravityField(withVector: vector_float3(0,-1,0))
    
    let gravityNodeUp = SKFieldNode.linearGravityField(withVector: vector_float3(0, 1,0))
    
    override func didMove(to view: SKView)
    {
        // Positioning elements main menu
        MainBackground1.anchorPoint = CGPoint(x: 0, y: 0)
        MainBackground1.position = CGPoint(x: 0, y: 0)
        MainBackground1.zPosition = 0
        self.addChild(MainBackground1)
        
        MainBackground2.anchorPoint = CGPoint(x: 0, y: 0)
        MainBackground2.position = CGPoint(x: MainBackground1.size.width-1, y: 0)
        MainBackground2.zPosition = 0
        self.addChild(MainBackground2)
    
        // Tutorial Label
        tutorialLabel.text = "HOLD"
        tutorialLabel.fontSize = 24
        tutorialLabel.fontColor = SKColor.white
        tutorialLabel.position = CGPoint(x: size.width * 0.5, y: size.height * 0.75)
        tutorialLabel.zPosition = 2
        self.addChild(tutorialLabel)
        
        // Hand
        hand.position = CGPoint(x: frame.size.width * 0.5, y: frame.size.height * 0.67)
        hand.size = CGSize(width: hand.size.width*0.5, height: hand.size.height*0.5)
        hand.zPosition = 2
        self.addChild(hand)
        
        // Moving Hand
        let handMoveDown = SKAction.moveBy(x: 0, y: size.height * 0.01, duration: 0.7)
        let handSequence = SKAction.sequence([handMoveDown, handMoveDown.reversed()])
        hand.run(SKAction.repeatForever(handSequence), withKey: "handMoving")
        
        // Astronaut
        astronaut.position = CGPoint(x: frame.size.width * 0.20, y: frame.size.height * 0.70)
        astronaut.zPosition = 2
        astronaut.size = CGSize(width: astronaut.size.width*0.40, height: astronaut.size.height*0.40)
        astronaut.run(Medium, withKey: "Medium") // Animation
        
        // Astronaut Physics
        astronaut.physicsBody = SKPhysicsBody(texture: S10, size: astronaut.size)
        astronaut.physicsBody?.isDynamic = true // Like this we control movement with actions (no gravity on it)
        astronaut.physicsBody?.categoryBitMask = PhysicsCategory.Astronaut // BitMaskPhysics
        astronaut.physicsBody?.contactTestBitMask = PhysicsCategory.Meteorite // Notify if it collides with astro
        astronaut.physicsBody?.collisionBitMask = PhysicsCategory.None // They won't bounce like this
        astronaut.physicsBody?.usesPreciseCollisionDetection = true

        
        // Astronaut add
        self.addChild(astronaut)
        
        // Background Scrollinng Starts
        run(SKAction.repeatForever(
            SKAction.sequence(
                [
                    SKAction.run(scrollBackground),
                    SKAction.wait(forDuration: 0.04)
                ])),
            withKey: "scrollBackground"
        )
        
        // World:Preparing Gravity and Physics: https://developer.apple.com/reference/spritekit/skfieldnode#2732549
        physicsWorld.gravity = CGVector(dx:0, dy: 0)
        physicsWorld.contactDelegate = self
        gravityNodeDown.strength = 1.62 // m/s^2
        gravityNodeUp.strength = 1.62 // m/s^2
    }

    // Operational funcs
    // Thanks you: https://www.raywenderlich.com/145318/spritekit-swift-3-tutorial-beginners
    func random() -> CGFloat
    {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    // Thanks you: https://www.raywenderlich.com/145318/spritekit-swift-3-tutorial-beginners
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    // Thank you: http://stackoverflow.com/questions/20019522/scrolling-background-sprite-kit
    func scrollBackground()
    {
        MainBackground1.position = CGPoint(x: MainBackground1.position.x-4, y: MainBackground1.position.y);
        MainBackground2.position = CGPoint(x: MainBackground2.position.x-4, y: MainBackground2.position.y);
        
        if (MainBackground1.position.x < -MainBackground1.size.width)
        {
            MainBackground1.position = CGPoint(x: MainBackground2.position.x + MainBackground2.size.width, y: MainBackground1.position.y);
        }
        
        if (MainBackground2.position.x < -MainBackground2.size.width)
        {
            MainBackground2.position = CGPoint(x: MainBackground1.position.x + MainBackground1.size.width, y:MainBackground2.position.y);
        }
    }
    
    func meteoriteSpawn()
    {
        // Meteorite declaration
        var meteorite = SKSpriteNode(imageNamed: "meteorite1")
        let randomTexture = Int(arc4random() % 4)
        switch (randomTexture)
        {
            case 0:
                meteorite = SKSpriteNode(imageNamed: "meteorite1")
                meteorite.physicsBody = SKPhysicsBody(texture: M1, size: meteorite.size)
            case 1:
                meteorite = SKSpriteNode(imageNamed: "meteorite2")
                meteorite.physicsBody = SKPhysicsBody(texture: M2, size: meteorite.size)
            case 2:
                meteorite = SKSpriteNode(imageNamed: "meteorite3")
                meteorite.physicsBody = SKPhysicsBody(texture: M3, size: meteorite.size)
            case 3:
                meteorite = SKSpriteNode(imageNamed: "meteorite4")
                meteorite.physicsBody = SKPhysicsBody(texture: M4, size: meteorite.size)
            default: break
        }
        // Meteorite physics
        meteorite.physicsBody?.isDynamic = false // Like this we control movement with actions (no gravity on it)
        meteorite.physicsBody?.categoryBitMask = PhysicsCategory.Meteorite // What is meteorite in physics?
        meteorite.physicsBody?.contactTestBitMask = PhysicsCategory.Astronaut // Notify if it collides with astro
        meteorite.physicsBody?.collisionBitMask = PhysicsCategory.None // They won't bounce like this
        meteorite.physicsBody?.usesPreciseCollisionDetection = false
        // Meteorite position
        let whereToSpawn = random(min: 0 , max: frame.size.height) // Where to spawn in the Y axis
        meteorite.position = CGPoint(x: frame.size.width + meteorite.size.width, y: whereToSpawn) // Positionating
        meteorite.zPosition = 1
        // Meteorite add
        addChild(meteorite)
        // Meteorite movement and rotation
        let speed = random(min: CGFloat(2.0), max: CGFloat(4.0))
        let meteoriteMove = SKAction.move(to: CGPoint(x: 0-meteorite.size.width/2, y: whereToSpawn), duration: TimeInterval(speed))
        let meteoriteMoveEnded = SKAction.removeFromParent()
        var angle = random(min: CGFloat(-2.0), max: CGFloat(2.0))
        if angle<0 {angle-=1} else {angle+=1}
        meteorite.run(SKAction.rotate(byAngle: CGFloat(.pi/angle), duration: 4))
        meteorite.run(SKAction.sequence([meteoriteMove, meteoriteMoveEnded]))

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if (dead==0)
        {
            // In the first click remove the tutorial and start the meteorite attack
            if (controlSpawn==0)
            {
                // Removing the tutorial
                tutorialLabel.removeFromParent()
                hand.removeFromParent()
                hand.removeAction(forKey: "movingHand")
                
                // Starting the meteorite attack
                run(SKAction.repeatForever(
                    SKAction.sequence(
                        [
                            SKAction.run(meteoriteSpawn),
                            SKAction.wait(forDuration: 2)
                        ])),
                    withKey: "meteoriteSpawn"
                )
                controlSpawn = 1
            }
            
            // Remove gravityDown
            gravityNodeDown.removeFromParent()
            
            // Add gravityUp
            self.addChild(gravityNodeUp)
            
            // Change animation Sprite to Big
            astronaut.run(Big, withKey: "Big")
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        // If the astronaut is still alive
        if (dead==0)
        {
            // Remove gravityUp
            gravityNodeUp.removeFromParent()
            
            // Add gravityDown
            self.addChild(gravityNodeDown)
            
            // Change animation Sprite to Small
            astronaut.run(Small, withKey: "Small")
        }
    }
    
    func didBegin(_ impact: SKPhysicsContact) // when two nodes collide
    {
        if (dead == 0)
        {
            dead=1

            // firstNode = node 1 collided | secondNode = node 2 collided
            var firstNode: SKPhysicsBody
            var secondNode: SKPhysicsBody
            
            // Ordering it
            if (impact.bodyA.categoryBitMask < impact.bodyB.categoryBitMask)
            {
                firstNode = impact.bodyA
                secondNode = impact.bodyB
            }
            else
            {
                firstNode = impact.bodyB
                secondNode = impact.bodyA
            }
            
            // If the collision was astronaut-meteorite
            if (firstNode.categoryBitMask == 2 && secondNode.categoryBitMask == 3)
            {
                if let astronaut = firstNode.node as? SKSpriteNode, let meteorite = secondNode.node as? SKSpriteNode
                {
                    print("Collision: Astronaut-Meteorite")
                    astronautMeteoriteImpact(astronaut: astronaut, meteorite: meteorite)
                }
            }
        }
    }
    
    func astronautMeteoriteImpact(astronaut: SKSpriteNode, meteorite: SKSpriteNode)
    {
        // Astronaut has died
        // Rocket stops working
        
        // Stop Meteorite Spawn
        meteorite.removeAction(forKey: "meteoriteSpawn")
        
        // Stop gravity
        gravityNodeUp.removeFromParent()
        gravityNodeDown.removeFromParent()
        
        // Astronaut Death thanks: https://www.hackingwithswift.com/example-code/games/how-to-run-skactions-in-agroup
        //let scale = SKAction.scale(to: 10, duration: 3)
        let move = SKAction.move(to: CGPoint(x: size.width * -0.10, y: size.height * -0.10), duration: 2)
        let rotate = SKAction.rotate(byAngle: CGFloat(.pi/(+0.4)), duration: 2)
        let astronautDeathMovement = SKAction.group([move, rotate])
        astronaut.run(astronautDeathMovement)
        
        let astronautDisappears = SKAction.removeFromParent()
        
        astronaut.run(SKAction.sequence(
        [
                astronautDeathMovement,
                astronautDisappears
            ])
        )
        
        // Wait 3 seconds - Thanks: http://stackoverflow.com/questions/24034544/dispatch-after-gcd-in-swift
        let deadlineTime = DispatchTime.now() + 2.5
        DispatchQueue.main.asyncAfter(deadline: deadlineTime)
        {
            // Removing astronaut from scene
            
            // Return - Scene change
            let transition = SKTransition.moveIn(with: .down, duration: 0.6)
            let scene:SKScene = GameOverScene(size: self.size)
            self.view?.presentScene(scene, transition: transition)
        }
    }
}
