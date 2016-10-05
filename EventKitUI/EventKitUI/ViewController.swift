//
//  ViewController.swift
//  EventKitUI
//
//  Created by Carlos Butron on 02/12/14.
//  Copyright (c) 2015 Carlos Butron. All rights reserved.
//

import UIKit
import EventKitUI

class ViewController: UIViewController, EKEventEditViewDelegate {
    
    var store = EKEventStore()
    
    @IBAction func calendar(_ sender: UIButton) {
        
        store.requestAccess(to: EKEntityType.event, completion: { (granted, error) -> Void in
            if (granted) {
                print("Access granted")
                
                let controller = EKEventEditViewController()
                controller.eventStore = self.store
                controller.editViewDelegate = self
                self.present(controller, animated: true, completion: nil)
            }else{
                print("Access denied")
            }
        })
    }
    
    @IBAction func deleteEvents(_ sender: UIButton) {
        //get calendar
        let calendar = NSCalendar.current
        //get start and end date
        var aDayBeforeComponents = DateComponents()
        aDayBeforeComponents.day = -1
        let aDayBefore : Date = (calendar as NSCalendar).date(byAdding: aDayBeforeComponents, to: Date(), options: Calendar(identifier: 0))!
        var yearAfterComponents = DateComponents()
        yearAfterComponents.year = 1
        let yearAfter : Date = (calendar as NSCalendar).date(byAdding: yearAfterComponents, to: Date(), options: Calendar(identifier: 0))!
        //create predicate
        let predicate : NSPredicate = self.store.predicateForEvents(withStart: aDayBefore, end: yearAfter, calendars: nil)
        //get related events
        let events : NSArray = self.store.events(matching: predicate)
        
        //loop all events in events and delete it
        for i in events{
            do {
                try self.store.remove(i as! EKEvent, span: .thisEvent, commit: true)
            } catch _ {
            }
            //println(i)
        }
    }
    
    @IBAction func setAlarm(_ sender: UIButton) {
        
        //get calendar
        let calendar = NSCalendar.current
        //get start and end date
        var aDayBeforeComponents = DateComponents()
        aDayBeforeComponents.day = -1
        let aDayBefore : Date = (calendar as NSCalendar).date(byAdding: aDayBeforeComponents, to: Date(), options: Calendar(identifier: 0))!
        var yearAfterComponents = DateComponents()
        yearAfterComponents.year = 1
        let yearAfter : Date = (calendar as NSCalendar).date(byAdding: yearAfterComponents, to: Date(), options: Calendar(identifier: 0))!
        //create predicate
        let predicate : NSPredicate = self.store.predicateForEvents(withStart: aDayBefore, end: yearAfter, calendars: nil)
        //get related events
        let events : NSArray = self.store.events(matching: predicate)
        
        //loop all events in events and add alarm to all
        for i in events{
            let eventWithAlarm = i as! EKEvent
            let alarm = EKAlarm(relativeOffset: -2.0)
            eventWithAlarm.addAlarm(alarm)
            do {
                try self.store.save(eventWithAlarm, span: .thisEvent)
            } catch _ {
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
