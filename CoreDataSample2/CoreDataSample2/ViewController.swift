//
//  ViewController.swift
//  CoreDataSample2
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
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var results: NSArray?
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var surname: UITextField!
    @IBOutlet weak var table: UITableView!
    @IBAction func save(sender: UIButton) {
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext
        let cell = NSEntityDescription.insertNewObjectForEntityForName("Form", inManagedObjectContext:  context) 
        cell.setValue(name.text, forKey: "name")
        cell.setValue(surname.text, forKey: "surname")
        
        // Save the context.
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            //print("Unresolved error \(error), \(error.userInfo)")
        }
        
        
        
        self.loadTable()
        self.table.reloadData()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadTable() //start load
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : UITableViewCell = UITableViewCell(style:UITableViewCellStyle.Subtitle, reuseIdentifier: nil)
        let aux = results![indexPath.row] as! NSManagedObject
        cell.textLabel!.text = aux.valueForKey("name") as? String
        cell.detailTextLabel!.text = aux.valueForKey("surname") as? String
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results!.count
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?  {
        return "Contacts"
    }
    
    func loadTable(){
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext
        let request = NSFetchRequest(entityName: "Form")
        request.returnsObjectsAsFaults = false
        results = try? context.executeFetchRequest(request)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}



