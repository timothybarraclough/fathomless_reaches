//
//  UserController.swift
//  VaporDemo
//
//  Created by Timothy Barraclough on 18/11/16.
//
//

import Vapor
import HTTP

final class UserController {
    
    func index(request: Request) throws -> ResponseRepresentable {
     return try User.all().makeNode().converted(to: JSON.self)
    }
    
    func create(request: Request) throws -> ResponseRepresentable {
        
        var u = try request.user()
        try u.save()
        return u
        
    }
    
    func show(request: Request, user: User) throws -> ResponseRepresentable {
        return user
    }
    
    func replace(request: Request, user: User) throws -> ResponseRepresentable {
        try user.delete()
        return try create(request: request)
    }
    
    func update(request: Request, user: User) throws -> ResponseRepresentable {
        var u = user
        u.updateFromUser(try request.user())
        try u.save()
        return u
    }
    
    func delete(request: Request, user: User) throws -> ResponseRepresentable {
        try request.user().delete()
        return JSON([])
    }
    
    func clear(request: Request) throws -> ResponseRepresentable {
        try User.query().delete()
        return JSON([:])
    }
    
}

extension UserController : ResourceRepresentable {
    func makeResource() -> Resource<User> {
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
    func user() throws -> User {
        guard let json = json else { throw Abort.badRequest }
        return try User(node: json)
    }
}
