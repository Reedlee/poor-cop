//
//  ViewController.swift
//  turajol-ios
//
//  Created by Samatbek Osmonov on 12/29/16.
//  Copyright © 2016 Samatbek Osmonov. All rights reserved.
//

import UIKit
import GoogleMaps

class MapVC: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate, MapPointsController {

    
    @IBOutlet weak var myMap: GMSMapView!
    
    private var locationManager = CLLocationManager()
   
    
    private var userLocation: CLLocationCoordinate2D?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MapPointsHandler.Instance.delegate = self
        MapPointsHandler.Instance.observePoints()
        initializeLocationManager()
        myMap.delegate = self
        
        
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
            pointAlert(lat: userLocation!.latitude, long: userLocation!.longitude)
        }
    }

    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        pointAlert(lat: coordinate.latitude, long: coordinate.longitude)
    }
    
    func pointAlert(lat: Double, long: Double)
    {
        let alert = UIAlertController(title: "Вы уверены что хотите отметить эту точку?", message: "latidude: \(lat) \nlongitude: \(long)", preferredStyle: .alert)
        let accept = UIAlertAction(title: "Да", style: .default) { (alertAction: UIAlertAction) in
            MapPointsHandler.Instance.markPoint(latitude: lat, longitude: long)
        }
        let cancel = UIAlertAction(title: "Нет", style: .default, handler: nil)
        
        alert.addAction(cancel)
        alert.addAction(accept)
        
        present(alert, animated: true, completion: nil)
    }
    
    func showNewPointOnMap(latitude: Double, longitude: Double) {
        let position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let marker = GMSMarker(position: position)
        marker.title = "Осторожно ГАИ!"
        marker.map = self.myMap
    }
    

}

