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
        let url = URL(string: stringURL as String)
        //building NSURLRequest
        let request = URLRequest(url: url!)
        //connection
        
        let connection: NSURLConnection? = NSURLConnection(request: request, delegate: self)
        
        if (connection != nil){
            print("Connecting...")
            dataJSON = NSMutableData()
        }
        else{
            print("Connection failed")
        }
        
//        let stringURL:NSString = "https://itunes.apple.com/es/rss/topfreeapplications/limit=10/json"
//        //building NSURL
//        let url = NSURL(string: stringURL as String)
//        
//        let request = NSMutableURLRequest(URL: url!)
//        let session = NSURLSession.sharedSession()
//        
//        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
//            print("Response: \(response)")})
//        
//        task.resume()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func connection(_ connection: NSURLConnection!, didFailWithError error: NSError!){
        print("Error: \(error)")
    }
    
    func connection(_ connection: NSURLConnection!, didReceiveResponse response: URLResponse!){
        print("Received response: \(response)")
        //restore data
        dataJSON.length = 0
    }
    
    func connection(_ connection: NSURLConnection!, didReceiveData data:Data!){
        self.dataJSON.append(data)
    }
    
    func connectionDidFinishLoading(_ connection: NSURLConnection!){
        
        do {
            let dic:NSDictionary! = try JSONSerialization.jsonObject(with: dataJSON as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
            
            //get from JSON
            let top1: AnyObject = ((dic["feed"] as! NSDictionary) ["entry"]! as! NSArray) [0]
            let imgJson: AnyObject = (top1["im:image"] as! NSArray) [2]
            let url = URL(string: imgJson.object(forKey: "label") as! String)
            let data = try? Data(contentsOf: url!)
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
