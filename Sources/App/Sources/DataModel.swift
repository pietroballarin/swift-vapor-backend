import Foundation
import MongoDBVapor
import Vapor

struct AirQualityValues: Content {
    var id: BSONObjectID?
    var timestamp: Date?
    var co2Value: Double?
    var temp: Double?
}

struct AirQualityData: Content {
    let _id: BSONObjectID?
    var values: AirQualityValues
    //var history: [BSONDocument]
}
