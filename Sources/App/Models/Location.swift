//
//  Location.swift
//  VaporDemo
//
//  Created by Timothy Barraclough on 18/11/16.
//
//

import Foundation
import Vapor
import Fluent

final class Location : Model {
    
    // extension Entity {
        var exists = false
        var id : Node?
    // }
    
    var latitude : Float
    var longitude : Float
    var altitude : Float
    var attitude : Int
    var speed : Float
    
    init(node: Node, in context: Context) throws {
        self.id         = try node.extract("id")
        self.latitude   = try node.extract("latitude")
        self.longitude  = try node.extract("longitude")
        self.altitude   = try node.extract("altitude")
        self.attitude   = try node.extract("attitude")
        self.speed      = try node.extract("speed")
    }
    
    init(latitude: Float, longitude: Float, altitude: Float, attitude: Int = 0, speed: Float = 0.0) {
        self.id = nil
        self.latitude = latitude
        self.longitude = longitude
        self.altitude = altitude
        self.attitude = attitude
        self.speed = speed
    }
    
    func updateLocation(_ location : Location) {
        self.longitude = location.longitude
        self.latitude = location.latitude
        self.altitude = location.altitude
        self.attitude = location.attitude
        self.speed = location.speed
    }
}

extension Location : NodeRepresentable {
    
    func makeNode(context: Context) throws -> Node {
        
        return try Node(node : [
            "id" : id,
            "latitude" : latitude,
            "longitude" : longitude,
            "altitude" : altitude,
            "attitude" : attitude,
            "speed" : speed
            ])
    }
}

extension Location : JSONConvertible {
    
}
extension Location : Preparation {
    
    static func prepare(_ database: Database) throws {
        try database.create("locations") { location in
            location.id()
            location.double("latitude")
            location.double("longitude")
            location.double("altitude")
            location.int("attitude")
            location.double("speed")
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete("locations")
    }
    
}
