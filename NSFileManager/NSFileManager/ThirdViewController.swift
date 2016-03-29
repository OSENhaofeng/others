//
//  ThirdViewController.swift
//  NSFileManager
//
//  Created by Carlos Butron on 06/12/14.
//  Copyright (c) 2014 Carlos Butron.
//

import UIKit

class ThirdViewController: UIViewController {
    
    var fileManager = NSFileManager.defaultManager()
    var documentsPath = (NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).first! as String)

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var txtBox: UITextView!
    
    @IBAction func open(sender: UIButton) {
    
        if(fileManager.fileExistsAtPath((documentsPath as NSString).stringByAppendingPathComponent("\(name.text).txt"))){
            let contenido = NSString(data: fileManager.contentsAtPath((documentsPath as NSString).stringByAppendingPathComponent("\(name.text).txt"))!, encoding: NSUTF8StringEncoding)
            txtBox.text = contenido as! String
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
