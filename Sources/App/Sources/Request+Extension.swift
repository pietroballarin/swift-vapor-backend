import Foundation
import MongoDBVapor
import Vapor

extension Request {
    var airQualityCollection: MongoCollection<AirQualityData> {
        self.application.mongoDB.client.db("home").collection("air_quality_data", withType: AirQualityData.self)
    }
}
