//
//  ViewController.swift
//  Location
//
//  Created by George Nance on 6/15/16.
//  Copyright © 2016 George Nance. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController,CLLocationManagerDelegate {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!

    @IBOutlet var mapView: MKMapView!
    
    @IBOutlet weak var postalLabel: UILabel!
    
    var locationManager : CLLocationManager!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()

        locationManager.startUpdatingLocation()
        print("wtf")
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(locations[0].coordinate,
                                                                  500 * 2.0, 500 * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.showsUserLocation = true
        let geoCoder = CLGeocoder()
        
        geoCoder.reverseGeocodeLocation(locations[0], completionHandler: {
            (placemarks,error) -> Void in
            
            if ((error) != nil){
                print("Reverse Geocode failed")
                return
            }
            
            if placemarks?.count > 0{
               self.updateText(placemarks![0])
            }
            
        })
        
        //geoCoder.reverseGeocodeLocation(locations[0], completionHandler: nil)
        
    }
    
    func updateText(placemark: CLPlacemark){
        
        cityLabel.text = placemark.locality
        stateLabel.text = placemark.administrativeArea
        countryLabel.text = placemark.country
        postalLabel.text = placemark.postalCode
        locationManager.stopUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

