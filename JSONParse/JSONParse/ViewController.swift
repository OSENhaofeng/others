//
//  ViewController.swift
//  JSONParse
//
//  Created by Carlos Butron on 02/12/14.
//  Copyright (c) 2014 Carlos Butron.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var tittle: UILabel!
    @IBOutlet weak var myDescription: UITextView!
    
    var dataJSON = NSMutableData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let stringURL:NSString = "https://itunes.apple.com/es/rss/topfreeapplications/limit=10/json"
        //building NSURL
        let url = NSURL(string: stringURL as String)
        //building NSURLRequest
        let request = NSURLRequest(URL: url!)
        //connection
        let connection: NSURLConnection? = NSURLConnection(request: request, delegate: self)
        
        if (connection != nil){
            print("Connecting...")
            dataJSON = NSMutableData()
        }
        else{
            print("Connection failed")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func connection(connection: NSURLConnection!, didFailWithError error: NSError!){
        print("Error: \(error)")
    }
    
    func connection(connection: NSURLConnection!, didReceiveResponse response: NSURLResponse!){
        print("Received response: \(response)")
        //restore data
        dataJSON.length = 0
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data:NSData!){
        self.dataJSON.appendData(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!){
        
        do {
            let dic:NSDictionary! = try NSJSONSerialization.JSONObjectWithData(dataJSON, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
            
            //get from JSON
            let top1: AnyObject = ((dic["feed"] as! NSDictionary) ["entry"]! as! NSArray) [0]
            let imgJson: AnyObject = (top1["im:image"] as! NSArray) [2]
            let url = NSURL(string: imgJson.objectForKey("label") as! String)
            let data = NSData(contentsOfURL: url!)
            let img = UIImage(data: data!)
            image.image = img
            //get tittle and description
            let tit = (top1["title"] as! NSDictionary) ["label"] as! NSString
            let desc = (top1["summary"] as! NSDictionary) ["label"] as! NSString
            tittle.text = tit as String
            myDescription.text = desc as String
        } catch {
            // failure
            print("Fetch failed: \((error as NSError).localizedDescription)")
        }
    }
    
}
