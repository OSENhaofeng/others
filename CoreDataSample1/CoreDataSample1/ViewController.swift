//
//  ViewController.swift
//  CoreDataSample1
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
        
                do {try context.save()}
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
            
            // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
                    super.didReceiveMemoryWarning()
                    // Dispose of any resources that can be recreated.
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

