//
//  MainMenuScene.swift
//  Gravinaut
//
//  Created by Adrián Navarro Pérez on 18/03/2017.
//  Copyright © 2017 AdrianNP57. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit
import SpriteKit

class MainMenuScene: SKScene
{
    var buttonControl = -1
    
    var MainBackground = SKSpriteNode(imageNamed: "MainBackground")
    
    // Tittle
    var mainTittleLabel = SKLabelNode(fontNamed: "PressStart2P")
    
    var mainTittleBackground = SKSpriteNode(imageNamed: "blackBackgroundTexture")
    
    // Botones Play/Quit con sus correspondientes labels.
    var playButton = SKSpriteNode(imageNamed: "ButtonTexture")
    
    var quitButton = SKSpriteNode(imageNamed: "ButtonTexture")
    
    var playButton_onHold = SKSpriteNode(imageNamed: "ButtonHoldTexture")
    
    var quitButton_onHold = SKSpriteNode(imageNamed: "ButtonHoldTexture")
    
    var playLabel = SKLabelNode(fontNamed: "PressStart2P")
    
    var quitLabel = SKLabelNode(fontNamed: "PressStart2P")
    
    // On scene charge
    override func didMove(to view: SKView)
    {
        // Positioning elements main menu
        
        MainBackground.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        MainBackground.zPosition = 0
        self.addChild(MainBackground)
        
        playButton.position = CGPoint(x: size.width * 0.25, y: size.height * 0.25)
        playButton.zPosition = 1
        self.addChild(playButton)
        
        quitButton.position = CGPoint(x: size.width * 0.75, y: size.height * 0.25)
        quitButton.zPosition = 1
        self.addChild(quitButton)
        
        playButton_onHold.position = CGPoint(x: size.width * 0.25, y: size.height * 0.25)
        playButton_onHold.zPosition = 1
        
        quitButton_onHold.position = CGPoint(x: size.width * 0.75, y: size.height * 0.25)
        quitButton_onHold.zPosition = 1
        
        // Main Tittle Background
        mainTittleBackground.position = CGPoint(x: size.width * 0.5, y: size.height * 0.825)
        mainTittleBackground.size = CGSize(width: mainTittleBackground.size.width*2.8, height: mainTittleBackground.size.height*1.5)
        mainTittleBackground.zPosition = 1
        self.addChild(mainTittleBackground)
        
        // Main Tittle
        mainTittleLabel.text = "GRAVINAUT"
        mainTittleLabel.fontSize = 29
        mainTittleLabel.fontColor = SKColor.white
        mainTittleLabel.position = CGPoint(x: size.width * 0.5, y: size.height * 0.8)
        mainTittleLabel.zPosition = 2
        self.addChild(mainTittleLabel)
        
        // Label play
        playLabel.text = "PLAY"
        playLabel.fontSize = 28
        playLabel.fontColor = SKColor.white
        playLabel.position = CGPoint(x: size.width * 0.245, y: size.height * 0.23)
        playLabel.zPosition = 2
        self.addChild(playLabel)
        
        // Label quit
        quitLabel.text = "QUIT"
        quitLabel.fontSize = 28
        quitLabel.fontColor = SKColor.white
        quitLabel.position = CGPoint(x: size.width * 0.745, y: size.height * 0.23)
        quitLabel.zPosition = 2
        self.addChild(quitLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if let touch = touches.first
        {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            
            if (node == playButton || node==playLabel)
            {
                buttonControl=0
                playButton.removeFromParent()
                self.addChild(playButton_onHold)
                playLabel.position = CGPoint(x: size.width * 0.257, y: size.height * 0.22)
            }
            else if (node == quitButton || node==quitLabel)
            {
                buttonControl=1
                quitButton.removeFromParent()
                self.addChild(quitButton_onHold)
                quitLabel.position = CGPoint(x: size.width * 0.757, y: size.height * 0.22)
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
                playButton_onHold.removeFromParent()
                self.addChild(playButton)
                playLabel.position = CGPoint(x: size.width * 0.245, y: size.height * 0.23)
            }
            else if buttonControl == 1
            {
                quitButton_onHold.removeFromParent()
                self.addChild(quitButton)
                quitLabel.position = CGPoint(x: size.width * 0.745, y: size.height * 0.23)
            }
            
            if (node == playButton_onHold || node == playLabel)
            {
                let transition = SKTransition.fade(withDuration: 1)
                let scene:SKScene = GameScene(size: self.size)
                self.view?.presentScene(scene, transition: transition)
            }
            if (node == quitButton_onHold || node==quitLabel)
            {
                let transition = SKTransition.fade(withDuration: 0)
                let scene:SKScene = ExitScene(size: self.size)
                self.view?.presentScene(scene, transition: transition)
            }
        }
    }
}
