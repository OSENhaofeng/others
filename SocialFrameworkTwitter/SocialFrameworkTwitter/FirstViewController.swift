//
//  FirstViewController.swift
//
//  Created by Carlos Butron on 11/11/14.
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
import Accounts
import QuartzCore
import Social
import CoreGraphics
import Foundation

class FirstViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var imageViewPhoto: UIImageView!
    @IBOutlet weak var labelUserName: UITextField!
    @IBOutlet weak var labelFollowers: UILabel!
    @IBOutlet weak var labelFollowing: UILabel!
    @IBOutlet weak var textViewDescription: UITextView!
    
    @IBAction func update(sender: UIButton) {
        if(labelUserName.text != ""){
            checkUser() //method implemented after
        }
            else{
            print("Introduce a name!")
        }
        
    }
    
    @IBAction func sendTweet(sender: UIButton) {
        let twitterController = SLComposeViewController(forServiceType:SLServiceTypeTwitter)
        let imageToTweet = UIImage(named:"image1.png")
        twitterController.setInitialText("Test from Xcode")
        twitterController.addImage(imageToTweet)
        let completionHandler:SLComposeViewControllerCompletionHandler = {(result) in
        twitterController.dismissViewControllerAnimated(true, completion: nil)
            switch(result) {
            case SLComposeViewControllerResult.Cancelled:
            print("Canceled")
            case SLComposeViewControllerResult.Done:
            print("User tweeted")
            
            } }
            twitterController.completionHandler = completionHandler
            self.presentViewController(twitterController, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelUserName.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }
    
    
    func checkUser(){
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        accountStore.requestAccessToAccountsWithType(accountType, options: nil, completion: {(granted, error) in
                if(granted == true) {
                var accounts = accountStore.accountsWithAccountType(accountType)
                if(accounts.count>0){
                let twitterAccount = accounts[0] as! ACAccount
                let twitterInfoRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: NSURL(string: "https://api.twitter.com/1.1/users/show.json"), parameters: NSDictionary(object: self.labelUserName.text!, forKey: "screen_name") as [NSObject : AnyObject])
                twitterInfoRequest.account = twitterAccount
                twitterInfoRequest.performRequestWithHandler({(responseData,urlResponse,error) in
                dispatch_async(dispatch_get_main_queue(), {()
                in
                //check access
                if(urlResponse.statusCode == 429){
                print("Rate limit reached")
                return
                }
                //check error
                if((error) != nil){
                print("Error \(error.localizedDescription)")
                }
                if(responseData != nil){
                //if dta received TO DO
                
                let TWData = (try! NSJSONSerialization.JSONObjectWithData(responseData, options: NSJSONReadingOptions.MutableLeaves)) as! NSDictionary
                //getting data
                let followers = TWData.objectForKey("followers_count")!.integerValue
                let following = TWData.objectForKey("friends_count")!.integerValue!
                let description = TWData.objectForKey("description") as! NSString
                self.labelFollowers.text = "\(followers)"
                self.labelFollowing.text = "\(following)"
                self.textViewDescription.text = description as String
                
                var profileImageStringURL = TWData.objectForKey("profile_image_url_https") as! NSString
                profileImageStringURL = profileImageStringURL.stringByReplacingOccurrencesOfString("_normal", withString: "")
                let url = NSURL(string: profileImageStringURL as String)
                let data = NSData(contentsOfURL: url!)
                self.imageViewPhoto.image = UIImage(data: data!)
                
                } })
                }) }
    } else {
    print("No access granted")
    }
    }) }


}

