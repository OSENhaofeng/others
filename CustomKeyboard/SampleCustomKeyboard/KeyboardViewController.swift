//
//  KeyboardViewController.swift
//  SampleCustomKeyboard
//
//  Created by 浅井 岳大 on 2016/03/07.
//  Copyright © 2016年 浅井 岳大. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!

    override func updateViewConstraints() {
        super.updateViewConstraints()
    
        // Add custom view sizing constraints here
    }
    
    
    func centerButton(_: AnyObject) {
        let text = "🐶"
        let proxy = self.textDocumentProxy as UIKeyInput
        proxy.insertText(text)
    }
    func pushButton(_: AnyObject) {
        let laugh = ":-))))))))"
        let proxy = self.textDocumentProxy as UIKeyInput
        proxy.insertText(laugh)
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        let viewXib = UINib(nibName: "CustomKeyboard", bundle: nil)
        self.view = viewXib.instantiateWithOwner(self, options: nil)[0] as! UIView;
        for v in self.view.subviews {
            if v.isKindOfClass(UIButton) {
                let w = v as! UIButton
                if w.currentTitle == "Center" {
                    w.addTarget(self, action: "centerButton:", forControlEvents: .TouchDown)
                } else {
                    w.addTarget(self, action: "pushButton:", forControlEvents: .TouchDown)
                }
            }
        }
        NSLog("NSLog can't be seen in xcode console. See README")
        
    
        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton(type: .System)
    
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard?", comment: "Title for 'Next Keyboard' button"), forState: .Normal)
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
    
        self.nextKeyboardButton.addTarget(self, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(self.nextKeyboardButton)
    
        let nextKeyboardButtonLeftSideConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: 0.0)
        let nextKeyboardButtonBottomConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        self.view.addConstraints([nextKeyboardButtonLeftSideConstraint, nextKeyboardButtonBottomConstraint])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }

    override func textWillChange(textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }

    override func textDidChange(textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
    
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.Dark {
            textColor = UIColor.whiteColor()
        } else {
            textColor = UIColor.blackColor()
        }
        self.nextKeyboardButton.setTitleColor(textColor, forState: .Normal)
    }

}
