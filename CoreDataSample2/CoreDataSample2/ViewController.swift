//
//  ViewController.swift
//  CoreDataSample2
//
//  Created by Carlos Butron on 02/12/14.
//  Copyright (c) 2014 Carlos Butron.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var results: NSArray?
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var surname: UITextField!
    @IBOutlet weak var table: UITableView!
    @IBAction func save(_ sender: UIButton) {
        
        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext
        let cell = NSEntityDescription.insertNewObject(forEntityName: "Form", into:  context) 
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = UITableViewCell(style:UITableViewCellStyle.subtitle, reuseIdentifier: nil)
        let aux = results![(indexPath as NSIndexPath).row] as! NSManagedObject
        cell.textLabel!.text = aux.value(forKey: "name") as? String
        cell.detailTextLabel!.text = aux.value(forKey: "surname") as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results!.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?  {
        return "Contacts"
    }
    
    func loadTable(){
        let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext
        let request = NSFetchRequest(entityName: "Form")
        request.returnsObjectsAsFaults = false
        results = try? context.fetch(request)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
