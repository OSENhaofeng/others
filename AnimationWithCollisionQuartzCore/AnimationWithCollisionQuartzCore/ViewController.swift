//
//  ViewController.swift
//  AnimationWithCollisionQuartzCore
//
//  Created by Carlos Butron on 02/12/14.
//  Copyright (c) 2015 Carlos Butron. All rights reserved.
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



class ViewController: UIViewController, UICollisionBehaviorDelegate {
    
    @IBOutlet weak var gravity: UIButton!
    @IBOutlet weak var push: UIButton!
    @IBOutlet weak var attachment: UIButton!
    
    //AMPLIACION
    var collision: UICollisionBehavior!
    
    
    @IBAction func gravity(sender: UIButton) {
        animator.removeAllBehaviors()
        //gravity, push y attachment son los IBOutlets correspondientes
        let gravity = UIGravityBehavior(items: [self.gravity,self.push,self.attachment])
        animator.addBehavior(gravity)
        
        collision = UICollisionBehavior(items: [self.push, self.gravity, self.attachment])
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
    }
    
    @IBAction func push(sender: AnyObject) {
        animator.removeAllBehaviors()
        let push = UIPushBehavior(items: [self.gravity,self.push,self.attachment], mode:UIPushBehaviorMode.Instantaneous)
        push.magnitude = 2
        
        animator.addBehavior(push)
        
        collision = UICollisionBehavior(items: [self.push, self.gravity, self.attachment])
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
    }
    
    var attachmentBehavior: UIAttachmentBehavior? = nil
    @IBAction func attachment(sender: AnyObject) {
        animator.removeAllBehaviors()
        let anchorPoint = CGPointMake(self.attachment.center.x, self.attachment.center.y)
        attachmentBehavior = UIAttachmentBehavior(item: self.attachment, attachedToAnchor: anchorPoint)
        attachmentBehavior!.frequency = 0.5
        attachmentBehavior!.damping = 2
        attachmentBehavior!.length = 20
        animator.addBehavior(attachmentBehavior!)
        collision = UICollisionBehavior(items: [self.push, self.gravity, self.attachment])
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
    }
    
    @IBAction func handleAttachment(sender: UIPanGestureRecognizer) {
        if((attachmentBehavior) != nil){
            attachmentBehavior!.anchorPoint = sender.locationInView(self.view)
        }
    }
    
    
    var animator = UIDynamicAnimator()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        animator = UIDynamicAnimator(referenceView: self.view)
    }
    
    override func viewDidAppear(animated: Bool) {
        let max: CGRect = UIScreen.mainScreen().bounds
        let snap1 = UISnapBehavior(item: self.gravity, snapToPoint: CGPointMake(max.size.width/2, max.size.height/2 - 50))
        let snap2 = UISnapBehavior(item: self.push, snapToPoint: CGPointMake(max.size.width/2, max.size.height/2 ))
        let snap3 = UISnapBehavior(item: self.attachment, snapToPoint: CGPointMake(max.size.width/2, max.size.height/2 + 50))
        snap1.damping = 1
        snap2.damping = 2
        snap3.damping = 4
        animator.addBehavior(snap1)
        animator.addBehavior(snap2)
        animator.addBehavior(snap3)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}


