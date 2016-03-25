//
//  ViewController.swift
//  MapKit iPad
//
//  Created by Carlos Butron on 02/12/14.
//  Copyright (c) 2014 Carlos Butron.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet weak var myMap: MKMapView!
    
    var set = NSMutableArray()
    
    @IBAction func createAnotation(sender: AnyObject) {
        
        let a = MyAnotation(c: myMap.centerCoordinate, t: "Center", st: "The map center")
        mapView(myMap, viewForAnnotation: a)
        myMap.addAnnotation(a)
        set.addObject(a)
    }
    
    @IBAction func deleteAnotation(sender: AnyObject) {
        //new for swift 2.0
        let annotationsToRemove = self.myMap.annotations
        self.myMap.removeAnnotations(annotationsToRemove)
    }
    
    @IBAction func coordinates(sender: AnyObject) {
 
        latitude.text = "\(myMap.centerCoordinate.latitude)"
        longitude.text = "\(myMap.centerCoordinate.longitude)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myMap.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation:
        MKAnnotation) -> MKAnnotationView?{
            let pinView:MKPinAnnotationView = MKPinAnnotationView(annotation:
                annotation, reuseIdentifier: "Custom")
            //purple color to anotation
            //pinView.pinColor = MKPinAnnotationColor.Purple
            pinView.image = UIImage(named:"mypin.png")
            return pinView
    }
    
}
