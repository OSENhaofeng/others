//
//  ViewController.swift
//  Protocol-Delegate
//
//  Created by Carlos Butron on 05/11/15.
//  Copyright © 2015 Carlos Butron. All rights reserved.
//

import UIKit

class ViewController: UIViewController, myDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myRequest: myObject = myObject()
        myRequest.delegate = self
        myRequest.start()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func delegateMethod() {
            print("Received message")
    }


}

