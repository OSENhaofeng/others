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
    
    @IBAction func calendar(sender: UIButton) {
        
        
        store.requestAccessToEntityType(EKEntityType.Event, completion: { (granted, error) -> Void in
            if (granted) {
                print("Access granted")
                
                
                let controller = EKEventEditViewController()
                controller.eventStore = self.store
                controller.editViewDelegate = self
                self.presentViewController(controller, animated: true, completion: nil)
            }else{
                print("Access denied")
            }
        })
        
    }
    
    
    @IBAction func deleteEvents(sender: UIButton) {
        //get calendar
        let calendar = NSCalendar.currentCalendar()
        //get start and end date
        let aDayBeforeComponents = NSDateComponents()
        aDayBeforeComponents.day = -1
        let aDayBefore : NSDate = calendar.dateByAddingComponents(aDayBeforeComponents, toDate: NSDate(), options: NSCalendarOptions(rawValue: 0))!
        let yearAfterComponents = NSDateComponents()
        yearAfterComponents.year = 1
        let yearAfter : NSDate = calendar.dateByAddingComponents(yearAfterComponents, toDate: NSDate(), options: NSCalendarOptions(rawValue: 0))!
        //create predicate
        let predicate : NSPredicate = self.store.predicateForEventsWithStartDate(aDayBefore, endDate: yearAfter, calendars: nil)
        //get related events
        let events : NSArray = self.store.eventsMatchingPredicate(predicate)
        
        
        
        
        ////loop all events in events and delete it
        for i in events{
            do {
                try self.store.removeEvent(i as! EKEvent, span: .ThisEvent, commit: true)
            } catch _ {
            }
            //println(i)
        }
        
    }
    
    
    @IBAction func setAlarm(sender: UIButton) {
        
        //get calendar
        let calendar = NSCalendar.currentCalendar()
        //get start and end date
        let aDayBeforeComponents = NSDateComponents()
        aDayBeforeComponents.day = -1
        let aDayBefore : NSDate = calendar.dateByAddingComponents(aDayBeforeComponents, toDate: NSDate(), options: NSCalendarOptions(rawValue: 0))!
        let yearAfterComponents = NSDateComponents()
        yearAfterComponents.year = 1
        let yearAfter : NSDate = calendar.dateByAddingComponents(yearAfterComponents, toDate: NSDate(), options: NSCalendarOptions(rawValue: 0))!
        //create predicate
        let predicate : NSPredicate = self.store.predicateForEventsWithStartDate(aDayBefore, endDate: yearAfter, calendars: nil)
        //get related events
        let events : NSArray = self.store.eventsMatchingPredicate(predicate)
        
        
        //loop all events in events and add alarm to all
        for i in events{
            let eventWithAlarm = i as! EKEvent
            let alarm = EKAlarm(relativeOffset: -2.0)
            eventWithAlarm.addAlarm(alarm)
            do {
                try self.store.saveEvent(eventWithAlarm, span: .ThisEvent)
            } catch _ {
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    override func viewDidAppear(animated: Bool) {
    //
    //    }
    
    func eventEditViewController(controller: EKEventEditViewController, didCompleteWithAction action: EKEventEditViewAction) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}

