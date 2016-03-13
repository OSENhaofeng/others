//
//  ViewController.swift
//  CheckConnectivity
//
//  Created by Mukesh Thawani on 09/12/15.
//  Copyright © 2015 Mukesh Thawani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var checkingLabel: UILabel!
    
    override func viewDidAppear(animated: Bool) {
        checkConnectivity()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func checkConnectivity() {
        print(Reachability.isConnectedToNetwork(), terminator: "")
        if Reachability.isConnectedToNetwork() == false {
            let alert = UIAlertController(title: "Alert", message: "Internet is not working", preferredStyle: UIAlertControllerStyle.Alert)
            self.presentViewController(alert, animated: false, completion: nil)
            let okAction = UIAlertAction(title: "Retry", style: UIAlertActionStyle.Default) {
                UIAlertAction in
                alert.dismissViewControllerAnimated(false, completion: nil)
                self.checkConnectivity()
            }
            alert.addAction(okAction)
            checkingLabel.text = ""
        }
        else {
            checkingLabel.text = "Connected"
        }
    }
}
