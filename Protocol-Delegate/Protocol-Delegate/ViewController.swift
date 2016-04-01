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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func delegateMethod() {
            print("Received message")
    }

}
