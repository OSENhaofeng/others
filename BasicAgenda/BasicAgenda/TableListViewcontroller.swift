//
//  TableListViewcontroller.swift
//  BasicAgenda
//
//  Created by Carlos Butron on 12/04/15.
//  Copyright (c) 2015 Carlos Butron. All rights reserved.
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


class TableListViewController: UITableViewController, NewContactDelegate {
    
    var contactArray = Array<Contact>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        for i in 1...50 {
            var contact = Contact()
            
            contact.name = "Name\(i)"
            contact.surname = "Surname\(i)"
            contact.phone = "Phone\(i)"
            contact.email = "Email\(i)"
            
            contactArray.append(contact)
        }
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
        return contactArray.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        let contact = contactArray[indexPath.row]
        cell.textLabel!.text = contact.name + " " + contact.surname
        cell.tag = indexPath.row
        println("Cell number: \(indexPath.row)")
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
    
    
    // MARK: - Navigation
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goToDetailFromListado" {
            var detailViewController = segue.destinationViewController as! DetailViewController
            var cell = sender as! UITableViewCell
            
            detailViewController.contact = contactArray[cell.tag]
        } else if segue.identifier == "goToNewContactFromListado" {
            var navigationController = segue.destinationViewController as! UINavigationController
            var newContactViewController = navigationController.viewControllers[0] as! NewContactViewController
            newContactViewController.delegate = self
            
        }
    }
    
    // MARK: - Delegate
    
    func newContact(contact: Contact) {
        contactArray.append(contact)
        tableView.reloadData()
        
    }
    
    
}
