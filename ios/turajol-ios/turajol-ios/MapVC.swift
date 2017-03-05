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
        myMap.delegate = self
        getAllPoints()
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
            
            let camera = GMSCameraPosition.camera(withLatitude: userLocation!.latitude, longitude: userLocation!.longitude, zoom: 16)
            myMap.camera = camera
            
            myMap.isMyLocationEnabled = true
            myMap.settings.myLocationButton = true
            myMap.settings.zoomGestures = true
            myMap.settings.allowScrollGesturesDuringRotateOrZoom = true
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        createNewPointAlert(lat: coordinate.latitude, long: coordinate.longitude)
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        performMarkerAction(marker: marker)
        return true
    }

    @IBAction func markOnMapByLocationBtn(_ sender: Any) {
        createNewPointAlert(lat: userLocation!.latitude, long: userLocation!.longitude)
    }
    
    func displayAllPoints() {
        for point in points {
            if point.deleted_at == "" {
                let position = CLLocationCoordinate2D(latitude: point.latitude, longitude: point.longitude)
                let marker = GMSMarker(position: position)
                
                marker.title = "Осторожно ГАИ!"
                marker.icon = UIImage(named: "police")
                marker.userData = point.id
                marker.map = self.myMap
            }
        }
    }
    
    private func getAllPoints() {
        ServerManager.Instance.getAllPoints({ (points) in
            self.points = points.values
            self.displayAllPoints()
            
        }) { (error) in
            print(error)
        }
    }
    
    private func createPoint(lat: Double, long: Double) {
        ServerManager.Instance.createPoint(latitude: lat, longitude: long, completion: { (points) in
            self.alertTheUser(title: "Точка успешно добавлена")
            self.points = points.values
            self.displayAllPoints()
        }, error: { (error) in
            print(error)
        })
    }
    
    private func confirmPoint(withId: Int) {
        ServerManager.Instance.confirmPoint(withId: withId, completion: { (points) in
            self.points = points.values
            self.displayAllPoints()
        }) { (error) in
            print(error)
        }
    }
    
    private func deletePoint(withId: Int) {
        ServerManager.Instance.deletePoint(withId: withId, completion: { (points) in
            self.points = points.values
            self.displayAllPoints()
        }) { (error) in
            print(error)
        }
    }
    
    
    func createNewPointAlert(lat: Double, long: Double)
    {
        let title = "Вы уверены что хотите отметить эту точку?"
        let message = "latidude: \(lat) \nlongitude: \(long)"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let accept = UIAlertAction(title: "Да", style: .default) { (alertAction: UIAlertAction) in
            self.createPoint(lat: lat, long: long)
        }
        let cancel = UIAlertAction(title: "Нет", style: .default, handler: nil)
        
        alert.addAction(cancel)
        alert.addAction(accept)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    private func performMarkerAction(marker: GMSMarker) {
        let markerId = marker.userData as! Int
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let confirm = UIAlertAction(title: "Подтвердить точку", style: .default) { (action) in
            self.confirmPoint(withId: markerId)
            self.alertTheUser(title: "Точка успешна подтверждена")
        }
        let delete = UIAlertAction(title: "Удалить точку", style: .destructive) { (action) in
            marker.map = nil
            self.deletePoint(withId: markerId)
            self.alertTheUser(title: "Точка успешно удалена")
            marker.map = nil
        }
        let cancel = UIAlertAction(title: "Отмена", style: .default, handler: nil)
        
        alert.addAction(confirm)
        alert.addAction(delete)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    private func alertTheUser(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }

}


