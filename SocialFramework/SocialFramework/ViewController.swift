//
//  ViewController.swift
//  SocialFramework
//
//  Created by Carlos Butron on 02/12/14.
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
                print("User canceled", terminator: "")
            case SLComposeViewControllerResult.Done:
                print("User posted", terminator: "")

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
                print("User canceled", terminator: "")
            case SLComposeViewControllerResult.Done:
                print("User tweeted", terminator: "")

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

