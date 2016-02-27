//
//  GameScene.swift
//  SpriteKit Game
//
//  Created by Carlos Butron on 07/11/15.
//  Copyright © 2015 Carlos Butron. All rights reserved.
//


import UIKit
import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Main menu */
        self.backgroundColor = UIColor(red: 0.15, green: 0.15, blue: 0.3, alpha: 1.0)
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Game with SpriteKit"
        myLabel.fontSize = 20
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        self.addChild(myLabel)
        let myLabel2 = SKLabelNode(fontNamed:"Chalkduster")
        myLabel2.text = "Touch to start"
        myLabel2.fontSize = 15
        myLabel2.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) - 100);
        self.addChild(myLabel2)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //on touch change scene
        let myTransition = SKTransition.doorsOpenVerticalWithDuration(1.0)
        let game = Game(size: self.size)
        self.scene?.view?.presentScene(game, transition: myTransition)
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}


