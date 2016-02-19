//
//  ViewController.swift
//  NSBlockOperation
//
//  Created by Carlos Butron on 02/12/14.
//  Copyright (c) 2014 Carlos Butron.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        
        
        let queue = NSOperationQueue()
        
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
           /// NSData(contentsOfURL:iterator as! NSURL)
            print("Downloaded \(iterator)")
        }
    }
    
    var googlewebs:NSArray = []
    
    func getWebs(){
        let languages:NSArray = ["com","ad","ae","com.af","com.ag","com.ai","am","co.ao","com.ar","as","at"]
        let languageWebs = NSMutableArray()
        for(var i=0;i < languages.count; i++){
            let webString: NSString = "http://www.google.\(languages[i])"
            languageWebs.addObject(NSURL(fileURLWithPath: webString as String))
        }
        googlewebs = languageWebs
    }
    
    
    
    
    
}




