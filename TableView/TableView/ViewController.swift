//
//  ViewController.swift
//  TableView
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Number of rows
    func tableView(tableView: UITableView, numberOfRowsInSection section:
        Int) -> Int{
            return 4 }
    //DetailCells
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:
        NSIndexPath) -> UITableViewCell{
            var cell:UITableViewCell = UITableViewCell(style:
                UITableViewCellStyle.Subtitle, reuseIdentifier: nil)
            cell.textLabel!.text = "Cell text"
            cell.detailTextLabel?.text = "Cell Subtitle"
            cell.imageView!.image = UIImage(named:"image1.png")
            return cell
    }
    //Title
    func tableView(tableView: UITableView, titleForHeaderInSection section:
        Int) -> String?{
            return "Head"
    }
    //Foot Subtitle
    func tableView(tableView: UITableView, titleForFooterInSection section:
        Int) -> String?{
            return "Foot"
    }
    
}

