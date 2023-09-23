import Foundation
import MongoDBVapor

public struct BSONBuilder {
    private static func checkForNilValue(value: Double?) -> BSON {
        if let value = value {
            return BSON.double(value)
        } else {
            return BSON.null
        }
    }
    
    static func build(requestBody: RequestBody?) -> BSONDocument {
        let temp = checkForNilValue(value: requestBody?.temp)
        let co2 = checkForNilValue(value: requestBody?.co2Value)
        
        let bson: BSONDocument = [
            "values": [
                "id": BSON.objectID(BSONObjectID()),
                "timestamp": BSON.datetime(Date()),
                "co2Value": co2,
                "temp": temp
            ]
        ]
        return bson
    }
}
