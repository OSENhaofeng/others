//
//  ViewController.swift
//  SwiftNSUserDefaultsTutorial
//
//  Created by Carlos Butron on 01/11/15.
//  Copyright © 2015 Carlos Butron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var preferenceSwitch: UISwitch!
    
    @IBAction func savePreferenceState(sender: AnyObject) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if preferenceSwitch.on {
            defaults.setBool(true, forKey: "SwitchState")
        } else {
            defaults.setBool(false, forKey: "SwitchState")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if (defaults.objectForKey("SwitchState") != nil) {
            preferenceSwitch.on = defaults.boolForKey("SwitchState")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
