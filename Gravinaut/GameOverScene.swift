//
//  GameOverScene.swift
//  Gravinaut
//
//  Created by Adrián Navarro Pérez on 18/03/2017.
//  Copyright © 2017 AdrianNP57. All rights reserved.
//

import UIKit
import Foundation
import SpriteKit

class GameOverScene: SKScene
{
    var buttonControl = -1
    
    var MainBackground = SKSpriteNode(imageNamed: "MainBackground")
    
    // Tittle
    var mainTittleLabel = SKLabelNode(fontNamed: "PressStart2P")
    
    var mainTittleBackground = SKSpriteNode(imageNamed: "blackBackgroundTexture")
    
    // // "Do you want to retry?" Scene
    var exitBackground = SKSpriteNode(imageNamed: "blackBackgroundTexture")
    
    var yesButton = SKSpriteNode(imageNamed: "ButtonTexture")
    
    var noButton = SKSpriteNode(imageNamed: "ButtonTexture")
    
    var yesButton_onHold = SKSpriteNode(imageNamed: "ButtonHoldTexture")
    
    var noButton_onHold = SKSpriteNode(imageNamed: "ButtonHoldTexture")
    
    var retryLabel1 = SKLabelNode(fontNamed: "PressStart2P")
    var retryLabel2 = SKLabelNode(fontNamed: "PressStart2P")
    
    var yesLabel = SKLabelNode(fontNamed: "PressStart2P")
    
    var noLabel = SKLabelNode(fontNamed: "PressStart2P")
    
    // On scene charge
    override func didMove(to view: SKView)
    {
        // Positioning elements main menu
        
        MainBackground.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        MainBackground.zPosition = 0
        self.addChild(MainBackground)
        
        
        // Alternative background
        /*
         backgroundColor = UIColor(red: 4/255.0, green: 14/255.0, blue: 97/255.0, alpha: 1.0)
         */
        
        // Main Tittle Background
        mainTittleBackground.position = CGPoint(x: size.width * 0.5, y: size.height * 0.825)
        mainTittleBackground.size = CGSize(width: mainTittleBackground.size.width*2.8, height: mainTittleBackground.size.height*1.5)
        mainTittleBackground.zPosition = 1
        self.addChild(mainTittleBackground)
        
        // Main Tittle static
        mainTittleLabel.text = "GAME OVER"
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
        
        // retryLabel1
        retryLabel1.text = "Do you want"
        retryLabel1.fontSize = 28
        retryLabel1.fontColor = SKColor.white
        retryLabel1.position = CGPoint(x: size.width * 0.49, y: size.height * 0.57)
        retryLabel1.zPosition = 3
        self.addChild(retryLabel1)
        
        // retryLabel2
        retryLabel2.text = "to retry?"
        retryLabel2.fontSize = 28
        retryLabel2.fontColor = SKColor.white
        retryLabel2.position = CGPoint(x: size.width * 0.49, y: size.height * 0.52)
        retryLabel2.zPosition = 3
        self.addChild(retryLabel2)
        
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
                let transition = SKTransition.fade(withDuration: 0.5)
                let scene:SKScene = GameScene(size: self.size)
                self.view?.presentScene(scene, transition: transition)
            }
            if (node == noButton_onHold || node==noLabel)
            {
                let transition = SKTransition.fade(withDuration: 1)
                let scene:SKScene = MainMenuScene(size: self.size)
                self.view?.presentScene(scene, transition: transition)
            }
        }
    }
}
