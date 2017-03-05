//
//  Points.swift
//  turajol-ios
//
//  Created by Samatbek Osmonov on 3/5/17.
//  Copyright © 2017 Samatbek Osmonov. All rights reserved.
//

import Foundation
import SwiftyJSON

class Point {
    var id: Int!
    var latitude: Double!
    var longitude: Double!
    var created_at: String!
    var updated_at: String!
    var deleted_at: String!
    var counter: Int!
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.latitude = json["latitude"].doubleValue
        self.longitude = json["longitude"].doubleValue
        self.created_at = json["created_at"].stringValue
        self.updated_at = json["updated_at"].stringValue
        self.deleted_at = json["deleted_at"].stringValue
        self.counter = json["counter"].intValue
        
    }
}

class Points {
    var values = [Point]()
    
    init(json: JSON) {
        let jsonPoints = json.arrayValue
        for jsonPoint in jsonPoints {
            let point = Point(json: jsonPoint)
            values.append(point)
        }
    }
}
