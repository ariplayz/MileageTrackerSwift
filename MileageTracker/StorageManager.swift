import Foundation

struct StorageManager {
    static let recordsKey = "mileageRecords"
    static let vehiclesKey = "vehicles"

    static func saveRecords(_ records: [MileageRecord]) {
        if let data = try? JSONEncoder().encode(records) {
            UserDefaults.standard.set(data, forKey: recordsKey)
        }
    }

    static func loadRecords() -> [MileageRecord] {
        if let data = UserDefaults.standard.data(forKey: recordsKey),
           let records = try? JSONDecoder().decode([MileageRecord].self, from: data) {
            return records
        }
        return []
    }

    static func saveVehicles(_ vehicles: [Vehicle]) {
        if let data = try? JSONEncoder().encode(vehicles) {
            UserDefaults.standard.set(data, forKey: vehiclesKey)
        }
    }

    static func loadVehicles() -> [Vehicle] {
        if let data = UserDefaults.standard.data(forKey: vehiclesKey),
           let vehicles = try? JSONDecoder().decode([Vehicle].self, from: data) {
            return vehicles
        }
        return []
    }
}
