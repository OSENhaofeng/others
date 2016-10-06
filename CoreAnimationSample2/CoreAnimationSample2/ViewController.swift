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
    @IBAction func animate(_ sender: UIButton) {
        
        if (position){ //EXAMPLE2
        
            let animation:CABasicAnimation! = CABasicAnimation(keyPath:"position")
            animation.toValue = NSValue(cgPoint:CGPoint(x: 160, y: 200))
            
            //EXAMPLE2
            animation.fillMode = kCAFillModeForwards
            animation.isRemovedOnCompletion = false
            let resizeAnimation:CABasicAnimation = CABasicAnimation(keyPath:"bounds.size")
            resizeAnimation.toValue = NSValue(cgSize:CGSize(width: 240, height: 60))
            
            //EXAMPLE2
            resizeAnimation.fillMode = kCAFillModeForwards
            resizeAnimation.isRemovedOnCompletion = false
            image.layer.add(animation, forKey: "position")
            image.layer.add(resizeAnimation, forKey: "bounds.size")
            
            position = false
        }
        else{
            
            let animation:CABasicAnimation! = CABasicAnimation(keyPath:"position")
            animation.fromValue = NSValue(cgPoint:CGPoint(x: 160, y: 200))
            
            //EXAMPLE2
            animation.fillMode = kCAFillModeForwards
            animation.isRemovedOnCompletion = false
            let resizeAnimation:CABasicAnimation = CABasicAnimation(keyPath:"bounds.size")
            resizeAnimation.fromValue = NSValue(cgSize:CGSize(width: 240, height: 60))
            
            //EXAMPLE2
            resizeAnimation.fillMode = kCAFillModeForwards
            resizeAnimation.isRemovedOnCompletion = false
            image.layer.add(animation, forKey: "position")
            image.layer.add(resizeAnimation, forKey: "bounds.size")
            
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
