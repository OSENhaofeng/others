//
//  ViewController.swift
//  GestureLongPress
//
//  Created by Carlos Butron on 01/12/14.
//  Copyright (c) 2015 Carlos Butron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: "action:")
        longPressGesture.minimumPressDuration = 2.0;
        image.addGestureRecognizer(longPressGesture)
        
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func action(gestureRecognizer:UIGestureRecognizer) {
        
        if (gestureRecognizer.state == UIGestureRecognizerState.Began){
            
            let alertController = UIAlertController(title: "Alert", message: "Long Press gesture", preferredStyle: .Alert)
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in }
            alertController.addAction(OKAction)
            self.presentViewController(alertController, animated: true) { }
        }
    }
    
}
