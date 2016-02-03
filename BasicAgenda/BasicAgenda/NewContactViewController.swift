//
//  NewContactViewController.swift
//  BasicAgenda
//
//  Created by Carlos Butron on 12/04/15.
//  Copyright (c) 2015 Carlos Butron. All rights reserved.
//


import UIKit

protocol NewContactDelegate {
    func newContact(contact: Contact)
}

class NewContactViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    var delegate: NewContactDelegate?
    
    @IBAction func savePushButton(sender: AnyObject) {
        
        let contact = Contact()
        
        contact.name = nameTextField.text!
        contact.surname = surnameTextField.text!
        contact.phone = phoneTextField.text!
        contact.email = emailTextField.text!
        
        delegate?.newContact(contact)
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    @IBAction func cancelPushButton(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}

