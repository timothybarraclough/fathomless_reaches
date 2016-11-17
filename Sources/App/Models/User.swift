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

    var name : String
    var dateOfBirth : String
    var age : Int
    var petsNames : [String]?
    
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
    
    init(name: String, dateOfBirth: Date, petsNames : [String]? = nil) {
        self.id = nil
        self.name = name
        self.dateOfBirth = String(describing: dateOfBirth)
        self.age = dateOfBirth.yearsSinceDate()
        self.petsNames = petsNames
    }
    
    func updateFromUser(_ user: User) {
        self.name = user.name
        self.dateOfBirth = user.dateOfBirth
        self.age = user.age
        self.petsNames = user.petsNames
    }
    
    
}

extension Date {
    func yearsSinceDate() -> Int {
        let difference = Calendar.current.dateComponents([.year], from: self, to: Date())
        return difference.year ?? 0
    }
}

extension User : NodeRepresentable {

    func makeNode(context: Context) throws -> Node {

        return try Node(node : [
            "id" : id,
            "name" : name,
            "date_of_birth" : dateOfBirth,
            "pets_names" : petsNames?.makeNode(),
            "age" : age
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
