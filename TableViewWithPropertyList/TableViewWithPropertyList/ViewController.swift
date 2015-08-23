//
//  ViewController.swift
//  TableViewWithPropertyList
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

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var cells : NSDictionary? // Global Variable
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = NSBundle.mainBundle().bundlePath
        let plistName:NSString = "Property List.plist"
        let finalPath:NSString = path.stringByAppendingPathComponent(plistName as String)
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



