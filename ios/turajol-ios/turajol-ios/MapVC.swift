//
//  ViewController.swift
//  turajol-ios
//
//  Created by Samatbek Osmonov on 12/29/16.
//  Copyright © 2016 Samatbek Osmonov. All rights reserved.
//

import UIKit
import GoogleMaps

class MapVC: UIViewController, CLLocationManagerDelegate {

    
    @IBOutlet weak var myMap: GMSMapView!
    
    private var locationManager = CLLocationManager()
    private var userLocation: CLLocationCoordinate2D?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeLocationManager()
        
    }
    
    func initializeLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locationManager.location?.coordinate {
            userLocation = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            
            print("Success is good!")
            let camera = GMSCameraPosition.camera(withLatitude: userLocation!.latitude, longitude: userLocation!.longitude, zoom: 16.0)
            myMap.camera = camera
            
            myMap.isMyLocationEnabled = true
            myMap.settings.myLocationButton = true
            
            locationManager.stopUpdatingLocation()

        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

