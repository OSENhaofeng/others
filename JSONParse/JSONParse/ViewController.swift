//
//  ViewController.swift
//  JSONParse
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
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            
            //A partir del JSON obtenemos la primera entrada
            let top1: AnyObject = ((dic["feed"] as! NSDictionary) ["entry"]! as! NSArray) [2]
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

