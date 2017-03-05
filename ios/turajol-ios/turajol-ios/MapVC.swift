//
//  ViewController.swift
//  turajol-ios
//
//  Created by Samatbek Osmonov on 12/29/16.
//  Copyright © 2016 Samatbek Osmonov. All rights reserved.
//

import UIKit
import GoogleMaps

class MapVC: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {

    @IBOutlet weak var myMap: GMSMapView!
    private var locationManager = CLLocationManager()
    private var userLocation: CLLocationCoordinate2D?
    
    private var points = [Point]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ServerManager.Instance.getPoints({ (points) in
            self.points = points.values
            self.displayAllPoints()
            
        }) { (error) in
            print(error)
        }

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
            
            let camera = GMSCameraPosition.camera(withLatitude: userLocation!.latitude, longitude: userLocation!.longitude, zoom: 16)
            myMap.camera = camera
            
            myMap.isMyLocationEnabled = true
            myMap.settings.myLocationButton = true
            myMap.settings.zoomGestures = true
            myMap.settings.allowScrollGesturesDuringRotateOrZoom = true
        }
    }

    @IBAction func markOnMapByLocationBtn(_ sender: Any) {
        pointAlert(lat: userLocation!.latitude, long: userLocation!.longitude)
    }

    @IBAction func logout(_ sender: Any) {

    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        pointAlert(lat: coordinate.latitude, long: coordinate.longitude)
    }
    
    func pointAlert(lat: Double, long: Double)
    {
        let title = "Вы уверены что хотите отметить эту точку?"
        let message = "latidude: \(lat) \nlongitude: \(long)"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let accept = UIAlertAction(title: "Да", style: .default) { (alertAction: UIAlertAction) in
            ServerManager.Instance.createPoint(latitude: lat, longitude: long, completion: { (points) in
                self.points = points.values
                self.displayAllPoints()
            }, error: { (error) in
                print(error)
            })
        }
        let cancel = UIAlertAction(title: "Нет", style: .default, handler: nil)
        
        alert.addAction(cancel)
        alert.addAction(accept)
        
        present(alert, animated: true, completion: nil)
    }
    
    func displayAllPoints() {
        for point in points {
            let position = CLLocationCoordinate2D(latitude: point.latitude, longitude: point.longitude)
            let marker = GMSMarker(position: position)
            marker.title = "Осторожно ГАИ!"
            marker.icon = UIImage(named: "police")
            marker.map = self.myMap
        }
    }
    
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        marker.map = nil
        return true
    }
    
    
    func alertTheUser(title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "ОK", style: .default, handler: nil)
        
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }

}

