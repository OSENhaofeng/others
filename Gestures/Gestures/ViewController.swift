//
//  ViewController.swift
//  Gestures
//
//  Created by Carlos Butron on 01/12/14.
//  Copyright (c) 2015 Carlos Butron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var netRotation:CGFloat = 0
    
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        
        //ROTATION
        let rotateGesture = UIRotationGestureRecognizer(target: self, action: "rotateGesture:")
        image.addGestureRecognizer(rotateGesture)
        
        //SWIPE
        let swipeGestureRight = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeGestureRight.direction = UISwipeGestureRecognizerDirection.Right
        image.addGestureRecognizer(swipeGestureRight)
        
        let swipeGestureDown = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeGestureDown.direction = UISwipeGestureRecognizerDirection.Down
        image.addGestureRecognizer(swipeGestureDown)
        
        let swipeGestureLeft = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeGestureLeft.direction = UISwipeGestureRecognizerDirection.Left
        image.addGestureRecognizer(swipeGestureLeft)
        
        let swipeGestureUp = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeGestureUp.direction = UISwipeGestureRecognizerDirection.Up
        image.addGestureRecognizer(swipeGestureUp)
        
        //LONG PRESS
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: "action:")
        longPressGesture.minimumPressDuration = 2.0;
        image.addGestureRecognizer(longPressGesture)
        
        image.image = UIImage(named: "image1.png")
        
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //ROTATION
    @IBAction func rotateGesture(sender : UIRotationGestureRecognizer) {
        let rotation:CGFloat = sender.rotation
        let transform:CGAffineTransform  =
        CGAffineTransformMakeRotation(rotation + netRotation)
        sender.view?.transform = transform
        if (sender.state == UIGestureRecognizerState.Ended){
            netRotation += rotation;
        }
    }
    
    //SWIPE
    @IBAction func respondToSwipeGesture(send: UIGestureRecognizer) {
        
        if let swipeGesture = send as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
                changeImage()
                print("Swiped right")
            case UISwipeGestureRecognizerDirection.Down:
                changeImage()
                print("Swiped down")
            case UISwipeGestureRecognizerDirection.Left:
                changeImage()
                print("Swiped left")
            case UISwipeGestureRecognizerDirection.Up:
                changeImage()
                print("Swiped up")
            default:
                break
            }
        }
    }
    
    //LONG PRESS
    @IBAction func action(gestureRecognizer:UIGestureRecognizer) {
        
        if (gestureRecognizer.state == UIGestureRecognizerState.Began){
            let alertController = UIAlertController(title: "Alert", message: "Long Press gesture", preferredStyle: .Alert)
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in }
            alertController.addAction(OKAction)
            self.presentViewController(alertController, animated: true) { }
        }
    }
    
    func changeImage(){
        if (image.image == UIImage(named: "image1.png")){
            image.image = UIImage(named: "image2.png")}
        else{
            image.image = UIImage(named: "image1.png")
        }
    }
 
}
