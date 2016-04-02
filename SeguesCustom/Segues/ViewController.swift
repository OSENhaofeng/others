//
//  ViewController.swift
//  Segues
//
//  Created by Carlos Butron on 07/12/14.
//  Copyright (c) 2015 Carlos Butron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier=="NewClass"){
            let myDestVC = segue.destinationViewController as! NewClassViewController
            myDestVC.labelName = "text"
        }
    }
    
}
