//
//  ServerManager.swift
//  turajol-ios
//
//  Created by Samatbek Osmonov on 3/5/17.
//  Copyright © 2017 Samatbek Osmonov. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ServerManager {
    private static var _instance = ServerManager()
    private init() {}
    
    static var Instance: ServerManager {
        return _instance
    }
    
    private let url = "https://turajol.herokuapp.com/"
    
    private func get(_ api: String, completion: @escaping (JSON)-> Void, errorBlock: @escaping (String)-> Void) {

        let APIaddress =  "\(url)\(api)"
        let headers: HTTPHeaders = ["Accept": "application/json", "Content-type": "application/json"]
        
        Alamofire.request(APIaddress, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
            switch response.result {
            case.success:
                let encodedData = NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue)
                let json =  JSON.init(parseJSON: encodedData! as String)
                completion(json)
            case.failure(let error):
                errorBlock(error.localizedDescription)
            }
        }
    }
    
    private func post(_ api: String, parameters: [String: Any], completion: @escaping (JSON) -> Void, errorBlock: @escaping (String) -> Void) {
        
        let APIaddress = "\(url)\(api)"
        let headers: HTTPHeaders = ["Accept": "application/json", "Content-type": "application/json"]
        
        Alamofire.request(APIaddress, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (responce: DataResponse<Any>) in
            
            let statusCode = (responce.response?.statusCode)!
            let statusInt = statusCode / 100
    
            switch(statusInt) {
            case 2:
                let json = JSON(data: responce.data!)
                completion(json)
                break
            case 4:
                let json = JSON(data: responce.data!)
                if (!json.isEmpty) {
                    let message = json["message"].stringValue
                    errorBlock(message)
                } else {
                    errorBlock("Error with status code \(statusCode)")
                }
                break
            default:
                if let errorMessage = (responce.result.error?.localizedDescription) {
                    errorBlock(errorMessage)
                } else {
                    errorBlock("Error with status code \(statusCode)")
                }
                break
            }
            
        }
        
    }
    
    private func delete(_ api: String, completion: @escaping (JSON)-> Void, errorBlock: @escaping (String)-> Void)  {
        let APIaddress = "\(url)\(api)"
        let headers: HTTPHeaders = ["Accept": "application/json", "Content-type": "application/json"]
        
        Alamofire.request(APIaddress, method: .delete, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON { (response: DataResponse<Any>) in
            
            switch response.result {
            case.success:
                let encodedData = NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue)
                let json =  JSON.init(parseJSON: encodedData! as String)
                completion(json)
            case.failure(let error):
                errorBlock(error.localizedDescription)
            }
        }
    }
    
    func getAllPoints(_ completion: @escaping (Points) -> Void, error: @escaping (String) -> Void) {
        let api = ""
        self.get(api, completion: { (json) in
            let points = Points(json: json)
            completion(points)
        }, errorBlock: error)
    }
    
    func confirmPoint(withId: Int, completion: @escaping (Points) -> Void, error: @escaping (String) -> Void) {
        let api = "points/\(withId)/confirm/"
        self.get(api, completion: { (json) in
            let points = Points(json: json)
            completion(points)
        }, errorBlock: error)
    }
    
    func deletePoint(withId: Int, completion: @escaping (Points) -> Void, error: @escaping (String) -> Void) {
        let api = "points/\(withId)/"
        self.delete(api, completion: { (json) in
            let points = Points(json: json)
            completion(points)
        }, errorBlock: error)
    }

    
    func createPoint(latitude: Double, longitude: Double, completion: @escaping (Points) -> Void, error: @escaping (String) -> Void) {
        let api = "points/"
        let parameters: Parameters = ["point": [
                                "latitude":"\(latitude)",
                                "longitude":"\(longitude)"]]
        
        self.post(api, parameters: parameters, completion: { (json) in
            let points = Points(json: json)
            completion(points)
        }, errorBlock: error)
    }
    

}
