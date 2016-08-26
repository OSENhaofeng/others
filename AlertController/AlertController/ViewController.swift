//
//  ViewController.swift
//  AlertController
//
//  Created by Carlos Butron on 01/11/15.
//  Copyright © 2015 Carlos Butron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func actionAlert(sender: AnyObject) {
        
        let alertController = UIAlertController(title: "My Title", message: "This is an alert", preferredStyle:UIAlertControllerStyle.Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { _ in
            print("you have pressed the Cancel button");
        }
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { _ in
            print("you have pressed OK button");
        }
        alertController.addAction(OKAction)
        
        self.presentViewController(alertController, animated: true, completion:{ () -> Void in
            //your code here
        })
        
    }

    @IBAction func actionSheet(sender: AnyObject) {
        
        let alertController = UIAlertController(title: "My Title", message: "This is an alert", preferredStyle:UIAlertControllerStyle.ActionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { _ in
            print("you have pressed the Cancel button");
        }
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { _ in
            print("you have pressed OK button");
        }
        alertController.addAction(OKAction)
        
        self.presentViewController(alertController, animated: true, completion:{ () -> Void in
            //your code here
        })
        
    }
    
    @IBAction func actionAlertWithForm(sender: AnyObject) {
        
        let alertController = UIAlertController(title: "My Title", message: "This is an alert", preferredStyle:UIAlertControllerStyle.Alert)
            
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { _ in
            print("you have pressed the Cancel button");
        }
        alertController.addAction(cancelAction)
            
        let OKAction = UIAlertAction(title: "OK", style: .Default) { _ in
            print("you have pressed OK button");
            
            let userName = alertController.textFields![0].text
            let password = alertController.textFields![1].text
            
            self.doSomething(userName, password: password)
        }
        alertController.addAction(OKAction)
        
        alertController.addTextFieldWithConfigurationHandler({(textField : UITextField!) in
            textField.placeholder = "User Name"
            textField.secureTextEntry = false
        })
        
        alertController.addTextFieldWithConfigurationHandler({(textField : UITextField!) in
            textField.placeholder = "Password"
            textField.secureTextEntry = true
        })
            
        self.presentViewController(alertController, animated: true, completion:{ () -> Void in
             //your code here
        })
    }
    
    func doSomething(userName: String?, password: String?) {
        print("username: \(userName ?? "")  password: \(password ?? "")")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
