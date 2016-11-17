//
//  LocationController.swift
//  VaporDemo
//
//  Created by Timothy Barraclough on 18/11/16.
//
//

import Vapor
import HTTP

final class LocationController {
    
    func index(request: Request) throws -> ResponseRepresentable {
        return try Location.all().makeNode().converted(to: JSON.self)
    }
    
    func create(request: Request) throws -> ResponseRepresentable {
        
        var location = try request.location()
        try location.save()
        return location
        
    }
    
    func show(request: Request, location: Location) throws -> ResponseRepresentable {
        return location
    }
    
    func replace(request: Request, location: Location) throws -> ResponseRepresentable {
        try location.delete()
        return try create(request: request)
    }
    
    func update(request: Request, location: Location) throws -> ResponseRepresentable {
        var location = location
        location.updateLocation(try request.location())
        try location.save()
        return location
    }
    
    func delete(request: Request, location: Location) throws -> ResponseRepresentable {
        try request.location().delete()
        return JSON([])
    }
    
    func clear(request: Request) throws -> ResponseRepresentable {
        try Location.query().delete()
        return JSON([:])
    }
    
}

extension LocationController : ResourceRepresentable {
    func makeResource() -> Resource<Location> {
        return Resource(
            index: index,
            store: create,
            show: show,
            replace: replace,
            modify: update,
            destroy: delete,
            clear: clear
        )
    }
}

extension Request {
    func location() throws -> Location {
        guard let json = json else { throw Abort.badRequest }
        return try Location(node: json)
    }
}
