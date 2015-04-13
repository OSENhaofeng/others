//
//  GameScene.swift
//  SpriteKit
//
//  Created by Carlos Butron on 07/12/14.
//  Copyright (c) 2014 Carlos Butron.
//
//  This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public
//  License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later
//  version.
//  This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
//  warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
//  You should have received a copy of the GNU General Public License along with this program. If not, see
//  http:/www.gnu.org/licenses/.
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
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        //on touch change scene
        var myTransition = SKTransition.doorsOpenVerticalWithDuration(1.0)
        var game = Game(size: self.size)
        self.scene?.view?.presentScene(game, transition: myTransition)
    }
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}