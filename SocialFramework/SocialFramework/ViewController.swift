//
//  ViewController.swift
//  SocialFramework
//
//  Created by Carlos Butron on 02/12/14.
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
import Social
import Accounts

class ViewController: UIViewController {
    
    @IBAction func facebook(sender: UIButton) {
        
        let url: NSURL = NSURL(string: "http://www.google.es")!
        
        let fbController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        fbController.setInitialText("")
        fbController.addURL(url)
        
        let completionHandler = {(result:SLComposeViewControllerResult) -> () in
            fbController.dismissViewControllerAnimated(true, completion:nil)
            switch(result){
            case SLComposeViewControllerResult.Cancelled:
                print("User canceled")
            case SLComposeViewControllerResult.Done:
                print("User posted")
            default:
                break
            }
        }
        
        fbController.completionHandler = completionHandler
        self.presentViewController(fbController, animated: true, completion:nil)
    }
    
    
    @IBAction func twitter(sender: UIButton) {
        
        let image: UIImage = UIImage(named: "image2.png")!
        
        let twitterController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        twitterController.setInitialText("")
        twitterController.addImage(image)
        
        let completionHandler = {(result:SLComposeViewControllerResult) -> () in
            twitterController.dismissViewControllerAnimated(true, completion: nil)
            switch(result){
            case SLComposeViewControllerResult.Cancelled:
                print("User canceled")
            case SLComposeViewControllerResult.Done:
                print("User tweeted")
            default:
                break
            }
        }
        
        twitterController.completionHandler = completionHandler
        self.presentViewController(twitterController, animated: true, completion: nil)
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

