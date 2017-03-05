//
//  ServerManager.swift
//  turajol-ios
//
//  Created by Samatbek Osmonov on 3/5/17.
//  Copyright © 2017 Samatbek Osmonov. All rights reserved.
//

import Foundation

class ServerManager {
    private static var _instance = ServerManager()
    private init() {}
    
    static var Instance: ServerManager {
        return _instance
    }
    
}
