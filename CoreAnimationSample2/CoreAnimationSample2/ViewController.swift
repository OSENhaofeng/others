//
//  ViewController.swift
//  CoreAnimationSample2
//
//  Created by Carlos Butron on 02/12/14.
//  Copyright (c) 2015 Carlos Butron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var position = true
    
    @IBOutlet weak var image: UIImageView!
    @IBAction func animate(sender: UIButton) {
        
        if (position){ //EXAMPLE2
        
            let animation:CABasicAnimation! = CABasicAnimation(keyPath:"position")
            animation.toValue = NSValue(CGPoint:CGPointMake(160, 200))
            
            //EXAMPLE2
            animation.fillMode = kCAFillModeForwards
            animation.removedOnCompletion = false
            let resizeAnimation:CABasicAnimation = CABasicAnimation(keyPath:"bounds.size")
            resizeAnimation.toValue = NSValue(CGSize:CGSizeMake(240, 60))
            
            //EXAMPLE2
            resizeAnimation.fillMode = kCAFillModeForwards
            resizeAnimation.removedOnCompletion = false
            image.layer.addAnimation(animation, forKey: "position")
            image.layer.addAnimation(resizeAnimation, forKey: "bounds.size")
            
            position = false
        }
        else{
            
            let animation:CABasicAnimation! = CABasicAnimation(keyPath:"position")
            animation.fromValue = NSValue(CGPoint:CGPointMake(160, 200))
            
            //EXAMPLE2
            animation.fillMode = kCAFillModeForwards
            animation.removedOnCompletion = false
            let resizeAnimation:CABasicAnimation = CABasicAnimation(keyPath:"bounds.size")
            resizeAnimation.fromValue = NSValue(CGSize:CGSizeMake(240, 60))
            
            //EXAMPLE2
            resizeAnimation.fillMode = kCAFillModeForwards
            resizeAnimation.removedOnCompletion = false
            image.layer.addAnimation(animation, forKey: "position")
            image.layer.addAnimation(resizeAnimation, forKey: "bounds.size")
            
            position = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
