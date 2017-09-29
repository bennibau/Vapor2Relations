import Vapor

extension Droplet {
    func setupRoutes() throws {
        get("hello") { req in
            var json = JSON()
            try json.set("hello", "world")
            return json
        }

        get("plaintext") { req in
            return "Hello, world!"
        }

        // response to requests to /info domain
        // with a description of the request
        get("info") { req in
            return req.description
        }

        get("description") { req in return req.description }
        
        get("createCountry") { req in
            let germany = Country(name: "germany")
            let berlin = Capital(name: "Berlin")
            try germany.save()
            try berlin.save()
            
            germany.capital_id = berlin.id
            berlin.country_id = germany.id

            try germany.save()
            try berlin.save()
            
            return "success"
        }
        
        get("getCountry") {req in
            //gets the first country in the database
            let country = try Country.all().first!
            //gets the capital of that country
            let capital = try Capital.find(country.capital_id)!
            
            return "\(country.name) has the capital \(capital.name)"
        }
        
        try resource("posts", PostController.self)
    }
}
