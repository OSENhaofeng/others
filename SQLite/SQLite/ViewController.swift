//
//  ViewController.swift
//  SQLite
//
//  Created by Carlos Butron on 06/12/14.
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

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    
    var statement = COpaquePointer()
    var data: NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loadTabla()
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loadTabla(){
        
        var db_path = NSBundle.mainBundle().pathForResource("filmoteca", ofType: "sqlite")
        println(NSBundle.mainBundle())
        var db = COpaquePointer()
        var status = sqlite3_open(db_path!, &db)
        if(status == SQLITE_OK){
            //bbdd open
        }
        else{
            //bbdd error
        }
        
        var query_stmt = "SELECT * FROM pelicula"
        
        if(sqlite3_prepare_v2(db, query_stmt, -1, &statement, nil) == SQLITE_OK){
            data.removeAllObjects()
            while(sqlite3_step(statement) == SQLITE_ROW){
                var Dictionary = NSMutableDictionary()
                
                let director = sqlite3_column_text(statement, 1)
                let buf_director = String.fromCString(UnsafePointer<CChar>(director))
                let imagen = sqlite3_column_text(statement, 2)
                let buf_imagen = String.fromCString(UnsafePointer<CChar>(imagen))
                let titulo = sqlite3_column_text(statement, 3)
                let buf_titulo = String.fromCString(UnsafePointer<CChar>(titulo))
                let year = sqlite3_column_text(statement, 4)
                let buf_year = String.fromCString(UnsafePointer<CChar>(year))
                
                Dictionary.setObject(buf_director!, forKey:"director")
                Dictionary.setObject(buf_imagen!, forKey: "imagen")
                Dictionary.setObject(buf_titulo!, forKey: "titulo")
                Dictionary.setObject(buf_year!, forKey: "year")
                
                data.addObject(Dictionary)
                //process data
                
            }
            sqlite3_finalize(statement)
        }
        else{
            println("ERROR")
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: MyTableViewCell = tableView.dequeueReusableCellWithIdentifier("MyTableViewCell") as! MyTableViewCell
        
        var aux: AnyObject = data[indexPath.row]
        var table_director = aux["director"]
        cell.director.text = table_director as? String
        var aux1: AnyObject = data[indexPath.row]
        var table_image = aux["imagen"]
        cell.myImage.image = UIImage(named:table_image as! String)
        var aux3: AnyObject = data[indexPath.row]
        var table_title = aux["titulo"]
        cell.title.text = table_title as? String
        
        var aux4: AnyObject = data[indexPath.row]
        var table_year = aux3["year"]
        cell.year.text = table_year as? String
        
        
        
        return cell
        
    }
    
    
    
    
    
    
}



