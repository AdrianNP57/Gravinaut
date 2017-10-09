//
//  GameViewController.swift
//  Gravinaut
//
//  Created by Adrian on 18/03/2017.
//  Copyright © 2017 AdrianNP57. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation
import SpriteKit

class GameViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Starting MainSceneScene.swift
        let scene = MainMenuScene(size: view.bounds.size)
        
        // Matching scene size with the iPhone size
        scene.scaleMode = .resizeFill
        
        // View
        let skView = self.view as! SKView
        
        // 30 FPS - Thanks for the help! http://stackoverflow.com/questions/41761176/purposely-slowing-down-fps-spritekit/41764180
        skView.preferredFramesPerSecond = 30 // Fix to 30 fps, without this property there's no limit
        
        // Debug options
        skView.showsFPS = false
        skView.showsNodeCount = false
        skView.ignoresSiblingOrder = true
        skView.presentScene(scene)
        
        // Music ON - Thanks for the help! https://github.com/icanzilb
        SKTAudio.sharedInstance().playBackgroundMusic("Space.mp3") //
        
    }
    override var prefersStatusBarHidden: Bool
    {
        return true
    }
    
}
