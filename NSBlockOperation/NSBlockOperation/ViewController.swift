//
//  ViewController.swift
//  NSBlockOperation
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

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        
        
        var queue = NSOperationQueue()
        
        let operation1 : NSBlockOperation = NSBlockOperation (
            block: {
                self.getWebs()
                
                let operation2 : NSBlockOperation = NSBlockOperation(block: {
                    self.loadWebs()
                })
                queue.addOperation(operation2)
        })
        queue.addOperation(operation1)
        
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loadWebs(){
        let urls : NSMutableArray = NSMutableArray (objects:NSURL(string:"http://www.google.es")!, NSURL(string: "http://www.apple.com")!,NSURL(string: "http://carlosbutron.es")!, NSURL(string: "http://www.bing.com")!,NSURL(string: "http://www.yahoo.com")!)
        urls.addObjectsFromArray(googlewebs as [AnyObject])
        for iterator:AnyObject in urls{
            NSData(contentsOfURL:iterator as! NSURL)
            println("Downloaded \(iterator)")
        }
    }
    
    var googlewebs:NSArray = []
    
    func getWebs(){
        let languages:NSArray = ["com","ad","ae","com.af","com.ag","com.ai","am","co.ao","com.ar","as","at"]
        var languageWebs = NSMutableArray()
        for(var i=0;i < languages.count; i++){
            var webString: NSString = "http://www.google.\(languages[i])"
            languageWebs.addObject(NSURL(fileURLWithPath: webString as String)!)
        }
        googlewebs = languageWebs
    }
    
    
    
    
    
}




