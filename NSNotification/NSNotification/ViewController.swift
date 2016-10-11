//
//  ViewController.swift
//  NSNotification
//
//  Created by Carlos Butron on 08/12/14.
//  Copyright (c) 2014 Carlos Butron.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillAppear(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillDisappear(_:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if(string == "\n"){
                textField.resignFirstResponder()
                return false
            } else{
                return true
            } }
    
    func keyboardWillAppear(_ notification: Notification) {
        print("Show Keyboard")
    }
    
    func keyboardWillDisappear(_ notification:Notification){
        print("Hide Keyboard")
    }

}
