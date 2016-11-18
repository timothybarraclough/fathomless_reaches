//
//  LocationDataRequest.swift
//  VaporDemo
//
//  Created by Timothy Barraclough on 18/11/16.
//
//

import Foundation
import Alamofire
import SwiftyJSON


extension Location {
    
    class func requestAllLocations(_ closure : @escaping ([Location]) -> ()) throws {
        Alamofire.request("https://fathomless-reaches-54516.herokuapp.com/places").validate().responseJSON { response in
            
            switch(response.result) {
            case .success(let value) :

                    let swiftyJSON = JSON(value)
                    closure(Location.fromJSONArray(swiftyJSON))                
            case .failure(let error) :
                print(error)
                    closure([])
            }
        }
    }
    
    class func requestSingleLocation(_ index: Int, _ closure : @escaping (Location?) -> ()) throws {
        Alamofire.request("https://fathomless-reaches-54516.herokuapp.com/places/\(index)").validate().responseJSON { response in
            
            switch(response.result) {
            case .success(let value) :
                
                let swiftyJSON = JSON(value)
                closure(Location.deserialize(swiftyJSON))
            case .failure(let error) :
                print(error)
                closure(nil)
            }
        }
        
    }

}

extension Location {
    static func fromJSONArray(_ json: SwiftyJSON.JSON ) -> [Location] {
        return json.arrayValue.map { deserialize($0) }
    }
    
    static func deserialize(_ json: SwiftyJSON.JSON ) -> Location {
        return Location(latitude: json["latitude"].floatValue,
                                longitude: json["longitude"].floatValue,
                                altitude: json["altitude"].floatValue,
                                attitude: json["attitude"].intValue,
                                speed: json["speed"].floatValue)
    }
}

//extension Data {
//    
//    func jayParsed() throws -> [Location] {
//        let v = [UInt8](self)
//        let json = try Jay().jsonFromData(v)
//        guard case .array(let array) = json else { return []}
//        return try Location.fromJSONArray(array)
//        
//    }
//}
