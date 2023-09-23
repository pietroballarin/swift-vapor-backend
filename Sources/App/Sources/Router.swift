import Foundation
import MongoDBVapor
import Vapor

public struct Router {
    func getObjectById(req: Request) async throws -> AirQualityData {
        guard let userId = req.headers.first(name: "userid") else {
            throw Abort(.badRequest, reason: "Missing userid in headers")
        }
        
        let id = try BSONObjectID(userId)
        let documentToFind: BSONDocument = ["_id": BSON.objectID(id)]
        
        guard let data = try await req.airQualityCollection.findOne(documentToFind) else {
            throw Abort(.notFound)
        }
        return data
    }
    
    func createNewObject(req: Request) async throws -> Response {
        var newDoc = try req.content.decode(AirQualityData.self)
        let values = newDoc.values
        //newDoc.history.append(values)
        try await req.airQualityCollection.insertOne(newDoc)
        return Response(status: .created)
    }
    
    func updateObject(req: Request) async throws -> Response {
        guard let userId = req.headers.first(name: "userid") else {
            throw Abort(.badRequest, reason: "Missing userid in headers")
        }
        
        guard let doc = try req.content.decode(AirQualityData?.self) else {
            throw Abort(.custom(code: 0, reasonPhrase: "Failed to decode"))
        }
        
        let id = try BSONObjectID(userId)
        let requestBody = RequestBody(
            co2Value: doc.values.co2Value,
            temp: doc.values.temp
        )
        
        let documentToFind: BSONDocument = ["_id": BSON.objectID(id)]
        let updatedDocument = BSONBuilder.build(requestBody: requestBody)
        
        guard let _ = try await req.airQualityCollection.findOneAndUpdate(filter: documentToFind, update: updatedDocument) else {
            throw Abort(.notFound)
        }
        
        return Response(status: .ok)
    }
}
