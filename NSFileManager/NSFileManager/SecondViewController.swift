//
//  SecondViewController.swift
//  NSFileManager
//
//  Created by Carlos Butron on 06/12/14.
//  Copyright (c) 2014 Carlos Butron.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var text: UITextView!
    @IBOutlet weak var nameDirectory: UITextField!

    @IBAction func createFile(sender: UIButton) {
        let content = text.text.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        if(fileManager.createFileAtPath(documentsPath.stringByAppendingPathComponent("\(name.text).txt"), contents: content, attributes: nil)){
            print("created")
        }
    }
    
    @IBAction func createDirectory(sender: UIButton) {
        let newDirectory:NSString = documentsPath.stringByAppendingPathComponent(nameDirectory.text!)
        let fileManager = NSFileManager.defaultManager()
        
        _ = try? fileManager.createDirectoryAtPath( newDirectory as String,
            withIntermediateDirectories: true,
            attributes: nil )
        
//        if(fileManager.createDirectoryAtPath(newDirectory as String, withIntermediateDirectories: true, attributes: nil)){
//            print("created")
//        }
    }
    
    var fileManager = NSFileManager.defaultManager()
    var documentsPath = (NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).first! as NSString)

    override func viewDidLoad() {
        super.viewDidLoad()
        name.delegate = self
        nameDirectory.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

}
