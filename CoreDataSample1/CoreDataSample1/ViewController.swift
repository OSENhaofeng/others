//
//  ViewController.swift
//  CoreDataSample1
//
//  Created by Carlos Butron on 02/12/14.
//  Copyright (c) 2014 Carlos Butron.
//

import UIKit
import CoreData
        
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var results : NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context : NSManagedObjectContext = appDel.managedObjectContext
        
        // INSERT
        let celda = NSEntityDescription.insertNewObjectForEntityForName("Cell", inManagedObjectContext:  context) 
        celda.setValue("Yoda Tux", forKey: "title")
        celda.setValue("Science Fiction", forKey: "subtitle")
        celda.setValue("yodaTux.png", forKey: "image")
        
        do { 
           try context.save()
        }
        catch {
           print("Error!")
        }

        let request = NSFetchRequest (entityName: "Cell")
        request.returnsObjectsAsFaults = false
        results = try? context.executeFetchRequest(request)
            
        if (results!.count>0){
            for res in results! {
            print(res)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
                        
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: nil)
        let aux = results![indexPath.row] as! NSManagedObject
                        
        cell.textLabel!.text = aux.valueForKey("title") as? String
        cell.detailTextLabel?.text = aux.valueForKey("subtitle") as? String
        cell.imageView!.image = UIImage(named: aux.valueForKey("image") as! String)
                        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results!.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int)-> String?  {
        return "TuxMania"
    }
    
}
