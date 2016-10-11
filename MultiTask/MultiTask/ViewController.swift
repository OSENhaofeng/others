//
//  ViewController.swift
//  MultiTask
//
//  Created by Carlos Butron on 13/04/15.
//  Copyright (c) 2015 Carlos Butron.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var myNotification: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.updateInterface(_:)), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
    }
    
    func updateInterface (_ notification: Notification){
        myNotification.text = "Back to background with notification"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
