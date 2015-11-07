//
//  Game.swift
//  SpriteKit
//
//  Created by Carlos Butron on 13/04/15.
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

class Game: SKScene, SKPhysicsContactDelegate {
    
    let score = SKLabelNode(fontNamed:"Chalkduster")
    var points = 0
    enum ColliderType: UInt32 {
        case Player = 1
        case Target = 2
    }
    var target:SKSpriteNode!
    var value:Float = 0.0
    @IBAction func manejarSlider(sender:UISlider){
        value = sender.value
    }
    
    override func didMoveToView(view: SKView) {
        
        //define physics
        self.physicsWorld.contactDelegate = self
        let size2 = CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height)
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect:size2)
        
        //define the player
        let player = SKSpriteNode(color: UIColor.redColor(), size: CGSizeMake(50, 50))
        player.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(50, 50))
        player.position = CGPointMake(200,25)
        player.name = "Player"
        player.physicsBody?.categoryBitMask = ColliderType.Player.rawValue
        player.physicsBody?.collisionBitMask = ColliderType.Target.rawValue
        player.physicsBody?.contactTestBitMask = ColliderType.Target.rawValue
        self.addChild(player)
        
        //define target
        target = SKSpriteNode(color: UIColor.greenColor(), size: CGSizeMake(20, 20))
        target.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(50, 50))
        target.physicsBody?.dynamic = false
        target.position = CGPointMake(200, 530)
        target.name = "Target"
        target.physicsBody?.categoryBitMask = ColliderType.Target.rawValue
        target.physicsBody?.collisionBitMask = ColliderType.Player.rawValue
        target.physicsBody?.contactTestBitMask = ColliderType.Player.rawValue
        self.addChild(target)
        
        //to move
        let move = SKAction.sequence([SKAction.moveTo(CGPointMake(0, 530), duration: 2.0),SKAction.moveTo(CGPointMake(320, 530), duration: 2.0)])
        let moveConstant = SKAction.repeatActionForever(move)
        target.runAction(moveConstant)
        
        
        //actual score
        score.text = "Score: \(points)";
        score.name = "Points"
        score.fontSize = 15;
        score.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        self.addChild(score)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //on touch shoot
        var operation:CGFloat = 250.0
        operation *= (CGFloat)(self.value)
        self.childNodeWithName("Player")?.physicsBody?.applyForce(CGVectorMake (operation, 20000))
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func didBeginContact(contact: SKPhysicsContact){
        //if bodys impact
        var firstBody:SKPhysicsBody
        var secondBody:SKPhysicsBody
        if(contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask){
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        if(firstBody.categoryBitMask == 1 && secondBody.categoryBitMask == 2){
            //if impact:
            //update score (delete and add label)
            points++
            self.childNodeWithName("Points")?.removeFromParent()
            score.text = "Score: \(points)"
            self.addChild(score)
            //delete object
            secondBody.node?.removeFromParent()
            //wait a second and show object
            let delay = SKAction.waitForDuration(1)
            let generar = SKAction.runBlock({
                self.addChild(self.target)
            })
            let secuency = SKAction.sequence([delay,generar])
            self.runAction(secuency)
        }
    }
    
    
}

