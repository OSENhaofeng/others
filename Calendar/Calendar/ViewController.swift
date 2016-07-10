//
//  ViewController.swift
//  Calendar
//
//  Created by Carlos Butron on 07/12/14.
//  Copyright (c) 2015 Carlos Butron. All rights reserved.
//

import UIKit
import EventKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var eventStore : EKEventStore!
    var calendar: EKCalendar!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var eventCalendario: UITextField!
    @IBOutlet weak var titleEvent: UITextField!
    
    @IBAction func saveCalendar(sender: UIButton) {
        let calendar = EKCalendar(forEntityType: EKEntityType.Event, eventStore: eventStore)
        eventStore.requestAccessToEntityType(EKEntityType.Event, completion: {(granted,error) in
            if(granted == false){
                print("Access Denied")
            } else{
                var auxiliar = self.eventStore.sources 
                calendar.source = auxiliar[0]
                calendar.title = self.textField.text!
                print(calendar.title)
                
                try! self.eventStore.saveCalendar(calendar, commit: true)
            }
        })
    }
    
    @IBAction func saveEvent(sender: UIButton) {
        eventStore.requestAccessToEntityType(EKEntityType.Event, completion: {(granted,error) in
            if(granted == false){
                print("Access Denied")
            }
            else{
                let arrayCalendars = self.eventStore.calendarsForEntityType(EKEntityType.Event)
                var theCalendar: EKCalendar!
                for calendario in arrayCalendars{
                    if(calendario.title == self.eventCalendario.text){
                        theCalendar = calendario 
                        print(theCalendar.title)
                    }
                }
                if(theCalendar != nil){
                    let event = EKEvent(eventStore: self.eventStore)
                    event.title = self.titleEvent.text!
                    event.startDate = self.datePicker.date
                    event.endDate = self.datePicker.date.dateByAddingTimeInterval(3600)
                    event.calendar = theCalendar
                    do {
                        try! self.eventStore.saveEvent(event, span: .ThisEvent)
                        let alert = UIAlertController(title: "Calendar", message: "Event created \(event.title) in \(theCalendar.title)", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "Accept", style: UIAlertActionStyle.Default, handler: nil))
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.presentViewController(alert, animated: true, completion: nil)
                        })
                    }
                }
                else{
                    print("No calendar with that name")
                }
            }
        })
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventStore = EKEventStore()
        
        let tapGestureRecognizer : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyBoard))
        
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func dismissKeyBoard() {
        self.textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }
    
    //called when users tap out of textfield
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

}
