//
//  ViewController.swift
//  SegueWithpresentViewController
//
//  Created by Carlos Butron on 07/12/14.
//  Copyright (c) 2014 Carlos Butron.
//
//  This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public
//  License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later
//  version.
//  This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
//  warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
//  You should have received a copy of the GNU General Public License along with this program. If not, see
//  http:/www.gnu.org/licenses/.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func buttonAction(sender: UIButton) {
        var storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        var viewController:UIViewController = storyboard.instantiateViewControllerWithIdentifier("NewViewController") as! UIViewController
        self.presentViewController(viewController, animated: true,
            completion: nil)
    }
    
    
    @IBAction func buttonAction2(sender: UIButton) {
        
        var newController = UIViewController (nibName: "NewClass", bundle: nil)
        self.presentViewController(newController, animated: true,
            completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
