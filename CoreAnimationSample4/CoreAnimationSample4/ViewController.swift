//
//  ViewController.swift
//  CoreAnimationSample4
//
//  Created by Carlos Butron on 02/12/14.
//  Copyright (c) 2015 Carlos Butron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var position = true
    
    @IBOutlet weak var image: UIImageView!
    @IBAction func animate(_ sender: UIButton) {
        
        if (position){ 
            
            //SAMPLE 3
            let subLayer : CALayer = self.image.layer
            let thePath : CGMutablePath = CGMutablePath();
            
            CGPathMoveToPoint(thePath, nil, 160.0, 200.0);
            CGPathAddCurveToPoint(thePath, nil, 83.0, 50.0, 100.0, 100.0, 160.0, 200.0);
            let theAnimation: CAKeyframeAnimation = CAKeyframeAnimation(keyPath:"position")
            theAnimation.path = thePath
            theAnimation.duration = 5.0
            theAnimation.fillMode = kCAFillModeForwards
            theAnimation.isRemovedOnCompletion = false
            
            let resizeAnimation:CABasicAnimation = CABasicAnimation(keyPath:"bounds.size")
            resizeAnimation.toValue = NSValue(cgSize:CGSize(width: 240, height: 60))
            
            //SAMPLE 2
            resizeAnimation.duration = 5.0
            resizeAnimation.fillMode = kCAFillModeForwards
            resizeAnimation.isRemovedOnCompletion = false
            subLayer.add(theAnimation, forKey: "position")
            image.layer.add(resizeAnimation, forKey: "bounds.size")
            
            position = false
        }
        else{
            let animation:CABasicAnimation! = CABasicAnimation(keyPath:"position")
            animation.fromValue = NSValue(cgPoint:CGPoint(x: 160, y: 200))
            
            //SAMPLE 2
            animation.fillMode = kCAFillModeForwards
            animation.isRemovedOnCompletion = false
            let resizeAnimation:CABasicAnimation = CABasicAnimation(keyPath:"bounds.size")
            resizeAnimation.fromValue = NSValue(cgSize:CGSize(width: 240, height: 60))
            
            //SAMPLE 2
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
