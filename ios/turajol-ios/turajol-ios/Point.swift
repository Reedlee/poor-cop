//
//  Point.swift
//  turajol-ios
//
//  Created by Samatbek Osmonov on 1/22/17.
//  Copyright © 2017 Samatbek Osmonov. All rights reserved.
//

import Foundation
class Point {
    
    private var _id: String!
    private var _latitude: Double!
    private var _longitude: Double!
    
    var id: String {
        return _id
    }
    
    var latitude: Double {
        return _latitude
    }
    
    var longitude: Double {
        return _longitude
    }
    
    init(id: String, latitude: Double, longitude: Double) {
        self._id = id
        self._latitude = latitude
        self._longitude = longitude
    }
    
}
