//
//  ViewController.swift
//  Calendar
//
//  Created by Carlos Butron on 07/12/14.
//  Copyright (c) 2015 Carlos Butron. All rights reserved.
//
//  This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public
//  License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later
//  version.
//  This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
//  warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
//  You should have received a copy of the GNU General Public License along with this program. If not, see
//  http:/www.gnu.org/licenses/.
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
        var date = datePicker.date
        var name = textField.text
        var localSource: EKSource
        var calendar = EKCalendar(eventStore: eventStore)
        eventStore.requestAccessToEntityType(EKEntityTypeEvent, completion: {(granted,error) in
            if(granted == false){
                println("Access Denied")
            }
            else{
                var auxiliar = self.eventStore.sources() as [EKSource]
                calendar.source = auxiliar[0]
                calendar.title = self.textField.text
                println(calendar.title)
                var error:NSError?
                self.eventStore.saveCalendar(calendar, commit: true, error: &error)
            }
        })
    }
    
    @IBAction func saveEvent(sender: UIButton) {
        
        eventStore.requestAccessToEntityType(EKEntityTypeEvent, completion: {(granted,error) in
            if(granted == false){
                println("Access Denied")
            }
            else{
                var arrayCalendars = self.eventStore.calendarsForEntityType(EKEntityTypeEvent)
                var theCalendar: EKCalendar!
                for calendario in arrayCalendars{
                    if(calendario.title == self.eventCalendario.text){
                        theCalendar = calendario as EKCalendar
                        println(theCalendar.title)
                    }
                }
                if(theCalendar != nil){
                    var event = EKEvent(eventStore: self.eventStore)
                    event.title = self.titleEvent.text
                    event.startDate = self.datePicker.date
                    event.endDate = self.datePicker.date.dateByAddingTimeInterval(3600)
                    event.calendar = theCalendar
                    var error:NSError?
                    if(self.eventStore.saveEvent(event, span: EKSpanThisEvent, error: &error)){
                        var alert = UIAlertController(title: "Calendar", message: "Event created \(event.title) in \(theCalendar.title)", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "Accept", style: UIAlertActionStyle.Default, handler: nil))
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.presentViewController(alert, animated: true, completion: nil)
                        })
                    }
                }
                else{
                    println("No calendar with that name")
                }
            }
        })
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventStore = EKEventStore()
        
        let tapGestureRecognizer : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyBoard")
        
        self.view.addGestureRecognizer(tapGestureRecognizer)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyBoard() {
        self.textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }
    
    //called when users tap out of textfield
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    
}

