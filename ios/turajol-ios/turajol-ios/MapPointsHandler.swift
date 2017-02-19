//
//  MapPointsHandler.swift
//  turajol-ios
//
//  Created by Samatbek Osmonov on 1/15/17.
//  Copyright © 2017 Samatbek Osmonov. All rights reserved.
//

import Foundation
import FirebaseDatabase


protocol MapPointsController: class {
    func showNewPointOnMap(latitude: Double, longitude: Double)
}

class MapPointsHandler {
    private static let _instance = MapPointsHandler()
    
    private init() {}
    
    static var Instance: MapPointsHandler {
        return _instance
    }
    
    
    var points = [Point]()
    
    weak var delegate: MapPointsController?
    
    // New point on map
    
    func observePoints() {
        DBProvider.Instance.mapPointRef.observe(FIRDataEventType.childAdded) { (snapshot: FIRDataSnapshot) in
            if let data = snapshot.value as? NSDictionary {
                if let lat = data[Constants.LATITUDE] as? Double {
                    if let long = data[Constants.LONGITUDE] as? Double {
                        self.delegate?.showNewPointOnMap(latitude: lat, longitude: long)
                        let point = Point(id: snapshot.key, latitude: lat, longitude: long)
                        self.points.append(point)
                    }
                }
            }
        }
    }
    
    func markPoint(latitude: Double, longitude: Double) {
        let data: Dictionary<String,Any> = [Constants.LATITUDE: latitude, Constants.LONGITUDE: longitude]
        DBProvider.Instance.mapPointRef.childByAutoId().setValue(data)
    }
    
    
}
