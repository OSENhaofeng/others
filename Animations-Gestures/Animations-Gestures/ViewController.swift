//
//  ViewController.swift
//  Animations-Gestures
//
//  Created by Carlos Butron on 14/11/15.
//  Copyright © 2015 Carlos Butron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var penguinView: UIImageView!
    
    var frames: NSArray?
    var dieCenter: CGPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        let image1 = UIImage(named:"penguin_walk01")!
        let image2 = UIImage(named:"penguin_walk02")!
        let image3 = UIImage(named:"penguin_walk03")!
        let image4 = UIImage(named:"penguin_walk04")!
        
        let frames: [UIImage] = [image1, image2, image3, image4]
        
        
        penguinView.animationDuration = 0.15;
        penguinView.animationRepeatCount = 2;
        penguinView.animationImages = frames;
        
        
        
        //walk right
        let swipeGestureRight = UISwipeGestureRecognizer(target: self, action: "walkRight:")
        swipeGestureRight.direction = UISwipeGestureRecognizerDirection.Right
        view.addGestureRecognizer(swipeGestureRight)
        
        //walk left
        let swipeGestureLeft = UISwipeGestureRecognizer(target: self, action: "walkLeft:")
        swipeGestureLeft.direction = UISwipeGestureRecognizerDirection.Left
        view.addGestureRecognizer(swipeGestureLeft)
        

        //jump
        let tap = UITapGestureRecognizer(target: self, action: "jump:")
        view.addGestureRecognizer(tap)
        

        //longPress
        let longPress = UILongPressGestureRecognizer(target: self, action: "longPress:")
        view.addGestureRecognizer(longPress)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }






func walkLeft(send: UIGestureRecognizer) {

    print("walk left");
    //CHECK IF OUT OF SCREEN
    if (penguinView.center.x < 0.0) {
        penguinView.center = CGPointMake(view.frame.size.width, penguinView.center.y);
    }
    
    //FLIP AROUND FOR WALKING LEFT
    self.penguinView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    
    //START WALK ANIMATION
    penguinView.startAnimating()
    
    //MOVE THE IMAGE VIEW TO LEFT
    
    
    
    UIView.animateWithDuration(0.6, animations: { () -> Void in
        
        self.penguinView.center = CGPointMake(self.penguinView.center.x - 30, self.penguinView.center.y);
        
        })
    
    
    
}


func walkRight(send: UIGestureRecognizer) {
    
    print("walk right");
            
    if (self.penguinView.center.x > self.view.frame.size.width) {
            self.penguinView.center = CGPointMake(0, self.penguinView.center.y);
            }
            
    self.penguinView.transform = CGAffineTransformIdentity;
            
    penguinView.startAnimating()
            
    UIView.animateWithDuration(0.6, animations: { () -> Void in
                
    self.penguinView.center = CGPointMake(self.penguinView.center.x + 30, self.penguinView.center.y)
                
    })
            
}

func jump(send: UIGestureRecognizer) {
    
    penguinView.startAnimating()
    
    UIView.animateWithDuration(0.25, animations: { () -> Void in
        
        self.penguinView.center = CGPointMake(self.penguinView.center.x, self.penguinView.center.y - 50)
        
        }, completion: { (finished: Bool) -> Void in
            
            self.jumpBack()
    })
    
}
    
func jumpBack()
    {
        
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            
            self.penguinView.center = CGPointMake(self.penguinView.center.x, self.penguinView.center.y + 50)
            
        })
       
}

func longPress(send: UIGestureRecognizer) {
    
    UIView.animateWithDuration(0.33, animations: { () -> Void in
        
        self.dieCenter = self.penguinView.center
        self.penguinView.center = CGPointMake(self.penguinView.center.x, self.view.frame.size.height)
        
        }, completion: { (finished: Bool) -> Void in
            
            self.longPressBack()
    })
    
    
}

func longPressBack() {
    
    UIView.animateWithDuration(0.25, animations: { () -> Void in
        
        self.penguinView.center = self.dieCenter!
        
    })
    
}




}





