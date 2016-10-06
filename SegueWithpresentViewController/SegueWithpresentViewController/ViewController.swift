//
//  ViewController.swift
//  SegueWithpresentViewController
//
//  Created by Carlos Butron on 07/12/14.
//  Copyright (c) 2014 Carlos Butron.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func buttonAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController:UIViewController = storyboard.instantiateViewController(withIdentifier: "NewViewController") 
        self.present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func buttonAction2(_ sender: UIButton) {
        let newController = UIViewController (nibName: "NewClass", bundle: nil)
        self.present(newController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
