//
//  ViewController.swift
//  TableView
//
//  Created by Carlos Butron on 02/12/14.
//  Copyright (c) 2014 Carlos Butron.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Number of rows
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4 
    }
            
    //DetailCells
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:
        NSIndexPath) -> UITableViewCell{
            let cell:UITableViewCell = UITableViewCell(style:
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
