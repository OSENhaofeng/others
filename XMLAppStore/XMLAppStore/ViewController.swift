//
//  ViewController.swift
//  XMLAppStore
//
//  Created by Carlos Butron on 07/12/14.
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
import Foundation

class ViewController: UIViewController, NSURLConnectionDelegate, NSXMLParserDelegate, UITableViewDataSource, UITableViewDelegate, ImagesOperationDelegate {
    
    @IBOutlet weak var tabla: UITableView!
    var listData: NSMutableData!
    var currentString: NSMutableString!
    var shouldParse:Bool!
    var apps:NSMutableArray!
    var currentApp:AppInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var queue = NSOperationQueue()
        let urlRequest = NSURLRequest(URL: NSURL(string:"http://phobos.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/toppaidapplications/limit=75/xml")!)
        
        NSURLConnection(request: urlRequest, delegate: self)
        currentString = NSMutableString(string: "")
        apps = NSMutableArray()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func connection(connection: NSURLConnection!, didReceiveResponse response: NSURLResponse!){
        listData = NSMutableData()
        print("Did receive Response")
    }
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!){
        listData.appendData(data)
        print("Did Receive Data")
    }
    func connectionDidFinishLoading(connection: NSURLConnection!){
        print("Did finish loading")
        let parser = NSXMLParser(data: listData)
        parser.delegate = self
        parser.parse()
        tabla.reloadData()
        let queue = NSOperationQueue()
        for it in apps{
            let imagesOperation = ImagesOperation()
            imagesOperation.app = it as! AppInfo
            imagesOperation.delegate = self
            queue.addOperation(imagesOperation)
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]){
        
        let elementsToParse = NSArray(objects: "id","im:name","im:image")
        
        if(elementName == "entry"){
            self.currentApp = AppInfo()
        }
        shouldParse = elementsToParse.containsObject(elementName)
    }
    
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?){
        if(self.currentApp != nil){
            //if(shouldParse || elementName == "entry"){
            let trimmedString = currentString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            currentString.setString("")
            if(elementName == "id"){
                self.currentApp.urlApp = trimmedString
                print("URL APP: \(trimmedString)")
            }
            else if(elementName == "im:name"){
                self.currentApp.name = trimmedString
                print("NAME: \(trimmedString)")
            }
            else if(elementName == "im:image"){
                self.currentApp.urlImage = trimmedString
                print("URL IMAGE: \(trimmedString)")
            }
            else if(elementName == "entry"){
                self.currentApp.index = apps.count
                apps.addObject(currentApp)
                currentApp = nil
            }
            // }
        }
    }
    
    
    func parser(parser: NSXMLParser, foundCharacters string: String)
    {
        if((shouldParse) != nil){
            currentString.appendString(string)
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apps.count
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell = tabla.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        var label: UILabel = cell.viewWithTag(101) as! UILabel
        var app = apps.objectAtIndex(indexPath.row) as! AppInfo
        label.text = app.name
        var imageView = cell.viewWithTag(100) as! UIImageView
        imageView.image = app.image
        
        return cell
    }
    
    func imageOperation(imagesOperation:ImagesOperation, app:AppInfo){
        var visibleCells = tabla.visibleCells
        var firstIndex = tabla.indexPathForCell(visibleCells[0] )?.row
        var lastIndex = tabla.indexPathForCell(visibleCells.last as! UITableViewCell)?.row
        if(app.index >= firstIndex && app.index <= lastIndex){
            var cell = tabla.cellForRowAtIndexPath(NSIndexPath(forRow: app.index, inSection: 0))
            var imageView = cell?.viewWithTag(100) as! UIImageView
            imageView.image = app.image
        }
    }
    
    
}


