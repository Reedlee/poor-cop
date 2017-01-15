//
//  ViewController.swift
//  turajol-ios
//
//  Created by Samatbek Osmonov on 12/29/16.
//  Copyright © 2016 Samatbek Osmonov. All rights reserved.
//

import UIKit
import GoogleMaps

class MapVC: UIViewController, CLLocationManagerDelegate, MapPointsController {

    
    @IBOutlet weak var myMap: GMSMapView!
    
    private var locationManager = CLLocationManager()
   
    
    private var userLocation: CLLocationCoordinate2D?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MapPointsHandler.Instance.delegate = self
        MapPointsHandler.Instance.observePoints()
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
            
            let camera = GMSCameraPosition.camera(withLatitude: userLocation!.latitude, longitude: userLocation!.longitude, zoom: 16.0)
            myMap.camera = camera
            
            myMap.isMyLocationEnabled = true
            myMap.settings.myLocationButton = true
            
            

        }
    }

    @IBAction func markOnMapByLocationBtn(_ sender: Any) {
        if userLocation != nil {
            MapPointsHandler.Instance.markPoint(latitude: Double(userLocation!.latitude), longitude: Double(userLocation!.longitude))
        }
    }
    
    func showNewPointOnMap(latitude: Double, longitude: Double) {
        let position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let marker = GMSMarker(position: position)
        marker.title = "Осторожно ГАИ!"
        marker.map = self.myMap
    }
}

