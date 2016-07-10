//
//  ViewController.swift
//  RotateGesture
//
//  Created by Carlos Butron on 01/12/14.
//  Copyright (c) 2015 Carlos Butron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var netRotation:CGFloat = 0
    
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(ViewController.rotateGesture(_:)))
        image.addGestureRecognizer(rotateGesture)
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func rotateGesture(sender : UIRotationGestureRecognizer) {
        let rotation:CGFloat = sender.rotation
        let transform:CGAffineTransform  = CGAffineTransformMakeRotation(rotation + netRotation)
        sender.view?.transform = transform
        if (sender.state == UIGestureRecognizerState.Ended){
            netRotation += rotation;
        }
    }
    
}
