//
//  RootViewController.swift
//  XML
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

class RootViewController: UITableViewController, NSURLConnectionDelegate, NSXMLParserDelegate {
    
    var xmlData:NSMutableData? = nil
    
    var songs:NSMutableArray = []
    var song:Song = Song(title: "")
    
    var currentStringValue: NSMutableString? = NSMutableString() //Variable Global

    override func viewDidLoad() {
        super.viewDidLoad()


            println("First Ejecution")
            var url = NSURL(string: "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/topsongs/limit=10/xml")
            var request = NSURLRequest(URL: url!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 30)
            self.xmlData = NSMutableData()
            NSURLConnection(request: request, delegate: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("AAAAAA \(songs.count)")
        return songs.count

    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("celda") as! UITableViewCell
        var elem = songs[indexPath.row] as! Song
        println("AAAAAA \(elem.myTitle)")
        cell.textLabel!.text = (elem.myTitle) as? String

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func connection(connection: NSURLConnection, didFailWithError error: NSError){
        println("URL access error")
    self.xmlData = nil
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!){
        self.xmlData!.appendData(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!){
        var xmlCheck = NSString(data: self.xmlData!, encoding: NSUTF8StringEncoding)
        //println("XML recived: \(xmlCheck)")
        var parser:NSXMLParser =  NSXMLParser(data: self.xmlData!)
        parser.delegate = self
        parser.shouldResolveExternalEntities = true
        parser.parse()
            for(var i=0; i<songs.count;i++){
                var elem = songs[i] as! Song
                println(elem.myTitle)
            }
        self.tableView.reloadData()
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]){
    
        if(elementName == "feed") {
            //init array
            songs = NSMutableArray()
            return
        }
    
        if(elementName == "entry") {
            //Find new song. Create object of song class.
            song = Song(title: "")
            return
        }
    
        if(elementName == "title") {
            currentStringValue = NSMutableString(capacity: 50)
        }
    }
    
    
    func parser(parser: NSXMLParser, foundCharacters string: String?) {
        if(currentStringValue != nil) {
            //NSMutableString where we save characters of actual item
            currentStringValue = NSMutableString(capacity: 50)
        }
        currentStringValue?.appendString(string!)
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?){
            if(elementName == "entry"){
                //add song to array
                songs.addObject(song)
            }
        
            if(elementName == "title"){
                //if we find a title save it in nsstring characters
                song.myTitle = currentStringValue!
            }
    }
    
    

}
