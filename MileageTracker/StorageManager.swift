import Foundation

struct StorageManager {
    static let recordsKey = "mileageRecords"
    static let vehiclesKey = "vehicles"
    static let categoriesKey = "categories"
    static let lastSelectedVehicleKey = "lastSelectedVehicle"

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

    static func saveCategories(_ categories: [String]) {
        UserDefaults.standard.set(categories, forKey: categoriesKey)
    }

    static func loadCategories() -> [String] {
        return UserDefaults.standard.stringArray(forKey: categoriesKey) ?? []
    }

    static func saveLastSelectedVehicle(_ vehicle: Vehicle?) {
        if let vehicle = vehicle, let data = try? JSONEncoder().encode(vehicle) {
            UserDefaults.standard.set(data, forKey: lastSelectedVehicleKey)
        }
    }

    static func loadLastSelectedVehicle() -> Vehicle? {
        if let data = UserDefaults.standard.data(forKey: lastSelectedVehicleKey),
           let vehicle = try? JSONDecoder().decode(Vehicle.self, from: data) {
            return vehicle
        }
        return nil
    }
}
