//
//  ViewController.swift
//  CoreDataWithTableView
//
//  Created by Carlos Butron on 06/12/14.
//  Copyright (c) 2014 Carlos Butron.
//

import UIKit
import CoreData


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var results: NSArray! = NSArray()
    var appDel: AppDelegate!
    var context: NSManagedObjectContext!
    var request : NSFetchRequest!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        context = appDel.managedObjectContext
        
        //Code to add a movie
                let movie = NSEntityDescription.insertNewObjectForEntityForName("Movie", inManagedObjectContext:  context) 
                movie.setValue("El Hobbit: Un viaje inesperado", forKey: "title")
                movie.setValue("2013", forKey: "year")
                movie.setValue("Peter Jackson", forKey: "director")
                movie.setValue("hobbit.jpg", forKey: "image")
        
        do {try context.save()}
        catch {
            print("Error!")
        }

        
        
        loadTable()
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loadTable(){
        let request = NSFetchRequest(entityName: "Movie")
        request.returnsObjectsAsFaults = false
        results = try! context.executeFetchRequest(request)
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: MyTableViewCell = tableView.dequeueReusableCellWithIdentifier("MyTableViewCell") as! MyTableViewCell
        
        let aux = results[indexPath.row] as! NSManagedObject
        cell.title.text = aux.valueForKey("title") as? String
        cell.director.text = aux.valueForKey("director") as? String
        cell.year.text = aux.valueForKey("year") as? String
        cell.myImage.image = UIImage(named:aux.valueForKey("image") as! String)
        
        return cell
        
    }
    
    
    
    
    
    
}


