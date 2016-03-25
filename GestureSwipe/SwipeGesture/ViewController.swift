//
//  ViewController.swift
//  SwipeGesture
//
//  Created by Carlos Butron on 01/12/14.
//  Copyright (c) 2015 Carlos Butron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var image2: UIImageView!
    
    override func viewDidLoad() {
        
        let swipeGestureRight = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeGestureRight.direction = UISwipeGestureRecognizerDirection.Right
        image2.addGestureRecognizer(swipeGestureRight)
        
        let swipeGestureDown = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeGestureDown.direction = UISwipeGestureRecognizerDirection.Down
        image2.addGestureRecognizer(swipeGestureDown)
        
        let swipeGestureLeft = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeGestureLeft.direction = UISwipeGestureRecognizerDirection.Left
        image2.addGestureRecognizer(swipeGestureLeft)
        
        let swipeGestureUp = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeGestureUp.direction = UISwipeGestureRecognizerDirection.Up
        image2.addGestureRecognizer(swipeGestureUp)
        
        super.viewDidLoad()
        
        image2.image = UIImage(named: "apple.png")
    }
    
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
    
    func changeImage(){
        if (image2.image == UIImage(named: "apple.png")){
            image2.image = UIImage(named: "image1.png")}
        else{
            image2.image = UIImage(named: "apple.png")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
