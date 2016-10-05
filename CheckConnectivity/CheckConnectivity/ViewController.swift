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
    
    override func viewDidAppear(_ animated: Bool) {
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
            let alert = UIAlertController(title: "Alert", message: "Internet is not working", preferredStyle: UIAlertControllerStyle.alert)
            self.present(alert, animated: false, completion: nil)
            let okAction = UIAlertAction(title: "Retry", style: UIAlertActionStyle.default) {
                UIAlertAction in
                alert.dismiss(animated: false, completion: nil)
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
