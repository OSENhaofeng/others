//
//  ViewController.swift
//  NSURLSession
//
//  Created by Carlos Butron on 02/12/14.
//  Copyright (c) 2014 Carlos Butron.
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

class ViewController: UIViewController {
    
    
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var temperatureCelsius: UITextField!
    @IBOutlet weak var temperatureCelsiusMax: UITextField!
    @IBOutlet weak var temperatureCelsiusMin: UITextField!
    @IBOutlet weak var temperatureKelvin: UITextField!
    @IBOutlet weak var temperatureKelvinMax: UITextField!
    @IBOutlet weak var temperatureKelvinMin: UITextField!
    @IBOutlet weak var humidity: UITextField!
    @IBOutlet weak var wind: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var sessionConfig: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        sessionConfig.allowsCellularAccess = false
        //only accept JSON answer
        sessionConfig.HTTPAdditionalHeaders = ["Accept":"application/json"]
        //timeouts and connections allowed
        sessionConfig.timeoutIntervalForRequest = 30.0
        sessionConfig.timeoutIntervalForResource = 60.0
        sessionConfig.HTTPMaximumConnectionsPerHost = 1
        //create session, assign configuration
        var session = NSURLSession(configuration: sessionConfig)
        session.dataTaskWithURL(NSURL(string: "http://api.openweathermap.org/data/2.5/weather?q=Madrid,es")!, completionHandler: {(data, response, error) in
            var dic:NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions(0), error: nil) as? NSDictionary ?? [String:String]()
            
            
            if dic.count == 0 {
                return
            }
            
            println(dic)
            
            var city: NSString = (dic["name"] as! NSString)
            var kelvin: AnyObject! = (dic["main"] as! NSDictionary) ["temp"]
            var kelvin_min: AnyObject! = (dic["main"] as! NSDictionary) ["temp_min"]
            var kelvin_max: AnyObject! = (dic["main"] as! NSDictionary) ["temp_max"]
            var celsius = kelvin as! Float - 274.15 as Float
            var celsius_min = kelvin_min as! Float - 274.15 as Float
            var celsius_max = kelvin_max as! Float - 274.15 as Float
            var humidity: AnyObject! = (dic ["main"] as! NSDictionary) ["humidity"]
            var wind: AnyObject! = (dic ["wind"] as! NSDictionary) ["speed"]
            
            
            //original thread
            dispatch_async(dispatch_get_main_queue(), { () in
                self.city.text = "\(city)"
                self.temperatureCelsius.text = "\(celsius)"
                self.temperatureCelsiusMax.text = "\(celsius_max)"
                self.temperatureCelsiusMin.text = "\(celsius_min)"
                self.temperatureKelvin.text = "\(kelvin)"
                self.temperatureKelvinMax.text = "\(kelvin_max)"
                self.temperatureKelvinMin.text = "\(kelvin_min)"
                self.humidity.text = "\(humidity)"
                self.wind.text = "\(wind)"
            })
            
        }).resume()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


