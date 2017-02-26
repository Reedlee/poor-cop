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
    
    var usersRef: FIRDatabaseReference {
        return dbRef.child(Constants.USERS)
    }
    
    func saveUser(withID: String, email: String, password: String) {
        let data: Dictionary<String, String> = [Constants.EMAIL: email, Constants.PASSWORD: password]
        
        usersRef.child(withID).child(Constants.DATA).setValue(data)
    }
    
    
}
