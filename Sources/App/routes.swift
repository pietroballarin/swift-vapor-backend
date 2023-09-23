import MongoDBVapor
import Vapor

func routes(_ app: Application) throws {
    let router = Router()
    
    app.get { req async throws -> [AirQualityData] in
        try await req.airQualityCollection.find().toArray()
    }
    
    app.get("object", use: router.getObjectById)
    app.post("object", use: router.createNewObject)
    app.put("object", use: router.updateObject)
}

