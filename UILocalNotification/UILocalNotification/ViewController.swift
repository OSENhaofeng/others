//
//  ViewController.swift
//  UILocalNotification
//
//  Created by Carlos Butron on 08/12/14.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Note from https://developer.apple.com/library/ios/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/Chapters/IPhoneOSClientImp.html:
        // "If your app is already in the foreground, iOS does not show the notification."
        let notification = UILocalNotification()
        notification.fireDate = NSDate().dateByAddingTimeInterval(10)
        notification.alertBody = "Alert"
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
