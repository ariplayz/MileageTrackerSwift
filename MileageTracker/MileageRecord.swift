import Foundation

struct MileageRecord: Identifiable, Codable {
    let id: UUID
    let date: Date
    let vehicleName: String
    let miles: Double
    let mpg: Double?
    let cost: Double?
    let description: String
    let category: String
}
