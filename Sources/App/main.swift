import Vapor
import VaporPostgreSQL
import Foundation

let drop = Droplet(
    preparations:[User.self],
    providers:[VaporPostgreSQL.Provider.self]
)

drop.get { req in
    return try drop.view.make("welcome", [
    	"message": "Hello world"
    ])
}

drop.get("add") { request in
    
    var user = User(name: "Gareth", dateOfBirth: Date(timeIntervalSince1970: 0))
    try user.save()

    return try JSON(node: User.all().makeNode())
}

drop.get("users") { request in
    
    return try JSON(node: User.all().makeNode())
}



drop.run()
