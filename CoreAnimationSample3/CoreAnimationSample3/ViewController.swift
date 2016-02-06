//
//  ViewController.swift
//  CoreAnimationSample3
//
//  Created by Carlos Butron on 02/12/14.
//  Copyright (c) 2015 Carlos Butron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var position = true
    
    @IBOutlet weak var image: UIImageView!
    @IBAction func animate(sender: UIButton) {
        
        
        
        if (position){  //SAMPLE2
            
            let animation:CABasicAnimation! = CABasicAnimation(keyPath:"position")
            
            
            animation.toValue = NSValue(CGPoint:CGPointMake(160, 200))
            
            //SAMPLE2
            animation.fillMode = kCAFillModeForwards
            animation.removedOnCompletion = false
            
            
            let resizeAnimation:CABasicAnimation = CABasicAnimation(keyPath:"bounds.size")
            resizeAnimation.toValue = NSValue(CGSize:CGSizeMake(240, 60))
            
            
            
            
            //SAMPLE2
            resizeAnimation.fillMode = kCAFillModeForwards
            resizeAnimation.removedOnCompletion = false
            
            
            //SAMPLE3
            
            UIView.animateWithDuration(5.0, animations:{
                //PROPERTIES CHANGES TO ANIMATE
                self.image.alpha = 0.0
                //alpha to zero in 5 seconds
                }, completion: {(value: Bool) in
                    //when finished animation do this..
                    self.image.alpha = 1.0
                    self.image.layer.addAnimation(animation, forKey: "position")
                    
                    self.image.layer.addAnimation(resizeAnimation, forKey: "bounds.size")
            })
            
            
            
            
            
            
            position = false
        }
        else{
            
            let animation:CABasicAnimation! = CABasicAnimation(keyPath:"position")
            
            animation.fromValue = NSValue(CGPoint:CGPointMake(160, 200))
            
            //SAMPLE2
            animation.fillMode = kCAFillModeForwards
            animation.removedOnCompletion = false
            
            let resizeAnimation:CABasicAnimation = CABasicAnimation(keyPath:"bounds.size")
            resizeAnimation.fromValue = NSValue(CGSize:CGSizeMake(240, 60))
            
            //SAMPLE2
            resizeAnimation.fillMode = kCAFillModeForwards
            resizeAnimation.removedOnCompletion = false
            
            image.layer.addAnimation(animation, forKey: "position")
            
            image.layer.addAnimation(resizeAnimation, forKey: "bounds.size")
            
            position = true
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

