//
//  TableListViewcontroller.swift
//  BasicAgenda
//
//  Created by Carlos Butron on 12/04/15.
//  Copyright (c) 2015 Carlos Butron. All rights reserved.
//

import UIKit

class TableListViewController: UITableViewController, NewContactDelegate {
    
    var contactArray = Array<Contact>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 1...50 {
            let contact = Contact()
            
            contact.name = "Name\(i)"
            contact.surname = "Surname\(i)"
            contact.phone = "Phone\(i)"
            contact.email = "Email\(i)"
            
            contactArray.append(contact)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactArray.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) 
        
        let contact = contactArray[indexPath.row]
        cell.textLabel!.text = contact.name + " " + contact.surname
        cell.tag = indexPath.row
        print("Cell number: \(indexPath.row)")
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
            let detailViewController = segue.destinationViewController as! DetailViewController
            let cell = sender as! UITableViewCell
            detailViewController.contact = contactArray[cell.tag]
        } else if segue.identifier == "goToNewContactFromListado" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let newContactViewController = navigationController.viewControllers[0] as! NewContactViewController
            newContactViewController.delegate = self
        }
    }
    
    // MARK: - Delegate
    
    func newContact(contact: Contact) {
        contactArray.append(contact)
        tableView.reloadData()
    }
    
}
