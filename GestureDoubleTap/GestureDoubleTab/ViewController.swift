//
//  ViewController.swift
//  GestureDoubleTab
//
//  Created by Carlos Butron on 01/12/14.
//  Copyright (c) 2015 Carlos Butron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func handleTap(sender : UIGestureRecognizer) {
        if (sender.view?.contentMode == UIViewContentMode.ScaleAspectFit){
            sender.view?.contentMode = UIViewContentMode.Center
        }
        else{
            sender.view?.contentMode = UIViewContentMode.ScaleAspectFit
        } }
    override func viewDidLoad() {
        let tapGesture = UITapGestureRecognizer(target: self, action:
            #selector(ViewController.handleTap(_:)))
        tapGesture.numberOfTapsRequired = 2;
        image.addGestureRecognizer(tapGesture)
    }

}
