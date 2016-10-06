//
//  ViewController.swift
//  GesturesInterfaceBuilder
//
//  Created by Carlos Butron on 01/12/14.
//  Copyright (c) 2015 Carlos Butron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //SWIPE
    @IBAction func respondToSwipeGesture(_ send: UIGestureRecognizer) {
        alert("Swipe")
    }
    
    //LONG PRESS
    @IBAction func action(_ gestureRecognizer:UIGestureRecognizer) {
        
        if (gestureRecognizer.state == UIGestureRecognizerState.began){
            alert("Long Press")
        }
    }
    
    func alert(_ myString: String){
        let alertController = UIAlertController(title: "Alert", message: myString, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true) { }
    }
    
}
