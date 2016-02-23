//
//  ViewController.swift
//  SegueWithpresentViewController
//
//  Created by Carlos Butron on 07/12/14.
//  Copyright (c) 2014 Carlos Butron.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func buttonAction(sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let viewController:UIViewController = storyboard.instantiateViewControllerWithIdentifier("NewViewController") 
        self.presentViewController(viewController, animated: true,
            completion: nil)
    }
    
    
    @IBAction func buttonAction2(sender: UIButton) {
        
        let newController = UIViewController (nibName: "NewClass", bundle: nil)
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
