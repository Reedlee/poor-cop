//
//  ViewController.swift
//  turajol-ios
//
//  Created by Samatbek Osmonov on 12/29/16.
//  Copyright © 2016 Samatbek Osmonov. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func loadView() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: 42.875599, longitude: 74.614180, zoom: 16.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.settings.compassButton = true
        mapView.settings.myLocationButton = true
        view = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 42.875599, longitude: 74.614180)
        marker.title = "ГАИ"
        marker.snippet = "Осторожно, в этом районе есть ГАИ"
        marker.map = mapView
        
        let circleCenter = CLLocationCoordinate2D(latitude: 42.875599, longitude: 74.614180)
        let circ = GMSCircle(position: circleCenter, radius: 400)
        circ.fillColor = UIColor(red:1.00, green:0.20, blue:0.20, alpha:0.4)
        circ.strokeWidth = 0
        circ.map = mapView
    }

}

