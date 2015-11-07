//
//  ViewController.swift
//  NSFileManager
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

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var files: NSMutableArray = []
    var fileManager:NSFileManager!
    var documentsPath: String!
    var filelist:NSArray!
    
    @IBOutlet weak var tabla: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        files = []
        fileManager = NSFileManager.defaultManager()
        documentsPath = (NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).first! as String)
        filelist = try! fileManager.contentsOfDirectoryAtPath(documentsPath)
        
        print("documentspath:  \(documentsPath)")
        print(files.count)
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        filelist = try! fileManager.contentsOfDirectoryAtPath(documentsPath)
        files = []
        for file in filelist {
            files.addObject(file)
            print("file:  \(file)")
        }
        tabla.reloadData()
        
    }
    
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return files.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier:NSString = "CollectionCell"
        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier(identifier as String, forIndexPath: indexPath) 
        
        
        cell.textLabel!.text = files.objectAtIndex(indexPath.row).description
        
        var isDir: ObjCBool = ObjCBool(false)
        if(fileManager.fileExistsAtPath((documentsPath as NSString).stringByAppendingPathComponent(files[indexPath.row] as! String), isDirectory: &isDir)){
            if(isDir){
                cell.imageView!.image = UIImage(named: "dir.png")
            } else{
                cell.imageView!.image = UIImage(named: "file.png")
            }
        }
        
        
        
        return cell
    }
    
    
    
    
    
    
}


