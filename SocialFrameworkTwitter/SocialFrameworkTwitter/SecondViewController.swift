//
//  SecondViewController.swift
//
//  Created by Carlos Butron on 11/11/14.
//  Copyright (c) 2014 Carlos Butron.
//

import UIKit
import Accounts
import QuartzCore
import Social
import CoreGraphics
import Foundation

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var table: UITableView!
    
    var refreshControl:UIRefreshControl!
    var tweetsArray = NSArray()
    var imageDictionary:NSMutableDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshTimeLine:", forControlEvents: UIControlEvents.ValueChanged)
        self.refreshTimeLine()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func refreshTimeLine(){
            if(SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter)){
            let accountStore = ACAccountStore()
            let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
            accountStore.requestAccessToAccountsWithType(accountType, options: nil, completion: {(granted,error) in
            if(granted==true){
            let arrayOfAccounts = accountStore.accountsWithAccountType(accountType)
            let tempAccount = arrayOfAccounts.last as! ACAccount
            let tweetURL = NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")
            let tweetRequest = SLRequest(forServiceType:SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: tweetURL, parameters: nil)
            tweetRequest.account = tempAccount
            tweetRequest.performRequestWithHandler({(responseData,urlResponse,error) in
            if(error == nil){
                
                let responseJSON: NSArray?
                
                do {
                    
                    responseJSON = try NSJSONSerialization.JSONObjectWithData(responseData, options: NSJSONReadingOptions.AllowFragments) as? NSArray
                    
                    self.tweetsArray = responseJSON!
                    self.imageDictionary = NSMutableDictionary()
                    dispatch_async(dispatch_get_main_queue(),
                    {self.table.reloadData()})
                    
                } catch _ {
                    
                    print("JSON ERROR ")
                    
                }
//                /*get tweets*/
//                let jsonError:NSError?
//                let responseJSON = NSJSONSerialization.JSONObjectWithData(responseData, options: NSJSONReadingOptions.AllowFragments, error: &jsonError) as! NSArray
//                if(jsonError != nil) {
//                    print("JSON ERROR ")
//                }
//                    else{
//                    self.tweetsArray = responseJSON
//                    self.imageDictionary = NSMutableDictionary()
//                    dispatch_async(dispatch_get_main_queue(),
//                    {self.table.reloadData()})
//                }}
            } else{ /*access Error*/ }
            })
            } })
        }
            else { /*Error: you need Twitter account*/ }
            refreshControl.endRefreshing()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweetsArray.count;
    }
    

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("timelineCell") as! TimelineCell
        let currentTweet = self.tweetsArray.objectAtIndex(indexPath.row) as! NSDictionary
        let currentUser = currentTweet["user"] as! NSDictionary
        cell.userNameLabel!.text = currentUser["name"] as? String
        cell.tweetlabel!.text = currentTweet["text"] as! String
        let userName = cell.userNameLabel.text
        if((self.imageDictionary[userName!]) != nil){
        cell.userImageView.image = (self.imageDictionary[userName!] as! UIImage)
    } else{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
        let imageURL = NSURL(string: currentUser.objectForKey("profile_image_url") as! String)
        let imageData = NSData(contentsOfURL: imageURL!)
        self.imageDictionary.setObject(UIImage(data: imageData!)!, forKey: userName!)
        (dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
        cell.userImageView.image = (self.imageDictionary[cell.userNameLabel.text!] as! UIImage)
        })
        }) }

    return cell
    }

}

