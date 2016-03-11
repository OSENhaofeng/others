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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
