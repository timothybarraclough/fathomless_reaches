//
//  User.swift
//  VaporDemo
//
//  Created by Timothy Barraclough on 17/11/16.
//
//

import Vapor
import Fluent
import Foundation


final class User : Model {

    let name : String
    let dateOfBirth : String
    let age : Int
    let petsNames : [String]?
    
    // extension Entity {
        var exists = false
        var id : Node?
    // }
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        name = try node.extract("name")
        dateOfBirth = try node.extract("date_of_birth")
        petsNames = try node.extract("pets_names")
        age = try node.extract("age")
    }
}

extension User : NodeRepresentable {

    func makeNode(context: Context) throws -> Node {

        return try Node(node : [
            "id" : id,
            "name" : name,
            "date_of_birth" : dateOfBirth,
            "pets_names" : petsNames?.makeNode()
            ])
    }
}

extension User : JSONConvertible {
    
}

extension User : Preparation {
    
    static func prepare(_ database: Database) throws {
        try database.create("users") { user in
            user.id()
            user.string("name")
            user.string("date_of_birth")
            user.string("pets_names", optional: true)
            user.int("age")
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete("users")
    }
    
}
