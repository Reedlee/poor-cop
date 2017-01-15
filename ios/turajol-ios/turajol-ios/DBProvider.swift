//
//  DBProvider.swift
//  turajol-ios
//
//  Created by Samatbek Osmonov on 1/12/17.
//  Copyright © 2017 Samatbek Osmonov. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DBProvider {
    private static let _instance = DBProvider()
    
    private init() {}
    
    static var Instance: DBProvider {
        return _instance
    }
    
    var dbRef: FIRDatabaseReference {
        return FIRDatabase.database().reference()
    }
    
    var mapPointRef: FIRDatabaseReference {
        return dbRef.child(Constants.MAP_POINTS)
    }
    
    
}
