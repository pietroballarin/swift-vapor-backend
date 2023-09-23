import Foundation

public struct RequestBody {
    let co2Value: Double?
    let temp: Double?
    
    init(co2Value: Double? = nil, temp: Double? = nil) {
        self.co2Value = co2Value
        self.temp = temp
    }
}
