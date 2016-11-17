import Vapor
import VaporPostgreSQL

let drop = Droplet(
    preparations:[User.self],
    providers:[VaporPostgreSQL.Provider.self]
)

drop.get { req in
    return try drop.view.make("welcome", [
    	"message": "Hello world"
    ])
}

drop.resource("posts", PostController())

drop.run()
