//
//  MainMenuScene.swift
//  Gravinaut
//
//  Created by Adrian on 18/03/2017.
//  Copyright © 2017 AdrianNP57. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class ExitScene: SKScene
{
    var buttonControl = -1
    
    var MainBackground = SKSpriteNode(imageNamed: "MainBackground")
    
    // Tittle
    var mainTittleLabel = SKLabelNode(fontNamed: "PressStart2P")
    
    var mainTittleBackground = SKSpriteNode(imageNamed: "blackBackgroundTexture")
    
    // "Are you sure you want to exit?" Scene
    var exitBackground = SKSpriteNode(imageNamed: "blackBackgroundTexture")
    
    var yesButton = SKSpriteNode(imageNamed: "ButtonTexture")
    
    var noButton = SKSpriteNode(imageNamed: "ButtonTexture")
    
    var yesButton_onHold = SKSpriteNode(imageNamed: "ButtonHoldTexture")
    
    var noButton_onHold = SKSpriteNode(imageNamed: "ButtonHoldTexture")
    
    var exitLabel1 = SKLabelNode(fontNamed: "PressStart2P")
    var exitLabel2 = SKLabelNode(fontNamed: "PressStart2P")
    
    var yesLabel = SKLabelNode(fontNamed: "PressStart2P")
    
    var noLabel = SKLabelNode(fontNamed: "PressStart2P")
    
    // On scene charge
    override func didMove(to view: SKView)
    {
        // Positioning elements main menu
        
         MainBackground.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
         MainBackground.zPosition = 0
         self.addChild(MainBackground)
 
        // Main Tittle Background
        mainTittleBackground.position = CGPoint(x: size.width * 0.5, y: size.height * 0.825)
        mainTittleBackground.size = CGSize(width: mainTittleBackground.size.width*2.8, height: mainTittleBackground.size.height*1.5)
        mainTittleBackground.zPosition = 1
        self.addChild(mainTittleBackground)
        
        // Main Tittle Static
        mainTittleLabel.text = "GRAVINAUT"
        mainTittleLabel.fontSize = 29
        mainTittleLabel.fontColor = SKColor.white
        mainTittleLabel.position = CGPoint(x: size.width * 0.5, y: size.height * 0.8)
        mainTittleLabel.zPosition = 2
        self.addChild(mainTittleLabel)
        
        // Main Tittle Dynamic
        /*
        let moveDown = SKAction.moveBy(x: 0, y: size.height * 0.01, duration: 1)
        let sequence = SKAction.sequence([moveDown, moveDown.reversed()])
        mainTittleLabel.run(SKAction.repeatForever(sequence), withKey: "tittleMoving")
         */
        
        // Positioning elements exit menu
        exitBackground.position = CGPoint(x: frame.size.width * 0.5, y: frame.size.height * 0.5)
        exitBackground.size = CGSize(width: exitBackground.size.width*2.8, height: exitBackground.size.height*3.5)
        exitBackground.zPosition = 1
        self.addChild(exitBackground)
        
        yesButton.position = CGPoint(x: size.width * 0.27, y: size.height * 0.43)
        yesButton.zPosition = 2
        self.addChild(yesButton)
        
        noButton.position = CGPoint(x: size.width * 0.70, y: size.height * 0.43)
        noButton.zPosition = 2
        self.addChild(noButton)
        
        yesButton_onHold.position = CGPoint(x: size.width * 0.27, y: size.height * 0.43)
        yesButton_onHold.zPosition = 2
        
        noButton_onHold.position = CGPoint(x: size.width * 0.70, y: size.height * 0.43)
        noButton_onHold.zPosition = 2
        
        // exitLabel1
        exitLabel1.text = "Do you want"
        exitLabel1.fontSize = 28
        exitLabel1.fontColor = SKColor.white
        exitLabel1.position = CGPoint(x: size.width * 0.49, y: size.height * 0.57)
        exitLabel1.zPosition = 3
        self.addChild(exitLabel1)
        
        // exitLabel2
        exitLabel2.text = "to quit?"
        exitLabel2.fontSize = 28
        exitLabel2.fontColor = SKColor.white
        exitLabel2.position = CGPoint(x: size.width * 0.49, y: size.height * 0.52)
        exitLabel2.zPosition = 3
        self.addChild(exitLabel2)
        
        // Label play
        yesLabel.text = "YES"
        yesLabel.fontSize = 28
        yesLabel.fontColor = SKColor.white
        yesLabel.position = CGPoint(x: size.width * 0.265, y: size.height * 0.41)
        yesLabel.zPosition = 3
        self.addChild(yesLabel)
        
        // Label quit
        noLabel.text = "NO"
        noLabel.fontSize = 28
        noLabel.fontColor = SKColor.white
        noLabel.position = CGPoint(x: size.width * 0.70, y: size.height * 0.41)
        noLabel.zPosition = 3
        self.addChild(noLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if let touch = touches.first
        {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            
            if (node == yesButton || node==yesLabel)
            {
                buttonControl=0
                yesButton.removeFromParent()
                self.addChild(yesButton_onHold)
                yesLabel.position = CGPoint(x: size.width * 0.277, y: size.height * 0.40)
            }
            else if (node == noButton || node==noLabel)
            {
                buttonControl=1
                noButton.removeFromParent()
                self.addChild(noButton_onHold)
                noLabel.position = CGPoint(x: size.width * 0.712, y: size.height * 0.40)
            }
            else
            {
                buttonControl = -1
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if let touch = touches.first
        {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            
            if buttonControl == 0
            {
                yesButton_onHold.removeFromParent()
                self.addChild(yesButton)
                yesLabel.position = CGPoint(x: size.width * 0.265, y: size.height * 0.41)
            }
            else if buttonControl == 1
            {
                noButton_onHold.removeFromParent()
                self.addChild(noButton)
                noLabel.position = CGPoint(x: size.width * 0.70, y: size.height * 0.41)
            }
            
            if (node == yesButton_onHold || node == yesLabel)
            {
                exit(0)
            }
            if (node == noButton_onHold || node==noLabel)
            {
                let transition = SKTransition.fade(withDuration: 0)
                let scene:SKScene = MainMenuScene(size: self.size)
                self.view?.presentScene(scene, transition: transition)
            }
        }
    }
}
