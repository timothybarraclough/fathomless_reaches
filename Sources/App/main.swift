import Vapor
import VaporPostgreSQL
import Foundation

let drop = Droplet(
    preparations:[User.self, Location.self],
    providers:[VaporPostgreSQL.Provider.self]
)

let locationController = LocationController()

drop.resource("places", locationController)


//drop.get { req in
//    return try drop.view.make("welcome", [
//    	"message": "Hello world"
//    ])
//}
//
//drop.get("create") { request in
//    
//    if let json = request.json {
//    
//        var user = try User(json: json)
//        try user.save()
//    }
//
//    return try JSON(node: User.all().makeNode())
//}
//
//drop.get("users") { request in
//    
//    return try JSON(node: User.all().makeNode())
//}



drop.run()
