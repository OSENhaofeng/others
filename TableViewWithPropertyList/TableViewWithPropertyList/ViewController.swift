//
//  ViewController.swift
//  TableViewWithPropertyList
//
//  Created by Carlos Butron on 02/12/14.
//  Copyright (c) 2014 Carlos Butron.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var cells : NSDictionary? // Global Variable
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = NSBundle.mainBundle().bundlePath
        let plistName:NSString = "Property List.plist"
        let finalPath:NSString = (path as NSString).stringByAppendingPathComponent(plistName as String)
        cells = NSDictionary(contentsOfFile:finalPath as String)
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        
        let cell:CustomCell = tableView.dequeueReusableCellWithIdentifier("CustomCell") as! CustomCell
        
        let myCell: AnyObject = cells!.objectForKey("cell\(indexPath.row)") as! NSDictionary
        
        
        cell.myTitle?.text = myCell.objectForKey("title") as? String
        cell.mySubtitle?.text = myCell.objectForKey("subtitle") as? String
        cell.myImage?.image = UIImage(named: myCell.objectForKey("image") as! String)
        
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section:Int) -> String?  {
        
        return "TuxMania"
    }
    
    func tableView(tableView: UITableView, titleForFooterInSection section:Int) -> String? {
        
        return "Get all the Tux"
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}



